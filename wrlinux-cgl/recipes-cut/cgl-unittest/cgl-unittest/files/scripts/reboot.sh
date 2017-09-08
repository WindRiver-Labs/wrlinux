#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description : Reboot test (manual actions required)
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
  echo  "****please test by hand"
}


# describe how to reboot blade with shelf management interface
echo "***********************************************************"
echo "A manual reboot is required."
echo "From the shelf manager for the ATCA shelf, reboot the board"
echo "***********************************************************"
result NOTRUN
exit 1
