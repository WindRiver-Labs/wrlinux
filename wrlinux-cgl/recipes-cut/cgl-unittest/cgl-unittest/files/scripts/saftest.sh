#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  STD.8.8 SA Forum HPI
#
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# * 15/01/2018 Remove the deprecated case
#   SMM.2.0, SMM.2.1 and CMON.1.1 per CGL 5.0
#   specification
# * 02/04/2015 update the test for systemd
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

SAFTEST_DIR="/opt/saftest"
HPI_CONF="/etc/openhpi/openhpi.conf"
HPICLIENT_CONF="/etc/openhpi/openhpiclient.conf"

# run all tests in src by default
SUBTEST_DIR=""
if [ -n "$1" -a -d "${SAFTEST_DIR}/HPI-B.01.01/src/$1" ]; then
	SUBTEST_DIR=$1
fi

if [ -f /etc/init.d/openhpid ]; then
	OPENHPI_START="/etc/init.d/openhpid start"
	OPENHPI_STOP="/etc/init.d/openhpid stop"
else
	OPENHPI_START="systemctl start openhpid"
	OPENHPI_STOP="systemctl stop openhpid"
fi

clean()
{
   echo "Clean System..."
   ${OPENHPI_STOP}
   rm -rf ${SAFTEST_DIR}/log/*
   rm -f ${SAFTEST_DIR}/HPI-B.01.01/log/error_log
   rm -f ${SAFTEST_DIR}/HPI-B.01.01/log/run_log
   mv ${HPI_CONF}_orig ${HPI_CONF}
   mv ${HPICLIENT_CONF}_orig ${HPICLIENT_CONF}
   echo "Cleanup done."
}

rpm -qa | grep saftest
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "The required package saftest is"
   echo "not installed."
   echo "****************************************"
   cutfail
fi

rpm -qa | grep openhpi
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "The required package openhpi is"
   echo "not installed."
   echo "****************************************"
   cutfail
fi

rpm -qa | grep openipmi
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "The required package openipmi is"
   echo "not installed."
   echo "****************************************"
   cutfail
fi

cp ${HPI_CONF} ${HPI_CONF}_orig
cp ${HPICLIENT_CONF} ${HPICLIENT_CONF}_orig
sed -i -e 's/\(OPENHPI_UNCONFIGURED = "YES"\)/#\1/' \
       -e 's/#\(OPENHPI_LOG_ON_SEV = "MINOR"\)/\1/' \
       -e 's/#\(OPENHPI_ON_EP = "{SYSTEM_CHASSIS,1}\)/\1/' \
       -e 's/#\(OPENHPI_EVT_QUEUE_LIMIT = 10000\)/\1/' \
       -e 's/#\(OPENHPI_DEL_SIZE_LIMIT = 10000\)/\1/' \
       -e 's/#\(OPENHPI_DEL_SAVE = "NO"\)/\1/' \
       -e 's/#\(OPENHPI_DAT_SIZE_LIMIT = 0\)/\1/' \
       -e 's/#\(OPENHPI_DAT_USER_LIMIT = 0\)/\1/' \
       -e 's/#\(OPENHPI_DAT_SAVE = "NO"\)/\1/' \
       -e 's!#\(OPENHPI_PATH = \)"/usr/local/lib/openhpi:/usr/lib/openhpi"!\1"/usr/lib/openhpi:/usr/lib64/openhpi"!' \
       -e 's!#\(OPENHPI_VARPATH = \)"/usr/local/var/lib/openhpi"!\1"/var/lib/openhpi"!' \
       -e 's/#\(OPENHPI_AUTOINSERT_TIMEOUT = 0\)/\1/' \
       -e 's/#\(OPENHPI_AUTOINSERT_TIMEOUT_READONLY = "YES"\)/\1/' ${HPI_CONF}

sed -i 's/#\s*\(my_entity = .*\)/\1/' ${HPICLIENT_CONF}

${OPENHPI_START}
checkerr "openhpi start failed"
sleep 2

cd ${SAFTEST_DIR}
rm -rf log/*
rm -f HPI-B.01.01/log/error_log
rm -f HPI-B.01.01/log/run_log

cd ${SAFTEST_DIR}/HPI*
./run_tests.sh src/${SUBTEST_DIR}

PASSNUM=`cat log/run_log | grep PASS | wc -l`
FAILNUM=`cat log/run_log | grep FAIL | wc -l`
UNKNNUM=`cat log/run_log | grep UNKNOWN | wc -l`
NOTSUPPORT=`cat log/run_log | grep NOTSUPPORT | wc -l`
((TOTAL=PASSNUM+FAILNUM+UNKNNUM+NOTSUPPORT))

echo "Test results:"
echo "TOTAL:      $TOTAL"
echo "PASSED:     $PASSNUM"
echo "FAILED:     $FAILNUM"
echo "UNKNOWN:    $UNKNNUM"
echo "NOTSUPPORT: $NOTSUPPORT"

if [ "$FAILNUM" -ne 0 ]; then
	echo "failed tests:"
	grep -B 1 FAIL log/run_log
	cuterr " saftest"
fi

cutpass
