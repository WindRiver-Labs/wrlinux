#!/bin/sh

# Copyright (c) 2013 Wind River Systems, Inc.
# description : This suite is developed for Networking CGL4.0 test.But not all CGL4.0 feature are included in this suite.
# 		You do not need input any options when execute this scripts.
# 		You can check the test result and log by reading testresult and testlog under the same directory. 
#		CGL5.0 tests are adopted from CGL4.0
# developer : Chi Xu <chi.xu@windriver.com>
# 
# changelog 
# 2013-01-16 <amy.fong@windriver.com>
#    - more cleanup
# 2010-01-12 <greg.moffatt@windriver.com>
#    - cleaned up output to make it suitable for external users
# * create test case group,  <yongli.he@windrive.com>
# * make test case can put anywhere <yongli.he@windrive.com>
# -

TESTCASE=

# As kdump cases need to reboot two times to complete the 
# whole case, we print the last test result in a file 
# /opt/cut/kdump.tmp/test_${kdump_case}_report such as
# /opt/cut/kdump.tmp/test_sfa.3.0_report for user 
# to check the final result
KDUMP_CASE="\
    sfa.3.0 sfa.4.0 sfa.10.0 sfa.1.0 cdiag.2.2
    "

# prepare CGL4 test case 
CGL4_TESTCASE="\
	avl.4.1 avl.5.3 avl.6.0 avl.7.1 avl.22.0 avl.23.0 avl.26.0 avl.28.1 \
	cdiag.2.2 cdiag.2.3 \
	prf.1.6 prf.1.7 prf.2.1 prf.2.2 prf.2.3 prf.4.2 prf.7.0 prf.14.0 \
	sec.1.1 sec.1.2 sec.1.3 sec.1.4 sec.2.1 sec.2.2 sec.3.3 sec.3.4 sec.4.4 \
	sec.4.1 sec.4.2 sec.4.3 sec.4.6 sec.7.1 sec.9.1 sec.11.1 \
	smm.3.1 smm.4.0 smm.7.1 smm.7.4 smm.7.5 smm.7.6 smm.7.7 smm.9.0 smm.13.0 \
	spm.2.1 spm.3.0 \
	std.3.1 sfa.1.0 sfa.2.1 sfa.2.2 sfa.3.0 sfa.4.0 sfa.8.0 sfa.10.0 \
	avl.21.1 avl.24.0 avl.25.0 avl.28.2 avl.28.3\
	csm.1.0 csm.4.0 \
	prf.1.4 prf.5.0 prf.6.0 \
	sec.1.5 sec.3.1 sec.3.2 sec.3.5 sec.4.5 sec.5.1 sec.7.2 sec.7.3\
	smm.3.2 smm.7.2 smm.7.3 smm.8.1 smm.8.2 smm.12.0 smm.17 smm.18 \
	spm.1.0 \
	std.4.1 std.5.1 std.9.0 std.17.1 std.17.2 std.17.3 \
	std.6.1 std.8.8 std.26.1 std.26.2 cfh.2.0 caf.2.1 caf.2.2 \
	"
tmp=
for i in $CGL4_TESTCASE; do
	tmp="${tmp}testcase/$i "
done
CGL4_TESTCASE=$tmp

# std.10.0: 802.1Q
# std.16.0: pci express
# prepare kernel testcase 
KERNEL_TESTCASE="\
	scripts/coredump_test.sh \
	scripts/cyclic-test \
	scripts/tmpfs.sh \
	scripts/bonding.sh \
	testcase/std.10.0 \
	testcase/std.16.0 \
	scripts/kexec-test.sh \
	"

# prepare rootfs testcase
ROOTFS_TESTCASE="\
	scripts/logcheck.sh \
	scripts/iscsi.sh \
	scripts/ocfs2.sh \
	scripts/snmp.sh \
	scripts/gdb.sh \
	scripts/perf.sh \
	scripts/selinux.sh \
	"

# prepare reboot testcase
REBOOT_TESTCASE="scripts/reboot.sh"


#################################
# process config select
select_config()
{
	case $1 in
	kernel)
		TESTCASE=$KERNEL_TESTCASE
		;;
	rootfs)
		TESTCASE=$ROOTFS_TESTCASE
 		;;
	reboot)
		TESTCASE=$REBOOT_TESTCASE
		;;
	cgl4)
		TESTCASE=$CGL4_TESTCASE
		;;
	all)
		TESTCASE=$REBOOT_TESTCASE
		TESTCASE="${TESTCASE} $ROOTFS_TESTCASE"
		TESTCASE="${TESTCASE} $KERNEL_TESTCASE"
		TESTCASE="${TESTCASE} $CGL4_TESTCASE" # temporarily
		;;
	*)
		usage
		;;
	esac
}


