#! /bin/sh

#modprobe pktgen

##################################################################

# This shell script used to test Gigabit Ethernet Jumto MTU.
# The tartget NIC must 1000M FULL duplex,and must can loopback.
# Before run this test the pktgen.ko must be loaded.

# Writed by: Xiaofeng.Liu@windriver.com

#################################################################

function pgset() {
    local result

    echo $1 > $PGDEV

    result=`cat $PGDEV | fgrep "Result: OK:"`
    if [ "$result" = "" ]; then
         cat $PGDEV | fgrep Result:
    fi
}

function pg() {
    echo inject > $PGDEV
    cat $PGDEV
}

# Check argument --------------------------------------------------------

echo "$1" > /tmp/pktgen.tmp

if [ "`cut -b0-3 /tmp/pktgen.tmp`" != "eth" ] ; then
	echo "Useage: pktgen_eth_test.sh <NIC_name>"
	exit 1
fi

# Config NIC -------------------------------------------------------------

ifconfig $1 mtu 9000

if [ $? != 0 ] ; then
	echo "NIC can't support 9000 MTU!"
	exit 1
fi

ifconfig $1

# Config pktgen -----------------------------------------------------------

 echo "Configing pktgen......"

# thread config
  

PGDEV=/proc/net/pktgen/kpktgend_0

 echo "Removing all devices"
 pgset "rem_device_all" 

 echo "Adding $1"
 pgset "add_device $1" 

 echo "Setting max_before_softirq 10000"
 pgset "max_before_softirq 10000"


# device config
# delay 0 means maximum speed.

CLONE_SKB="clone_skb 1000000"
PKT_SIZE="pkt_size 9000"
#MAX_PKT_SIZE="max_pkt_size 9000"
#MIN_PKT_SIZE="min_pkt_size 100"

# destination IP address
#DST_IP=192.168.29.170

# destination NIC MAC address
#DST_MAC=00:14:4F:4A:1C:20

# COUNT 0 means forever
COUNT="count 10000000"

# delay 0 means maximum speed.
DELAY="delay 0"

PGDEV=/proc/net/pktgen/$1

 pgset "$COUNT"
 pgset "$CLONE_SKB"

 echo "Setting $MAX_PKT_SIZE"
 pgset "$MAX_PKT_SIZE"

 echo "Setting $MIN_PKT_SIZE"
 pgset "$MIN_PKT_SIZE"

# echo "Setting $PKT_SIZE"
# pgset "$PKT_SIZE"

 pgset "$DELAY"

 pgset "dst $DST_IP"
 echo "Destination IP address $DST_IP"
 
 pgset "dst_mac $DST_MAC"
 echo "Destination NIC MAC address $DST_MAC"


# Time to run
PGDEV=/proc/net/pktgen/pgctrl

 echo "Start pocket send......"
 echo "start" > /proc/net/pktgen/pgctrl &
 STR_PID=$!
 sleep 10
 kill -9 $STR_PID > /dev/null 2>&1
 pgset "stop"
 echo "Done!"
 echo "Result:"

 cat /proc/net/pktgen/$1
