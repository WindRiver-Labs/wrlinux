#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description : SElinux test (manual actions required)
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
  echo  "Exit selinux by-hand test "
}

cat <<- END

************************************************************
This test can only be executed manually.  Execute the
following steps to exercise this testcase. And please refer to
wrlinux-x/ Documentation/Features/SELinux/SELinux-README for
Selinux details.

On the host:
------------
1. Build the kernel with the following options:
   <install-dir>/wrlinux-3.0/wrlinux/configure 
      --enable-board=<target_board> --enable-kernel=cgl 
      --enable-rootfs=glibc_cgl --enable-test=yes

2. Build the rootfs and kernel:
   <build_directory>make fs

3. Boot the target with this rootfs and kernel.

On the target
-------------
1. Enable the default SELinux policy.

2. Create a regular user
   > useradd tester
   > passwd tester

3. Re-login as that user and verify that your policy is in place.
   > id -Z
   user_t

   Note: if it says something else here such as

      user_:system_r:unconfined_t

   the profile is improperly configured.  Contact the next
   level of support for assistance.

4. Find the context of a file that is outside the regular user's domain
   > ls -Z /
   ...
   dr-xr-xr-x  root root system_u:object_r:proc_t         proc/
   ...

   In this example, the directory proc/ is in the domain proc_t.  However,
   the regular user is only in the user_t domain (as seen in the previous
   step) and as a result, cannot examine the contents of /proc.

5. Create a new policy rule that will allow the user_t domain to examine
   contents within the proc_t domain.  Append the following into 
   your policy file:

   r_dir_file (user_t,proc_t)

   Reboot and verify that your regular user can now access /proc.

************************************************************
END

result NOTRUN
exit 1
