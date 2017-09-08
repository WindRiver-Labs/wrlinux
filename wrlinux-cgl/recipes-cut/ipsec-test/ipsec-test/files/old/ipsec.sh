#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  STD.5.1 ipsec test
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
   cp -rf $TOPDIR/racoon-config/backup/*  /etc/racoon/ 
	echo "exit  STD.5.1 ipsec test "
}


#back up racoon config file
cp -rf /etc/racoon/*    $TOPDIR/racoon-config/backup/


#get first valid ip address 
all_ip=$(ifconfig -a | grep -w "inet" |  grep -v "127.0.0.1" | awk '{print $2;}' | awk -F: '{print $2}')

first_ip=""
for ip in $all_ip
do
   first_ip=$ip
    break
done

if [ ! $first_ip ] 
then
  cuterr "can not find out self ip address"
fi

#genarate racoon config 
cat racoon-config/psk.txt  > /etc/racoon/psk.txt
cat racoon-config/racoon.conf   > /etc/racoon/racoon.conf
cat racoon-config/setkey.conf  | sed "s/192.168.127.3/$first_ip/g"  > /etc/racoon/setkey.conf

#

setkey -f /etc/racoon/setkey.conf
checkerr "please ensure you install correct modules"

raco=$(ps -A | grep racoon)
if [ ! "$raco" ]
then
  /etc/init.d/racoon start
  checkerr "racoon start error"
fi


### ping dest , try to establish ipsec tunnel 
### expect filed...
ping_3()
{
expect <<- END

set timeout 4
set pid 0

#this ip is in the /etc/racoon/psk.txt
spawn ping 192.168.127.11  

expect {
	"no this output"	 { exit 0 } #pass
	timeout  { exit 2 }
	eof  { exit 1 }
}

expect eof # stop here
exit 4  

END
}

ping_3 

# check the tunnel

esp=$(racoonctl  show-sa esp)
echo $esp
msg=$(echo $esp | grep "esp mode=")
echo $msg
if [  "$msg" ]
then
   cutpass
else
   cutfail
fi

