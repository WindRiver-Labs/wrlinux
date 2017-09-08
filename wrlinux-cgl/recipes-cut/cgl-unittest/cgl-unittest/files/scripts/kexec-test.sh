#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description : kexec basic test
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
  rm -rf kexec.success
  echo  "kexec basic test"
}
echo -n "Testing kexec, this test will reboot your target(rebooting indicate PASS)....: "

[[ -f  kexec.success ]] && cutpass

echo "PASS">kexec.success

#for ppc
arch_type=`uname -m|grep "ppc"`
if [ ! -z $arch_type ]
then
	image_name="uImage"
fi

#for ppc64
arch_type=`uname -m|grep "ppc64"`
if [ ! -z $arch_type ]
then
	image_name="vmlinux*"
fi

#for i86
arch_type=`uname -m|grep "86"`
if [ ! -z $arch_type ]
then
	image_name="bzImage"
fi

#for arm, not test since cgl is not supported
arch_type=`uname -m|grep "arm"`
if [ ! -z $arch_type ]
then
	image_name="uImage"
fi

#for mips, not test since cgl is not supported
arch_type=`uname -m|grep "mips"`
if [ ! -z $arch_type ]
then
	image_name="vmlinux"
fi

[ -f /boot/$image_name ] || cutna "Skipped the test as no /boot/$image_name on the system"

INSTALL_KERNEL=$(find `pwd` -iname kexec-test-install)
$INSTALL_KERNEL /boot $image_name

kernel=$(find `pwd` -iname $image_name) &&  \
kexec -l  $kernel --append="`cat /proc/cmdline`"  && \
kexec -e

#here should reboot
rm kexec.success

echo "****************************************"
echo "Automatic kexec failed."
echo "Manual execution required."
echo "----------------------------------------"
echo "1. load the kernel to kexec into"
echo "   > kexec -l <kernel> --append=\"\'cat /proc/cmdline\`\"" 
echo "2. execute the kernel"
echo "   > kexec -e"
echo "If successful, the new kernel will start without"
echo "the target having to reboot through the BIOS."
echo "****************************************"
cutfail

