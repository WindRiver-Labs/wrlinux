#!/bin/bash
#Copyright (c) 2008 - 2016 Wind River Systems, Inc.
#description : PMS.5.1 PMS.5.3 iscsi basic test
#
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# * 03/10/2016 update for systemd

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh


clean()
{
   echo "PMS.5.1 PMS.5.3 iscsi basic test"
}

zcat /proc/config.gz | grep CONFIG_ISCSI_TCP=m || cuterr "Configure CONFIG_ISCSI_TCP=m first"

# this requires iscsid to be running... 
if [ -f /etc/init.d/iscsid ]; then
   /etc/init.d/iscsid restart
else
   systemctl restart iscsi-initiator
fi


#ls /etc/iscsi/
#initiatorname.iscsi  iscsid.conf
if [ ! -f /etc/iscsi/initiatorname.iscsi ] || [  ! -f /etc/iscsi/iscsid.conf ]
then
   echo "****************************************"
   echo "A required configuration file is missing"
   echo "Ensure the package iscsi-initiator-utils"
   echo "is installed."
   echo "----------------------------------------"
   ls /etc/iscsi/initiatorname.iscsi
   ls /etc/iscsi/iscsid.conf
   echo "****************************************"
   cutfail
fi


iscsi_msg=$(whereis iscsiadm)
if [ "X$iscsi_msg" =  "X"  ]
then
   echo "****************************************"
   echo "The application iscsiadm is missing"
   echo "Ensure the package iscsi-initiator-utils"
   echo "is installed."
   echo "****************************************"
   cutfail
fi
echo $iscsi_msg


modprobe iscsi_tcp
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "Failed to install module iscsi_tcp"
   echo "----------------------------------------"
   dmesg | grep -i iscsi
   echo "----------------------------------------"
   tail -n 20 /var/log/messages
   echo "****************************************"
   cutfail
fi

iscsi_msg=$( lsmod | grep iscsi )
if [ "X$iscsi_msg" =  "X"  ]
then
   echo "****************************************"
   echo "The required iscsi kernel modules"
   echo "are missing."
   echo "----------------------------------------"
   lsmod
   echo "****************************************"
   cutfail
fi
echo $iscsi_msg


iscsi_msg=$(dmesg  | grep iscsi)
#iscsi: registered transport (tcp)
if [ "X$iscsi_msg" =  "X"  ]
then
   echo "****************************************"
   echo "There is no iscsi transport registered in dmesg"
   echo "----------------------------------------"
   iscsi_msg=$(grep -i iscsi /var/log/kern.log)
   if [ "X$iscsi_msg" = "X" ];then 
     echo "****************************************"
     cutfail
   fi
fi
echo $iscsi_msg


iscsi_msg=$( ps -A | grep iscsi )
if [ "X$iscsi_msg" =  "X"  ]
then
   echo "****************************************"
   echo "The iscsi daemon is not running"
   echo "----------------------------------------"
   grep -i iscsi /var/log/*
   echo "****************************************"
   cutfail
fi
echo $iscsi_msg


iscsi_msg=$(iscsi-iname)
if [ "X$iscsi_msg" =  "X"  ]
then
   echo "****************************************"
   echo "iscsi-iname has no output."
   echo "Please check iscsi configuration files"
   echo "****************************************"
   cutfail
fi
echo $iscsi_msg


cutpass
