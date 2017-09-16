#! /bin/bash
#
# gen-linux-srcrev: Generate the SRCREV_machine entries for the
#                   linux-yocto recipe
#
#  Copyright (c) 2017 Wind River Systems, Inc.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License version 2 as
#  published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

# Run this script from the wr-kernel/git directory.

version="4.12"

echo "#"
echo "# This file is generated based on the linux-yocto-${version} and "
echo "# yocto-kernel-cache repos."
echo "#"
echo "# Any manual changes will be overwritten."
echo "#"
echo
echo "MACHINEOVERRIDES =. \"kb-\${@d.getVar('KBRANCH', True).replace(\"/\", \"-\")}:\""
echo
echo "# linux-yocto-${version} branch entries"
(
 if [ -d linux-yocto-${version} ]; then
   cd linux-yocto-${version}
 elif [ -d linux-yocto-${version}.git ]; then
   cd linux-yocto-${version}.git
 else
   echo "Unable to find linux-yocto-${version} repository." >&2
   exit 1
 fi
 for branch in `git for-each-ref --format='%(refname)' refs/heads` ; do
   echo SRCREV_machine_kb-$(echo $branch | sed 's,refs/heads/,,' | sed 's,/,-,g') ?= \"$(git rev-parse $branch)\"
 done
)

echo
echo "# yocto-kernel-cache branch entry"
(
 if [ -d yocto-kernel-cache ]; then
   cd yocto-kernel-cache
 elif [ -d yocto-kernel-cache.git ]; then
   cd yocto-kernel-cache.git
 else
   echo "Unable to find yocto-kernel-cache repository." >&2
   exit 1
 fi
 echo SRCREV_meta = \"$(git rev-parse yocto-${version})\"
 echo
 echo LINUX_VERSION = \"$(git show yocto-${version}:kver | sed 's,v,,')\"
)

