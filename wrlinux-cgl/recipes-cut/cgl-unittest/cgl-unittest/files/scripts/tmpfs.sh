#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description : tmpfs partition check
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
  echo  "tmpfs partition check"
}


n=`mount | awk '{ if ( $5 == "tmpfs" ) print}' | wc -l`

if [ $n -gt 0 ] ; then
   cutpass
else
   echo "****************************************"
   echo "Failed to find a tmpfs-type filesystem"
   echo "mounted on the system"
   echo "----------------------------------------"
   mount
   echo "****************************************"
   cutfail
fi