RES_COL=70
MOVE_TO_COL="echo -en \\033[${RES_COL}G"
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
SETCOLOR_NOTRUN="echo -en \\033[1;33m"

export CUTDIR=/opt/cut
CUT_LOGFILE="`pwd`/testlog-$(date +"%b-%d-%y-%H:%M").log"
export CUT_LOGFILE
RESULTLOG="`pwd`/testresult-$(date +"%b-%d-%y-%H:%M").log"
ALLNUM=0
NOTRUNNUM=0
PASSNUM=0
FAILNUM=0

usage()
{
	cat <<EOT;
cgl_test.sh [options]
 
Default: execute all testcases

Parameters:
 -e <comma delimited test cases to execute>
         ./cgl_test.sh -e sec.3.4,sec.4.4,smm.11.0
 -f <file specifiying testcases to execute>
         ./cgl_test.sh -f ~/sectest
      ~/sectest:
         sec.3.4 sec.4.4 sec.4.6 sec.7.1
 -c <kernel|rootfs|reboot|cgl4|all>
      execute all testcases in the specified group
         ./cgl_test.sh -c kernel
 -x <comma delimited test cases to skip>
         ./cgl_test.sh -x sec.3.4,sec.4.4,smm.11.0
 -l
      do not run tests, just list them
 -h
      print this message
 
Note: Only one of e/f/c can be specified
EOT
	exit
}

pass()
{
	$MOVE_TO_COL | tee -a $RESULTLOG
	echo -n '[  ' | tee -a $RESULTLOG
	$SETCOLOR_SUCCESS | tee -a $RESULTLOG
	echo -n PASS | tee -a $RESULTLOG
	$SETCOLOR_NORMAL |tee -a $RESULTLOG
	echo '  ]' | tee -a $RESULTLOG
	PASSNUM=`expr $PASSNUM + 1`
	ALLNUM=`expr $ALLNUM + 1`
}

fail()
{
	$MOVE_TO_COL | tee -a $RESULTLOG
	echo -n '[  ' | tee -a $RESULTLOG
	$SETCOLOR_FAILURE | tee -a $RESULTLOG
	echo -n FAIL | tee -a $RESULTLOG
	$SETCOLOR_NORMAL | tee -a $RESULTLOG
	echo '  ]' | tee -a $RESULTLOG
	FAILNUM=`expr $FAILNUM + 1`
	ALLNUM=`expr $ALLNUM + 1`
}

notrun()
{
	$MOVE_TO_COL | tee -a $RESULTLOG
	echo -n '[ ' | tee -a $RESULTLOG
	$SETCOLOR_NOTRUN | tee -a $RESULTLOG
	echo -n "  N/A " | tee -a $RESULTLOG
	$SETCOLOR_NORMAL | tee -a $RESULTLOG
	echo ' ]' | tee -a $RESULTLOG
	NOTRUNNUM=`expr $NOTRUNNUM + 1`
	ALLNUM=`expr $ALLNUM + 1`
}




# locate_testcase casename , returen testcase with the path
ALL_TESTCASE=$CGL4_TESTCASE
ALL_TESTCASE="${ALL_TESTCASE} $KERNEL_TESTCASE"
ALL_TESTCASE="${ALL_TESTCASE} $ROOTFS_TESTCASE"
ALL_TESTCASE="${ALL_TESTCASE} $REBOOT_TESTCASE"

search_testcase() 
{
	count=0
	for case in $ALL_TESTCASE; do 
		t=$(basename $case)
		if [ "$t" = "$1" ]; then
			count=1
			echo -n " $case " >> /tmp/testcase
		fi
	done
	if [ "$count" = "0" ]; then
		echo "Cannot find testcase $1, aborting"
		exit
	fi
}

if [ -f /tmp/testcase ]; then
	rm -f /tmp/testcase
fi

selected_cases=0
list_only=0

while getopts "e:f:c:x:lh" opt; do
	case $opt in
	e)
		if [ $selected_cases -ne 0 ]; then usage; fi
		selected_cases=1
		list_of_tests=`echo $OPTARG | tr "," " "`
		;;
	f)
		if [ $selected_cases -ne 0 ]; then usage; fi
		selected_cases=1
		list_of_tests=`cat $OPTARG`
		;;
	c)
		if [ $selected_cases -ne 0 ]; then usage; fi
		selected_cases=2
		config_type=$OPTARG
		;;
	x)
		do_not_run=`echo $OPTARG | tr "," " "`
		;;
	l)
		list_only=1
		;;
	*)
		usage
		;;
	esac
done

