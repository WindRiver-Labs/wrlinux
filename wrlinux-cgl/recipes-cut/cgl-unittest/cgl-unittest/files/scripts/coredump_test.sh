#!/bin/sh
# Copyright (c) 2008, 2015 Wind River Systems, Inc.
# description : CDIAG.2.1 Cluster-Wide Identified Application Core Dump
#
# developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# *
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh


COREDUMP_LIMIT_SIZE=40000
BUGGY_PROGRAM=$TOPDIR/bin/gen_coredump
nameof_test_program=`basename $BUGGY_PROGRAM`

clean()
{
   ulimit -c 0
   echo "core" > /proc/sys/kernel/core_pattern
   rm -f core*.*
   echo "Exit CDIAG.2.1 Cluster-Wide Identified Application Core Dump test"
}

ulimit -c $COREDUMP_LIMIT_SIZE

# Check that we can set the coredump base name.
#
echo "core" > /proc/sys/kernel/core_pattern
if [ "x`sysctl kernel.core_pattern | awk '{print $3}'`" != xcore ] ; then
   echo "`sysctl kernel.core_pattern`"
   cuterr "Application core dump is not supported"
fi

echo "core-%h-%e" > /proc/sys/kernel/core_pattern

if [ -x $BUGGY_PROGRAM ]
then
   $BUGGY_PROGRAM &
   pid=$!
   sleep 1
else
   rpm -q gen_coredump
   if [ ! $? = 0 ]
   then
      echo "****************************************"
      echo "The required package gen_coredump"
      echo "is not installed.  Please install"
      echo "it and re-run the test."
      echo "****************************************"
   else
      echo "****************************************"
      echo "The required utility $BUGGY_PROGRAM"
      echo "is missing or corrupt."
      echo "Please re-install the gen_coredump"
      echo "package and re-run the test."
      echo "****************************************"
   fi
   cutfail
fi

# The dump might have the pid appended, or not.
#
core_dump_file_num=`find . -name "core-*-$nameof_test_program*" | wc -l`

echo -ne "Testing Cluster-wide Identified Application Core Dump"

if [ $core_dump_file_num -gt 0 ] ; then
   cutpass
else
   echo "****************************************"
   echo "Failed to generate a core file from "
   echo "the process $pid."
   echo "----------------------------------------"
   echo "ulimit -c"
   ulimit -c
   echo "----------------------------------------"
   echo "ls $TOPDIR/core*"
   ls $TOPDIR/core*
   echo "----------------------------------------"
   echo "ps -A | grep gen_coredump"
   ps -A | grep gen_coredump
   echo "----------------------------------------"
   echo "cat /proc/sys/kernel/core_uses_pid"
   cat /proc/sys/kernel/core_uses_pid
   echo "****************************************"
   cutfail
fi
