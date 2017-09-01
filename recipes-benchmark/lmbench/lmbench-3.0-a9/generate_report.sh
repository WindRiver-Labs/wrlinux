#!/bin/bash
##Upload test results to database server
TEST_ROOT=$(readlink -f `dirname $0`)
DEALT_TEST_LOGS="$TEST_ROOT/dealt_logs"
REPORTS="$TEST_ROOT/report.txt"
source ${TEST_ROOT}/scripts/sysinfo_lib.sh
function help(){
	echo "usage:generate_report.sh -d <log_dir>"
}

f_print_env ()
{
##Display the related Test ENv for USERS
        echo ==========
        echo "ENVIRONMENT INFORMATION"
        echo "Kernel info:" 
        echo "${KERNEL_INFO}"
        echo ""
        echo "NIC driver info:"
        echo "${NET_INFO}"
        echo ""
        echo "GLIBC info:"
        echo "${GLIBC_INFO}"
        echo ""
        echo "Compiler:"
        echo "${COMPILER_INFO}"
        echo ""
        echo "CPU info:"
        echo "${CPU_INFO}"
        echo ""
        echo "System memory:"
        echo ${MEM_INFO}
        echo ""
        echo "ENVIRONMENT INFORMATION END"
        echo ==========
}

                      

[ "$#" -lt 2 ] && help && exit 1
while getopts h:d: arg
do
  case $arg in
        d) TEST_LOGS=$OPTARG;;
        h) usage; exit;;
        *) echo "Invalid option: $arg"; usage; exit;;
  esac
done
[ -d "$TEST_LOGS" ] || { echo "$TEST_LOGS: No such directory"; exit 1; }
TEST_LOGS=$(readlink -f $TEST_LOGS)
$TEST_ROOT/dealt_log.sh  $TEST_LOGS $DEALT_TEST_LOGS

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
#echo "Check test config ..."
#source $TEST_RUN_CONFIG
case_name="lmbench"

##Check test results
echo "Check test results ..."
if [ ! -f "$DEALT_TEST_LOGS/DEALT" ]; then
   echo "Please handle original test logs before upload."
   [ -f ${TEST_ROOT}/dealt_log.sh ] && \
   echo "Execute command:"; \
   echo " ${TEST_ROOT}/dealt_log.sh \$TEST_LOGS \$DEALT_TEST_LOGS"
   exit 1
fi

##Check test environment info
echo "Check test env ..."
[ -f "$DEALT_TEST_LOGS/test_env" ] && source $DEALT_TEST_LOGS/test_env
check_test_env
[ $? -ne 0 ] && { echo "Please check test environment..."; exit 1; }

f_print_env > $REPORTS
#Transfer test logs to xml file
echo "Creating report ..."
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
	datas=`echo $data | sed 's/|/ /g'`
	data_sum=0
	data_ave=0
	loop_num=0
	for i in $datas; do
		loop_num=`expr $loop_num + 1`
		data_sum="`echo "${data_sum}+${i}" | bc`"
	done
	data_ave="`echo "scale=4;${data_sum}/${loop_num}" | bc`"
	#f_print_env > $REPORTS
	echo =================================  >>$REPORTS
        echo ${item}  >>$REPORTS
        echo ================================= >>$REPORTS
	echo "group: ${group}" >>$REPORTS
	echo "item: ${item}" >>$REPORTS
	echo "unit: ${UNIT}" >>$REPORTS
	echo "loop num: ${loop_num}" >>$REPORTS
	echo "data_ave: ${data_ave}" >>$REPORTS

	
	#f_create_xml "$item" "$item_id" "$group" "$group_id" "$UNIT" "$better" "$data"
done
popd &> /dev/null

##Upload test results to benchmark database server

rm -rf $DEALT_TEST_LOGS
echo "Done."
exit 0
