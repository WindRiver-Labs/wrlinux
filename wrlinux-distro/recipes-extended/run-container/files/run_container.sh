#!/bin/bash

container_info="/etc/wr-containers/containers_to_run.txt"

readarray data <${container_info}
names=(${data[0]})
prios=(${data[1]})
container_dir="${data[2]}"

columns=`mktemp /tmp/columns-XXXXXX`
sorted=`mktemp /tmp/sorted-XXXXXX`


for (( i=0; i<${#names[@]}; i++ ))
do
    echo "${names[$i]} ${prios[$i]}" >> $columns
done

sort -k2 $columns >> $sorted

while IFS= read -r line
do
	str="$line"
	arr=($str)
	container_name=`basename ${arr[0]}`

	container_id=`docker ps -a --filter=name=$container_name --format {{.ID}}`
	if [ -n "$container_id" ]; then
		docker start $container_id
	else
		container_path=`ls -1 ${container_dir}/${container_name}*.tar.bz2 | head -1`
		docker import ${container_path} ${container_name} &&
		docker run -it -d --name ${container_name} ${container_name} /bin/bash || exit $?
	fi
done < $sorted

rm $sorted $columns
