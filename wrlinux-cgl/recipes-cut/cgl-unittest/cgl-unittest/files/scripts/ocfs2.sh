#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  CSM.6.0 CSM.7.0 ocfs2 basic test
#
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# * 02/06/2015 update the test for systemd
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

loopfile=ocfs2.loop

if [ -f /etc/init.d/ocfs2 ]; then
        OCFS2_START="/etc/init.d/ocfs2 start"
        OCFS2_RESTART="/etc/init.d/ocfs2 restart"
        OCFS2_STOP="/etc/init.d/ocfs2 stop"
        O2CB_START="/etc/init.d/o2cb start"
        O2CB_RESTART="/etc/init.d/o2cb restart"
        O2CB_STOP="/etc/init.d/o2cb stop"
else
        OCFS2_START="/bin/systemctl start ocfs2"
        OCFS2_RESTART="/bin/systemctl restart ocfs2"
        OCFS2_STOP="/bin/systemctl stop ocfs2"
        O2CB_START="/bin/systemctl start o2cb"
        O2CB_RESTART="/bin/systemctl restart o2cb"
        O2CB_STOP="/bin/systemctl stop o2cb"
fi

clean()
{
   umount /mnt/ocfs2
   ${O2CB_STOP}
   ${OCFS2_STOP}

   if [ -n "$loop_device" ]; then
     losetup -d /dev/$loop_device
   fi
   rmmod -s ocfs2
   rm -rf $loopfile
   cp o2cb.bak /etc/default/o2cb
   cp cluster.conf.bak /etc/ocfs2/cluster.conf
   rm -rf cluster.conf.bak o2cb.bak
   echo "Exit CSM.6.0 CSM.7.0 ocfs2 basic test"
}

# ocfs requires configfs
modprobe configfs


modprobe ocfs2
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "Failed to install ocfs2 kernel module."
   echo "----------------------------------------"
   dmesg | grep -i ocfs2
   echo "****************************************"
   cutfail
fi


fs=$(cat /proc/filesystems | grep ocfs2)
if [  ! "$fs" ]
then
   echo "****************************************"
   echo "No ocfs2 filesystems available on the"
   echo "target."
   echo "****************************************"
   cutfail
fi


mkfs_tools=$(whereis mkfs.ocfs2  | grep ocfs2)
if [  ! "$fs" ]
then
   echo "****************************************"
   echo "The required application mkfs.ocfs2"
   echo "is missing."
   echo "****************************************"
   cutfail
fi

#create a tmpfile
dd bs=1024 if=/dev/zero of=$loopfile count=66666
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "Failed to create a temp file for ocfs2"
   echo "Attempt the following manually:"
   echo "----------------------------------------"
   echo "> dd bs=1024 if=/dev/zero of=ocfs2.loop count=66666"
   echo "****************************************"
   cutfail
fi

mkfs.ocfs2  $loopfile
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "Failed to create an ocfs2 filesystem"
   echo "****************************************"
   cutfail
fi


#configure the ocfs2
cp /etc/default/o2cb o2cb.bak
cp  /etc/ocfs2/cluster.conf cluster.conf.bak

echo "O2CB_ENABLED=true" >  /etc/default/o2cb
echo "O2CB_BOOTCLUSTER=wrs001" >>  /etc/default/o2cb

echo "dump /etc/default/o2cb "
cat /etc/default/o2cb

echo "node:" >  /etc/ocfs2/cluster.conf
echo '	ip_port=7777' >>/etc/ocfs2/cluster.conf
echo '	ip_address=127.0.0.1' >>   /etc/ocfs2/cluster.conf
echo '	number=0' >> /etc/ocfs2/cluster.conf
echo "	name=$(hostname)" >> /etc/ocfs2/cluster.conf
echo '	cluster=wrs001' >> /etc/ocfs2/cluster.conf

echo 'cluster:' >> /etc/ocfs2/cluster.conf
echo '	node_count=1' >>  /etc/ocfs2/cluster.conf
echo '	name = wrs001'  >> /etc/ocfs2/cluster.conf
echo "dump /etc/ocfs2/cluster.conf "
cat /etc/ocfs2/cluster.conf

#start service
${O2cb_START}
${O2CB_RESTART}
checkerr "o2cb restart error"


${OCFS2_START}
${OCFS2_RESTART}
checkerr "ocfs2 resetart err"


#mount the ocfs2
modprobe ocfs2
checkerr "load ocfs2 module failed"

if [ ! -e /dev/loop0 ]; then mknod /dev/loop0 b 7 0; fi
if [ ! -e /dev/loop1 ]; then mknod /dev/loop1 b 7 1; fi
if [ ! -e /dev/loop2 ]; then mknod /dev/loop2 b 7 2; fi
if [ ! -e /dev/loop3 ]; then mknod /dev/loop3 b 7 3; fi
if [ ! -e /dev/loop4 ]; then mknod /dev/loop4 b 7 4; fi
if [ ! -e /dev/loop5 ]; then mknod /dev/loop5 b 7 5; fi
if [ ! -e /dev/loop6 ]; then mknod /dev/loop6 b 7 6; fi
if [ ! -e /dev/loop7 ]; then mknod /dev/loop7 b 7 7; fi

loop_device=
for i in 0 1 2 3 4 5 6 7; do
	if ! losetup -a | grep loop$i; then
		loop_device=loop$i
		break
	fi
done
if [ -z "$loop_device" ]; then
	echo "no available loop device"
	cutfail
fi

losetup $loop_device $loopfile
#this will tune heartbeat=local, read kernel fs/ocfs2/super.c
tunefs.ocfs2 --fs-features=local /dev/$loop_device

if [ ! -d /mnt/ocfs2 ]; then
	mkdir -p /mnt/ocfs2
fi
mount  $loopfile /mnt/ocfs2
checkerr "mount $loopfile failed"

cutpass
