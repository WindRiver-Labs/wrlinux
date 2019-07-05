#!/bin/sh

# Copyright (c) 2016 Wind River Systems, Inc.
# description : Used to define functions for kdump cases

# Note this script cannot be run directly, but just
# a script which defines the functions specified for kdump
# case
#
# developer : Mingli Yu  <mingli.yu@windriver.com>
#

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

TESTROOT="/opt/cut/kdump_temp"
TMP_DIR="/opt/cut/kdump.tmp"

# use to track which kdump case, as we need to add the testcase name to
# rc.local during each reboot
kdump_case=""
flag_file="/opt/cut/kdump-flag"
test_report=""

restore_kdump()
{
    which systemctl
    if [ $? -eq 0 ]; then
        systemctl enable kdump
        systemctl start kdump
    fi
}

clean()
{
    echo "Clean System..."
	rm -rf $flag_file
    [ -f /etc/sysconfig/kdump.conf.bak ] && rm -rf /etc/sysconfig/kdump.conf.bak
    [ -f /etc/rc.local-bak ] && mv /etc/rc.local-bak /etc/rc.local
    rm -rf $TESTROOT
    restore_kdump
    echo "Finish"
}

cus_kdump()
{
    which systemctl
    if [ $? -eq 0 ]; then
        systemctl disable kdump
        systemctl stop kdump
    fi
}

prepare()
{
    # clear the test result for last test
    rm -rf $TMP_DIR

    # disable and stop kdump to avoid conflict for our test
    cus_kdump
    [ -d $TESTROOT ] || mkdir -p $TESTROOT
    [ -d $TMP_DIR ] || mkdir -p $TMP_DIR
}

#Step1: Prepare env: set up rc.local
#Create flag file and point to next step
#Load crash kernel
#reboot to the kernel
runstep_1()
{
    echo "Running step 1: run kdump test ..."
    if [ ! -f /etc/sysconfig/kdump.conf.bak ]; then
        prepare
        [ -f $flag_file ] && cuterr "$flag_file already exist!"
        echo "`date` Begin to run test ${kdump_case}" >> $test_report
    fi

    # check if kernel support kdump
    zcat /proc/config.gz |grep -q CONFIG_KEXEC=y || cuterr "kexec is not configured!"
    zcat /proc/config.gz |grep -q CONFIG_CRASH_DUMP=y || cuterr "kdump is not configured!"
    zcat /proc/config.gz |grep -q CONFIG_PROC_VMCORE=y || cuterr "/proc/vmcore is not configured!"

	# copy bzImage and vmlinux to TESTROOT dir
    cp -f /boot/bzImage-`uname -r` $TESTROOT/crash-kernel
    cp -f /boot/vmlinux-`uname -r` $TESTROOT/vmlinux
    cp -f /opt/cut/resource/crash_input $TESTROOT

    grep -q -E "$kdump_case|cgl_test.sh" /etc/rc.local && cuterr "/etc/rc.local is not clean!"
    cp /etc/rc.local /etc/rc.local-bak

    rc_cmd="/opt/cut/testcase/$kdump_case &"
    pid=$$
    ppid=`ps -o ppid -p $pid|grep [0-9]`
    ps -eo pid,cmd|grep $ppid|grep "cgl_test.sh" && rc_cmd="/opt/cut/cgl_test.sh -e $kdump_case"
    sed  -i "/^exit/i$rc_cmd" /etc/rc.local

    sleep 10
    echo "Running step 2: run kdump test..."
    sleep 20
    # load dump-capatued kernel
    kexec -p $TESTROOT/crash-kernel --append="`cat /proc/cmdline|sed 's/ crashkernel=.*//g'`" 2>&1 || cuterr "Failed to load dump-captured kernel"
    echo 2 > ${flag_file}
    sleep 10
    echo "Begin to boot into the crash kernel" >> $test_report
    echo "The current rc.local content as below:"  >> $test_report
    cat /etc/rc.local  >> $test_report
    echo "The current $flag_file content as below:"  >> $test_report
    cat $flag_file  >> $test_report

    sleep 60
    echo c > /proc/sysrq-trigger
}

#Step2: Now its rebooted to the crash kernel
#Copy dumped kernel and reboot to the normal kernel
runstep_2()
{
    echo "copy the dumped kernel" >> $test_report

    if [ -f /etc/sysconfig/kdump.conf.bak ]; then
        if [ -d $TMP_DIR ]; then
            cp /proc/vmcore $TMP_DIR || cuterr "Failed to copy vmcoreo"
        else
            cuterr "Failed to locate the configurable destination"
        fi
    else
        cp /proc/vmcore $TESTROOT || cuterr "Failed to copy vmcore"
    fi
 
    if [ $kdump_case = "sfa.10.0" ]; then
	    echo 4 > ${flag_file}
	    echo "4 in $flag_file"  >> $test_report
    elif [ $kdump_case = "sfa.4.0" ]; then
	    echo 5 > ${flag_file}
    elif [ $kdump_case = "sfa.1.0" ]; then
	    echo 6 > ${flag_file}
    elif [ $kdump_case = "cdiag.2.2" ]; then
	    echo 7 > ${flag_file}
    else
	    echo 3 > ${flag_file}
    fi

    # wait for the flag file completes write
    sleep 10
    reboot -f
}

