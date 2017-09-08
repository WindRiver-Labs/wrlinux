#!/bin/bash
# Copyright (c) 2016 Wind River Systems, Inc.
# description :   SMM.5.0 SMM.5.1 Profiling test
#
# developer: Jackie Huang <jackie.huang@windriver.com>
#
# changelog
# * 02/04/2016: add the case to replace oprofile.sh
#

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

tmp_dir=`mktemp -d /tmp/perf_test.tmp.XXXXXX`

clean()
{
    rm -rf ${tmp_dir}
    rm -rf perf.data*
    echo "exit  SMM.5.0 SMM.5.1  Profiling test"
}

zcat /proc/config.gz | grep CONFIG_PERF_EVENTS=y
if [ ! $? = 0 ]; then
    echo "****************************************"
    echo "The kernel has not been properly built"
    echo "for this test."
    echo "****************************************"
    cutfail
fi

CMD_UNITEST="$TOPDIR/bin/backtrace unittest 1"

perf list
checkerr "perf list error"

perf stat -o ${tmp_dir}/event.log -e instructions ${CMD_UNITEST}
checkerr "perf stat instructions event error"

perf record ${CMD_UNITEST}
checkerr "perf record error"

perf report
checkerr "perf report error"

cutpass