if [ $selected_cases -eq 1 ]; then
	for t in $list_of_tests; do
		search_testcase $t
	done 
	if [ -f /tmp/testcase ]; then
		TESTCASE=`cat /tmp/testcase`
		rm -rf /tmp/testcase
	else
		usage
	fi
else
	if [ $selected_cases -eq 0 ]; then
		config_type="all"
		echo "Execute all testcases..."
	fi
	select_config $config_type
fi
for i in $TESTCASE; do
	case=$(basename $i)
	
	run_test=1
	for x in $do_not_run; do
		if [ "$case" = "$x" ]; then
			run_test=0
		fi
	done
	if [ $run_test -eq 1 ]; then 
		TMP_TESTCASE="$TMP_TESTCASE $i"
	fi
done
TESTCASE=$TMP_TESTCASE

rm -f $CUT_LOGFILE $RESULTLOG

echo "==============================================================" | tee -a $RESULTLOG
echo "          Networking CGL5.0 Registration Test Suite           " | tee -a $RESULTLOG
echo "==============================================================" | tee -a $RESULTLOG

for i in $TESTCASE
do
	CASENAME=`grep description $CUTDIR/$i | cut -d: -f 2`

	if [ $list_only -eq 1 ];then
		echo "----------------------------------------" >> $CUT_LOGFILE
		echo "testcase $CASENAME"
		echo "----------------------------------------" >> $CUT_LOGFILE
		continue
	fi
    
	# guide the user to find the final result for the kdump cases
	for kdump_case in $KDUMP_CASE
	do
		if [ "$i" = "testcase/$kdump_case" ]; then
			echo "If you don't find the final result on the screen,"
			echo "Please check the file /opt/cut/kdump.tmp/test_${kdump_case}_report"
			echo "to get the final result as this case needs system"
			echo "to reboot."
			break
		fi
		continue
	done

	# check if std.4.1
	if [ "$i" = "testcase/std.4.1" ]; then
		echo "Only do a basic test for std.4.1 about Ipv6 base"
		echo "features. If you need more deeper ipv6 test, please"
		echo "setup your test environment via TAHI by yourself."
	fi

	echo -n $CASENAME | tee -a $RESULTLOG
	echo >> $CUT_LOGFILE
	echo "----------------------------------------" >> $CUT_LOGFILE
	echo "Start testcase $CASENAME" >> $CUT_LOGFILE
	echo "----------------------------------------" >> $CUT_LOGFILE
	ls $CUTDIR/$i 2>&1 | grep $i > /dev/null
	if [ $? -ne 0 ]
	then
		$MOVE_TO_COL | tee -a $RESULTLOG
		echo "Can not find testcase" | tee -a $RESULTLOG
		NOTRUNNUM=`expr $NOTRUNNUM + 1`
		ALLNUM=`expr $ALLNUM + 1`
		continue
	fi
	$CUTDIR/$i 1>> $CUT_LOGFILE 2>> $CUT_LOGFILE
	RESULT=$?
	if [ $RESULT -eq 0 ]
	then
		pass 
		cat $CUTDIR/cover.conf | cut -d: -f 1 | grep $i > /dev/null
		if [ $? -eq 0 ]
		then
			COVERED=`cat $CUTDIR/cover.conf | grep "$i:" | cut -d: -f 2`
			for j in $COVERED
			do
				CASENAME=`grep description $CUTDIR/$j | cut -d: -f 2`
				echo -n $CASENAME | tee -a $RESULTLOG
				pass 
			done
		fi	
	elif [ $RESULT -eq 1 ]
	then
		notrun
		cat $CUTDIR/cover.conf | cut -d: -f 1 | grep $i > /dev/null
		if [ $? -eq 0 ]
		then
			COVERED=`cat $CUTDIR/cover.conf | grep "$i:" | cut -d: -f 2`
			for j in $COVERED
			do
				CASENAME=`grep description $CUTDIR/$j | cut -d: -f 2`
				echo -n $CASENAME | tee -a $RESULTLOG
				notrun
			done
		fi
	else	
		fail 
		cat $CUTDIR/cover.conf | cut -d: -f 1 | grep $i > /dev/null
		if [ $? -eq 0 ]
		then
			COVERED=`cat $CUTDIR/cover.conf | grep "$i:" | cut -d: -f 2`
			for j in $COVERED
			do
				CASENAME=`grep description $CUTDIR/$j | cut -d: -f 2`
				echo -n $CASENAME | tee -a $RESULTLOG
				fail 
			done
		fi
	fi
done

cat <<EOT | tee -a $RESULTLOG;
=============================================================
                 Testcase execution completed
=============================================================
Passed  : $PASSNUM
Failed  : $FAILNUM
Not run : $NOTRUNNUM
-------
Total   : $ALLNUM
EOT

if [ $FAILNUM -ne 0 ]; then
	exit 1
fi