# test makedumpfile command
runstep_5()
{
    makedumpfile --dump-dmesg $TESTROOT/vmcore dmesgfile
    if [ $? -ne 0 ]; then
        echo "Failed to test makedumpfile command" >> $test_report
        echo "SFA.4.0 Kernel Dump: Limit Scope                   [  FAIL  ]" >> $test_report
        cuterr "Failed to test makedumpfile command"
    fi
	grep 'Trigger a crash' dmesgfile
    if [ $? -ne 0 ]; then
        echo "The dumpfile is incorrect" >> $test_report
        echo "SFA.4.0 Kernel Dump: Limit Scope                   [  FAIL  ]" >> $test_report
        cuterr "The dumpfile is incorrect"
    fi

    makedumpfile --dump-dmesg -x $TESTROOT/vmlinux $TESTROOT/vmcore dmesgfile2
    if [ $? -ne 0 ]; then
        echo "Failed to test makedumpfile command" >> $test_report
        echo "SFA.4.0 Kernel Dump: Limit Scope                   [  FAIL  ]" >> $test_report
        cuterr "Failed to test makedumpfile command"
    fi
    grep 'Trigger a crash' dmesgfile2
    if [ $? -ne 0 ]; then
        echo "The dumpfile is incorrect" >> $test_report
        echo "SFA.4.0 Kernel Dump: Limit Scope                   [  FAIL  ]" >> $test_report
        cuterr "The dumpfile is incorrect"
    fi
    echo "SFA.4.0 Kernel Dump: Limit Scope                   [  PASS  ]" >> $test_report
	cutpass
}

runstep_6()
{
    sleep 10
    rm -rf crash_output.log
    
    #run crash command to check the kdump results
    crash $TESTROOT/vmcore $TESTROOT/vmlinux -i $TESTROOT/crash_input > $TESTROOT/crash_output.log 2>&1
    if [ $? -ne 0 ]; then
        echo "SFA.1.0 Kernel Panic Handler Enhancements                   [  FAIL  ]" >> $test_report
        cutfail
    fi
    cat $TESTROOT/crash_output.log | grep "Trigger a crash" && cat $TESTROOT/crash_output.log | grep  machine_kexec
    if [ $? -ne 0 ]; then
        echo "SFA.1.0 Kernel Panic Handler Enhancements                   [  FAIL  ]" >> $test_report
        cutfail
    else
        echo "SFA.1.0 Kernel Panic Handler Enhancements                   [  PASS  ]" >> $test_report
        cutpass
    fi
}

runstep_7()
{
    sleep 10
    rm -rf crash_output.log
    crash $TESTROOT/vmcore $TESTROOT/vmlinux -i $TESTROOT/crash_input > $TESTROOT/crash_output.log 2>&1
    if [ -f $TESTROOT/crash_output.log ]; then
        nodename=`cat $TESTROOT/crash_output.log | grep NODENAME| awk '{print $2}'`
        hostname=`hostname`
        if [ $nodename = $hostname ]; then
            echo "CDIAG.2.2 Cluster-Wide Kernel Crash Dump                   [  PASS  ]" >> $test_report
            cutpass
        fi
    fi
    echo "CDIAG.2.2 Cluster-Wide Kernel Crash Dump                   [  FAIL  ]" >> $test_report
    cutfail
}

runstep_3()
{
    sleep 10
    rm -rf crash_output.log
	
    #run crash command to check the kdump results
    crash $TESTROOT/vmcore $TESTROOT/vmlinux -i $TESTROOT/crash_input > $TESTROOT/crash_output.log 2>&1
    if [ $? -ne 0 ]; then
        echo "SFA.3.0 Kernel Dump: Analysis                   [  FAIL  ]" >> $test_report
        cutfail
    fi
    cat $TESTROOT/crash_output.log | grep $kdump_case && cat $TESTROOT/crash_output.log | grep  machine_kexec
    if [ $? -ne 0 ]; then
        echo "SFA.3.0 Kernel Dump: Analysis                   [  FAIL  ]" >> $test_report
        cutfail
    else
        echo "SFA.3.0 Kernel Dump: Analysis                   [  PASS  ]" >> $test_report
        cutpass
    fi
}

runstep_4()
{
    # check the kdump file vmcore if exist at the configurable destination
    if [ -f /etc/sysconfig/kdump.conf.bak ] && [ -f $TMP_DIR/vmcore ]; then
        echo "SFA.10.0 Kernel Dump: Configurable Destinations                   [  PASS  ]" >> $test_report
        cutpass
    else
        echo "SFA.10.0 Kernel Dump: Configurable Destinations                   [  FAIL  ]" >> $test_report
        cutfail
    fi
}

trap "clean" 0 2  #0 EXIT 2 INT

runstep_0()
{
    prepare
    [ -f $flag_file ] && cuterr "Error: $flag_file already exist!"

    echo "`date` Begin to run test ${kdump_case}" >> $test_report
    if [ -f /etc/sysconfig/kdump.conf ]; then
        cp /etc/sysconfig/kdump.conf /etc/sysconfig/kdump.conf.bak
    else
        cuterr "No kdump.conf"
    fi
    # customize the vmcore file destination
    sed -i "s,^#KDUMP_VMCORE_PATH=.*$,KDUMP_VMCORE_PATH=${TMP_DIR},g" /etc/sysconfig/kdump.conf \
        || cuterr "Failed to customize the vmcore destination"

    echo 1 > ${flag_file}
    sleep 10

    # check the update step
    [ -f $flag_file ] && test_step=`cat $flag_file`
    echo "Updated the kdump destination" >> $test_report
    eval runstep_${test_step}
}

main_fun()
{
    if [ ! -f $flag_file ]; then
        cat /proc/cmdline | awk '{print $NF}'| grep crashkernel= || cutna "Please set the crashkernel as the last boot parameter"
    fi
    kdump_case=$1
    test_report="$TMP_DIR/test_${kdump_case}_report"
    eval runstep_${test_step}
}
