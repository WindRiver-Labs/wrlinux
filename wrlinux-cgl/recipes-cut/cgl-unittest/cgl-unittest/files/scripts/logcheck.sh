#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description : logcheck unit test
#
#developer : kexin Hao <kenxin.hao@windriver.com>
#            Yongli He  <yongli.he@windriver.com>
#
# changelog
# *
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

clean()
{
   echo  "Exit logcheck unit test"
}


export MAIL=/var/spool/mail/$USER
#- Run the logcheck script:
# clear all mail  mail and type d *
mesg=$((sleep 2;echo d \* )| mailx 2>&1)

#- Force an entry into the system log with the logger program:
logger "Simulated ATTACK"
logger "kernel: Oversized packet received from"

#- Ensure that the entry has been placed in the system log:

mesg=$(grep "Simulated ATTACK" /var/log/messages)
   #expect like  Jan  1 00:03:01 SBC8560 root: Simulated ATTACK
if [ "X$mesg" = "X" ]; then
   echo "****************************************"
   echo "It appears that a problem exists in syslog."
   echo "----------------------------------------"
   echo "ps -ef | grep syslog"
   ps -ef | grep syslog
   echo "----------------------------------------"
   cat /etc/syslog.conf
   echo "****************************************"
   cutfail
fi



if [ ! -x /usr/sbin/logcheck ] ; then
   # ensure that the logcheck package is installed
   rpm -q logcheck
   if [ ! $? = 0 ]
   then
      echo "****************************************"
      echo "The required package logcheck is not"
      echo "installed.  Please install it and re-run"
      echo "the test."
      echo "****************************************"
   else
      echo "****************************************"
      echo "The required utility /usr/sbin/logcheck"
      echo "is missing or corrupt.  Please investigate"
      echo "and possibly re-install the logcheck"
      echo "package."
      echo "****************************************"
   fi
   cutfail
fi

#set up for sendmail
#if there is no MTA with smtp server
cat <<EOF > /var/lib/logcheck/.msmtprc
account default
host 127.0.0.1
#host 128.224.147.210
#port 25
from logcheck@localhost.localdomain
#protocol smtp
EOF

chown logcheck:logcheck /var/lib/logcheck/.msmtprc
chmod 0600 /var/lib/logcheck/.msmtprc

#email receive agent config
#my host postfix: main.cf
#myhostname = $(hostanme)
#alias_maps = hash:/etc/aliases
#alias_database = hash:/etc/aliases
#mydestination = $(hostname), localhost.localdomain, localhost
#relayhost =
#mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
#mailbox_size_limit = 0
#recipient_delimiter = +
#inet_interfaces = all
#loopback-only

#can't run logcheck with root account
#is there MRA yet?
if [ -n "$(netstat -tln|grep :25)" ]; then
	MRA_available=1
else
	MRA_available=0
fi

if [ "$MRA_available" = "1" ]; then
	su -s /bin/bash -c "/usr/sbin/logcheck -m root" logcheck
	sleep 30
	mesg=$( (sleep 1; echo p; echo a;) | mailx \
		| grep  -e "System Events" \
			-e "Security Alerts for kernel" )
	if [ "X$mesg" = "X" ]; then
		cutfail
	fi
else
	mesg=$(su -s /bin/bash -c "/usr/sbin/logcheck -o " logcheck)
	mesg=$(	echo "$mesg" | grep -e "System Events"; \
		echo "$mesg" | grep -e "Security Alerts for kernel"; )
	echo "$mesg"
	if [ "X$mesg" = "X" ]; then
		cutfail
	fi
fi
cutpass
