#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  STD.5.1 ipsec test
# 

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

clean()
{
	rm /tmp/ipsec.tcpdump
	echo "exit STD.5.1 ipsec test "
}


# ping the end of the tunnel
ping -c5 192.168.42.1
if [ $? -ne 0 ]
then
	echo "****************************************" 
	echo "Failed to ping remote node via IPSec tunnel"
	echo "----------------------------------------"
	cat $TOPDIR/racoon-config/README
	echo "----------------------------------------"
	ip addr
	echo "----------------------------------------"
	ip route
	echo "****************************************" 
	cutfail
fi

# look for ESP packets
tcpdump -c 5 proto 50 > /tmp/ipsec.tcpdump &
ping -c5 192.168.42.1
grep ESP /tmp/ipsec.tcpdump
if [ $? -ne 0 ]
then
	echo "****************************************" 
	echo "The IPSEC configuration is not correct."
	echo "----------------------------------------"
	cat $TOPDIR/racoon-config/README
	echo "----------------------------------------"
	cat /etc/racoon2.conf
	echo "----------------------------------------"
	grep spmd /var/log/messages
	grep iked /var/log/messages
	echo "****************************************" 
	cutfail
fi

cutpass
