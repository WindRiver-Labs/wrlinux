#!/bin/bash
#
# Create docker images and start containers which is listed in config file $container_info
# It also supports 2 parameters for containers configured in $container_conf
#	WR_DOCKER_PARAMS
# 	WR_DOCKER_START_COMMAND
# If configures have been updated, new containers will be started with new configures.
# Old containers are deprecated but still exists and renamed with current date and time.

container_info="/etc/wr-containers/containers_to_run.txt"
container_conf="/etc/wr-containers/containers.conf"
container_conf_stamp="/var/etc/wr-containers/containers.conf.stamp"

conf_updated=false

declare -A configs

get_configs() {
	if [ $# -lt 1 ]; then
		return
	fi

	container_name=$1

	# const EMPTY is used to handle empty value of WR_DOCKER_PARAMS_${container}
	# which overrides WR_DOCKER_PARAMS
	docker_params=${configs["WR_DOCKER_PARAMS_${container_name}"]}
	if [ -z "$docker_params" ]; then
		docker_params=${configs["WR_DOCKER_PARAMS"]}
	fi
	if [ "$docker_params" = "EMPTY" ]; then
		docker_params=
	fi

	start_command=${configs["WR_DOCKER_START_COMMAND_${container_name}"]}
	if [ -z "$start_command" ]; then
		start_command=${configs["WR_DOCKER_START_COMMAND"]}
	fi
	if [ -z "$start_command" ]; then
		start_command=/bin/bash
	fi
	if [ "$start_command" = 'EMPTY' ]; then
		start_command=
	fi
}

# check whether config file updated
if [ -f $container_conf ]; then
	# parse config file
	while IFS='=' read -r key value; do
		if [[ "$key" =~ ^$ || "$key" =~ ^# ]]; then
			continue
		fi

		# strip quotes at begin and end
		value=$(echo $value | sed -E -e 's/^['\''"]+//g' -e 's/['\''"]+$//g')

		if [ -z "$value" ]; then
			value=EMPTY
		fi

		configs[$key]="$value"
	done < $container_conf

	cur_stmp=`stat -c %Y $container_conf`
	if [ -f $container_conf_stamp ]; then
		stamp=`cat $container_conf_stamp`
		if [ "$stamp" -ne "$cur_stmp" ]; then
			conf_updated=true
		fi
	else
		mkdir -p `dirname $container_conf_stamp`
		echo $cur_stmp >$container_conf_stamp
	fi
fi


# get container info
readarray data <${container_info}
names=(${data[0]})
prios=(${data[1]})
container_dir="${data[2]}"

columns=`mktemp /tmp/columns-XXXXXX`
sorted=`mktemp /tmp/sorted-XXXXXX`

trap "rm -f $columns $sorted" EXIT

for (( i=0; i<${#names[@]}; i++ ))
do
    echo "${names[$i]} ${prios[$i]}" >> $columns
done

sort -k2 $columns >> $sorted

# Quit if any container involved has been started
while IFS= read -r line
do
	str="$line"
	arr=($str)
	container_name=`basename ${arr[0]}`

	container_id=`docker ps -a --filter=name=^$container_name$ --format {{.ID}}`
	if [ -n "$container_id" ]; then
		# if container is running, do nothing
		running=`docker inspect -f '{{.State.Running}}' $container_name`
		if [ "$running" = "true" ]; then
			echo "Container $container_name has been started already."
			exit 1
		fi
	fi
done < $sorted


while IFS= read -r line
do
	str="$line"
	arr=($str)
	container_name=`basename ${arr[0]}`

	get_configs $container_name

	container_id=`docker ps -a --filter=name=^$container_name$ --format {{.ID}}`
	if [ -n "$container_id" ]; then
		if $conf_updated; then
			echo "Configure updated. Start a new container $container_name with updated configure."
			curtime=`date +%Y%m%d%H%M`
			docker rename $container_name ${container_name}_$curtime

			docker run -it -d --name ${container_name} ${docker_params} ${container_name} ${start_command}
			errno=$?
			if [ $errno -ne 0 ]; then
				echo "Failed to start container $container_name: $errno"
				docker rm $container_name
				exit $errno
			fi
		else
			echo -n "Starting container $container_name: "
			docker start $container_id
		fi
	else
		image_id=`docker images $container_name --format {{.ID}}`
		if [ -z "$image_id" ]; then
			container_path=`ls -1 ${container_dir}/${container_name}*.tar.bz2 | head -1`
			docker import ${container_path} ${container_name}
			if [ $? -ne 0 ]; then
				echo "Failed to import image $container_name"
				exit 2
			fi
		fi

		docker run -it -d --name ${container_name} ${docker_params} ${container_name} ${start_command}
		errno=$?
		if [ $errno -ne 0 ]; then
			echo "Failed to start container $container_name: $errno"
			docker rm $container_name
			exit $errno
		fi
	fi
done < $sorted


echo $cur_stmp >$container_conf_stamp
