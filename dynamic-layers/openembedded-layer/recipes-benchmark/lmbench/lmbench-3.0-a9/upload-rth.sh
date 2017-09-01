#!/bin/bash
##Upload test results to database server
TEST_ROOT=$(readlink -f `dirname $0`)
source ${TEST_ROOT}/scripts/sysinfo_lib.sh

#getopts
[ "$#" -lt 5 ] && usage && exit 1
while getopts hc:d:p:s: arg
do
  case $arg in
	c) TEST_RUN_CONFIG=$OPTARG;;
        d) DEALT_TEST_LOGS=$OPTARG;;
	s) BENCHMARK_DB_URL=$OPTARG;;
	p) project_name=$OPTARG;;
        h) usage; exit;;
        *) echo "Invalid option: $arg"; usage; exit;;
  esac
done

[ -r "$TEST_RUN_CONFIG" ] || { echo "TEST_RUN_CONFIG: File is not exist or unreadable"; exit 1; }
[ -d "$DEALT_TEST_LOGS" ] || { echo "DEALT_TEST_LOGS: No such directory"; exit 1; }
DEALT_TEST_LOGS=$(readlink -f $DEALT_TEST_LOGS)

TEST_CASE_CONF="${TEST_ROOT}/config/default_case_conf"
[ -r "$TEST_CASE_CONF" ] || { echo "TEST_CASE_CONF: File is not exist or unreadable"; exit 1; }
TEST_GROUP_CONF="${TEST_ROOT}/config/default_group_conf"
[ -r "$TEST_GROUP_CONF" ] || { echo "TEST_GROUP_CONF: File is not exist or unreadable"; exit 1; }

TEMP_XML_DIR="/tmp/XMLs"
mkdir -p $TEMP_XML_DIR || { echo "Can't create temp dir: $TEMP_XML_DIR"; exit 1;}

if [ X"$BENCHMARK_DB_URL" = X ]; then
  BENCHMARK_DB_URL=128.224.163.19/benchmark/upload.php
  echo "BENCHMARK_DB_URL is not set, use default one:"
  echo "$BENCHMARK_DB_URL"
fi

##Check test run config file
echo "Check test config ..."
source $TEST_RUN_CONFIG
: ${case_name:?"case_name is not set or empty"}
: ${board:?"board is not set or empty"}
: ${test_id:?"test_id is not set or empty"}

##Check test results
echo "Check test results ..."
if [ ! -f "$DEALT_TEST_LOGS/DEALT" ]; then
   echo "Please handle original test logs before upload."
   [ -f ${TEST_ROOT}/dealt_log.sh ] && \
   echo "Execute command:"; \
   echo " ${TEST_ROOT}/dealt_log.sh \$ORIG_LOG_DIR \$DEALT_LOG_DIR"
   exit 1
fi

##Check test environment info
echo "Check test env ..."
[ -f "$DEALT_TEST_LOGS/test_env" ] && source $DEALT_TEST_LOGS/test_env
check_test_env
[ $? -ne 0 ] && { echo "Please check test environment..."; exit 1; }

#Transfer test logs to xml file
echo "uploading data to rth ..."
pushd $DEALT_TEST_LOGS &> /dev/null || { echo "Failed to enter dir: $DEALT_TEST_LOGS"; exit 1; }
LOGS=`ls *.log`
for i in $LOGS; do
	item="`echo $i|sed 's/\.log//'`"
	group="`awk -F":" '{if($1=="'$item'") print $2}' $TEST_CASE_CONF`"
	[ X"$group" == X ] && { echo "No group name for item(test case): $item"; exit 1; }
        item_id="`awk -F":" '{if($1=="'$item'") print $3}' $TEST_CASE_CONF`"
	[ X"$item_id" == X ] && { echo "No item_id for item: $item"; exit 1; }
	group_id="`cat $TEST_GROUP_CONF | grep "$group" | awk -F":" '{print $2}'`"
	[ X"$group_id" == X ] && { echo "No group_id for group: $group"; exit 1; }
	UNIT=`cat $i | sed -n '1p' | awk '{print $2}'`
	better=""
	if [ X"$UNIT" == X"MB/sec" ]; then
		better="$THE_BIGGER_THE_BETTER"
	else
		better="$THE_SMALLER_THE_BETTER"
	fi

	DATA=`cat $i | awk '{print $1 "|"}' |sed 's/\n//g'`
	data=`echo $DATA | sed 's/ *//g' | sed 's/|$//'`
	keyword=""
	if test $better == 1; then
		keyword="big"
	else
		keyword="small"
	fi
##########################################
#create hardware info text
#########################################
NETWORK_INFO=`echo $NET_INFO | sed 's/|/ ROR /g'`
echo OS=$OS_INFO >hardwarefile.txt
echo CPU=$CPU_INFO >>hardwarefile.txt
echo ARCH=$MACHINE_INFO >>hardwarefile.txt
echo MEMORY=$MEM_INFO >>hardwarefile.txt
echo KERNEL=$KERNEL_INFO >>hardwarefile.txt
echo NETWORK=$NETWORK_INFO >>hardwarefile.txt
echo COMPILER=$COMPILER_INFO >>hardwarefile.txt
echo GLIBC=$GLIBC_INFO >>hardwarefile.txt


	curl -F tester="fli" \
	-F feature="Benchmark" \
	-F sub_project_name="$project_name" \
	-F environment="$test_id" \
	-F casename="$case_name" \
	-F subcasename="$group" \
	-F item="$item" \
	-F value="$data" \
	-F target="$board" \
	-F spin="$spin" \
	-F unit="$UNIT" \
	-F bsp="$bsp" \
	-F kernel="$kernel" \
	-F rootfs="$rootfs" \
	-F keyword="$keyword" \
	-F hardwareinfo=@hardwarefile.txt \
	http://128.224.153.104/new_rth/detailed_add_nologin_benchmark.php
#	XML_FILE="${TEMP_XML_DIR}/${item}.xml"
#	f_create_xml "$item" "$item_id" "$group" "$group_id" "$UNIT" "$better" "$data"
done
popd &> /dev/null


rm -rf $TEMP_XML_DIR
echo "Done."
exit 0
