#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  CAF.1.0 CCM.2.1 CCM.2.2  OpenAIS
#
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# *
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

tmpf=openais.testlog
clean()
{
   /etc/init.d/openais stop
   cp -f ~/corosync.orig /etc/corosync/corosync.conf 
   echo "exit  CAF.1.0 CCM.2.1 CCM.2.2  OpenAIS test "
}

rpm -q openais
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "The required package openais is"
   echo "not installed.  Please install and "
   echo "re-run the test."
   echo "****************************************"
   cutfail
fi


cp -f /etc/corosync/corosync.conf  ~/corosync.orig

cat > /etc/corosync/corosync.conf << EOF

compatibility: none

corosync {
         user:  root
         group: root
}

aisexec {
        with openais
        user:  root
        group: root
}

service {
        name: openais
        ver: 0
}

totem {
        version: 2
        secauth: off
        threads: 0
        interface {
                ringnumber: 0
                # Cluster network address
                bindnetaddr: 127.0.0.1
                # Should be fine in most cases, don't forget to allow
                # packets for this address/port in netfilter if there
                # is restrictive policy set for cluster network
                mcastaddr: 226.94.1.1
                mcastport: 5405
        }
}

logging {
        fileline: off
        to_stderr: no
        to_logfile: yes
        to_syslog: yes
        logfile: /var/log/corosync.log
        debug: off
        timestamp: on
        logger_subsys {
                subsys: AMF
                debug: off
        }
}

amf {
        mode: disabled
}

EOF

/etc/init.d/openais stop
/etc/init.d/openais start
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "Failed to start the openais daemon."
   echo "----------------------------------------"
   tail -n 20 /var/log/messages
   echo "****************************************"
   cutfail
fi


ais=$(ps -A | grep corosync)
echo $ais
if [ ! "$ais" ]
then
   echo "****************************************"
   echo "Failed to start the ais service"
   echo "----------------------------------------"
   tail -n 20 /var/log/messages
   echo "****************************************"
   cutfail
fi


cd $TOPDIR/openais-test

# $1: test case
# $2: msg indicate pass
# $3: msg indicate failed
openais_test()
{
expect <<- END

set timeout 35
set pid 0

spawn $1

expect {
	eof  { exit 1 }
	"$2"	 { exit 0 } #pass
	"$3"	 { exit 3 } #failed
	timeout  { exit 2 }
}

expect eof # stop here
#send_tty "please check the test script!!!!"
exit 4

END
}

failed=0

sumerr()
{
   if [ ! $? = 0 ]
   then
      echo "$1"
   let  failed+=1
   fi
}

openais_test ./testclm "Node Information for"  "Couldn"
sumerr "openais clm test failed"

openais_test ./testevt "Test multiple operations"  "if failed, evt will time out"
sumerr "openais evt test failed"

openais_test ./testlck "saLckResourceOpenAsync 1 (should be 1)"  "Could not"
sumerr "openais lck test failed"

openais_test ./testckpt "PASSED: Finalize checkpoint" "FAILED expected SA_AIS_OK"
sumerr "openais ckpt test failed"

openais_test ./testmsg "Finalize result is 1 (should be 1)"  "Could not"
sumerr "openais msg test failed"

#testtmr's timer will fire first at 30 seconds, so wait at least >30 seconds
openais_test ./testtmr "TimerExpiredCallback" "ERROR"
sumerr "openais tmr test failed"


if [ "$failed" = 0 ] ; then
   cutpass
else 
   echo "**************************"
   echo "total failed case: $failed"
   echo " hint: try run this test again"
   echo "**************************"
   cuterr
fi
