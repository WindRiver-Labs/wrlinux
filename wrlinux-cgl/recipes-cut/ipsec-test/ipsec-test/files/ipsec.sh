#!/bin/bash
#Copyright (c) 2016 Wind River Systems, Inc.
#description :  ipsec test
# 

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

. $TOPDIR/ipsec-strongswan/ipsec_cut_config.sh

clean()
{
	[ -f /opt/cut/ipsec-strongswan/ipsec_cut_config.sh.bak ] && \
		mv /opt/cut/ipsec-strongswan/ipsec_cut_config.sh.bak \
		/opt/cut/ipsec-strongswan/ipsec_cut_config.sh
	echo "Finish"
}

if [ "$IPSEC_CUT_MODE" = "skip" ] ; then
	cutna " configured to skip this test"
elif [ -z "$IPSEC_CUT_MODE" ] ; then
	echo "ipsec test needs to be configured in $TOPDIR/ipsec-strongswan/ipsec_cut_config.sh !!"
	cutfail
fi


# ping the end of the tunnel
ping -c5 ${rmtIP}
if [ $? -ne 0 ]
then
	echo "****************************************" 
	echo "Failed to ping remote node"
	echo "----------------------------------------"
	ip addr
	echo "----------------------------------------"
	ip route
	echo "****************************************" 
	cutfail
fi

ipsec up toRemote
if [ $? -ne 0 ]
then
	echo "****************************************" 
	echo "Failed to bring up IPSec tunnel"
	echo "****************************************" 
	cutfail
fi


# look for ESP packets
tcpdump  > /tmp/ipsec.tcpdump &
ping -c10 ${rmtIP}

# kill tcpdump and wait for it to finish
#
kill %1
wait

grep ESP /tmp/ipsec.tcpdump
if [ $? -ne 0 ]
then
	echo "****************************************" 
	echo "NO ipsec packets seen when pinging."
	echo "----------------------------------------"
	echo "****************************************" 
	cutfail
fi

cutpass
