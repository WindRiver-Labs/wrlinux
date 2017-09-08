#!/bin/sh

LADDR=192.168.7.2
RADDR=192.168.7.4

LTUNNEL=10.0.0.1
RTUNNEL=10.0.0.2

TNAME=tun1

ip tunnel add $TNAME mode ipip remote $RADDR local $LADDR dev eth0

ifconfig $TNAME $LTUNNEL netmask 255.255.255.0 pointopoint $RTUNNEL
ifconfig $TNAME mtu 1500 up
