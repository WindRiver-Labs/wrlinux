#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  STD.7.1 STD.7.2 snmp basic test 
# 
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog 
# * 
# - 

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh


clean()
{
   echo "exit STD.7.1 STD.7.2 snmp basic test "
}

if [ -f /etc/init.d/snmpd ]; then
  /etc/init.d/snmpd start
  /etc/init.d/snmpd restart
  checkerr "snmpd start err"
fi

snmp_d=$(ps -A | grep snmpd)
if [ "X$snmp_d" =  "X" ]
then 
   echo "no snmpd process, try to run snmpd"
   snmpd 
   snmp_d=$(ps -A | grep snmpd)
   if [ "X$snmp_d" =  "X" ]; then
     cuterr "still no snmpd process"
   fi
   #make sure snmpd listening
   sleep 1
fi
echo $snmp_d


snmp_d=$(netstat -l -u | grep snmp)
if [ "X$snmp_d" =  "X" ]
then 
   cuterr "no snmp listen port"
fi
echo $snmp_d


msg=$(snmpwalk -v 1 localhost -c public .1.3.6)
#Timeout: No Response from localhost
checkerr "walk local host MIB failed"
echo $msg

cutpass
