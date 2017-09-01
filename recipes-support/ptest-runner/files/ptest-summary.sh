#!/bin/bash
#
# Copyright (c) 2013 Wind River Systems
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

# ------------------------------------------------------------------------
# A tool to process the results of ptest output.  This script assumes that the
# input will be a raw log of the ptest run, in the style produced by using the
# start-ptest makefile target.

unset ptest_run_log
ptest_summary=0
ptest_detail=0
ptest_detail_failures=0

function usage
{
    echo "$0 [options]"
    echo ""
    echo " Options:"
    echo "  -d             Report detailed statistics (per-test pass/fail/skip)"
    echo "  -f             Report failed test cases, must be used with -d option"
    echo "  -h             help and usage information (this message)"
    echo "  -l <logfile>   The name of the log file to process.  Typically"
    echo "                 something like ptest-run-2013-08-13T10:05.log"
    echo "  -s             Report summary statistics (aggregate pass/fail/skip)"
}

function report_summary
{
    echo ""
    echo "----- Summary ----------------------------------------------------------"
    echo ""
    # First get the high-level start/stop and runtime info
    egrep -C1 '(^START:|^STOP:)' ${ptest_run_log} | \
        sed '/^[0-9]/{N;N;s/\n/ /g;s/^/    /};/STOP:/d'

    # Now list what tests were run
    echo ""
    echo "  Test suites executed:"
    egrep '(^BEGIN:|^END:|^[0-9]{4}-)' ${ptest_run_log} | sed -n 'h;n;G;p' | \
        sed '/^[0-9]/{N;N;s/\n/ -- /g;s/^/        /;s/ -- END:.*$//};s/BEGIN: /\n    package: /'

    # And collect the aggregate statistics
    echo ""
    echo -n "  Passed:  " ; grep -c "^PASS:" ${ptest_run_log}
    echo -n "  Failed:  " ; grep -c "^FAIL:" ${ptest_run_log}
    echo -n "  Skipped: " ; grep -c "^SKIP:" ${ptest_run_log}
    echo ""
}

function report_detail
{
    echo ""
    echo "----- Detail -----------------------------------------------------------"
    echo ""

    for package in $(grep BEGIN: ${ptest_run_log} | awk '{ print $2 }')
    do
        echo "    ${package}"
        echo -n "        Passed:  "
        sed -n "\CBEGIN: ${package}C,\CEND: ${package}Cp" ${ptest_run_log} \
            | grep -c "^PASS:"
        echo -n "        Failed:  "
        sed -n "\CBEGIN: ${package}C,\CEND: ${package}Cp" ${ptest_run_log} \
            | grep -c "^FAIL:"
        if [ ${ptest_detail_failures} -eq 1 ]; then
            sed -n "\CBEGIN: ${package}C,\CEND: ${package}Cp" ${ptest_run_log} \
                | grep "^FAIL:" | sed 's/^/            /'
        fi
        echo -n "        Skipped: "
        sed -n "\CBEGIN: ${package}C,\CEND: ${package}Cp" ${ptest_run_log} \
            | grep -c "^SKIP:"
        echo ""
    done
}

# main
OPTIND=1
while getopts "cdfhsl:" opt ; do
    case $opt in
        d ) ptest_detail=1 ;;
        f ) ptest_detail_failures=1 ;;
        s ) ptest_summary=1 ;;
        h ) usage ; exit 0;;
        l ) ptest_run_log=$OPTARG ;;
        * ) usage ; exit 1;;
    esac
done

# minimal sanity checking
if [ -z "${ptest_run_log}" ]; then
    echo "No log file specified."
    usage
    exit 1
fi

if [ ! -e ${ptest_run_log} ]; then
    echo "${ptest_run_log} does not appear to be a log file"
    exit 1
fi

if [ ! -r ${ptest_run_log} ]; then
    echo "${ptest_run_log} is not readable"
    exit 1
fi

echo "Processing log file: ${ptest_run_log}"

if [ ${ptest_summary} -eq 0 -a ${ptest_detail} -eq 0 ]; then
    echo Nothing to do.
    usage
    exit 0
fi

if [ ${ptest_summary} -eq 1 ]; then
    report_summary
fi

if [ ${ptest_detail} -eq 1 ]; then
    report_detail
fi
exit 0
