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

# Set the following when a specific version is supported.
version="$1"

echo "#"
echo "# This file is generated based on:"
if [ -n "$version" ]; then
    echo "#     linux-yocto-${version}"
fi
echo "#     yocto-kernel-cache"
echo "#"
echo "# Any manual changes will be overwritten."
echo "#"

if [ -n "$version" ]; then
    echo
    echo "# linux-yocto-${version} entries"
    echo "# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>"
    echo "MACHINEOVERRIDES .= \":kb-\${@d.getVar('KBRANCH', True).replace(\"/\", \"-\")}\""
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
       # Skip any branch with 'rebase' in the name, these are only useful
       # for bisecting and should not be used by BSPs.
       if [ ${branch/rebase//} != ${branch} ]; then
         continue
       fi

       VERSION=$(git show $branch:Makefile | grep "^VERSION =" | sed s/.*=\ *//)
       PATCHLEVEL=$(git show $branch:Makefile | grep "^PATCHLEVEL =" | sed s/.*=\ *//)
       SUBLEVEL=$(git show $branch:Makefile | grep "^SUBLEVEL =" | sed s/.*=\ *//)
       EXTRAVERSION=$(git show $branch:Makefile | grep "^EXTRAVERSION =" | sed s/.*=\ *//)

       if [ -n "${version}" -a "${VERSION}.${PATCHLEVEL}" != "${version}" ]; then
          # Only capture information on the version we care about
          continue
       fi

       # Build a plain version string
       vers="${VERSION}.${PATCHLEVEL}"
       if [ -n "${SUBLEVEL}" ]; then
               # Ignoring a SUBLEVEL of zero is fine
               if [ "${SUBLEVEL}" != "0" ]; then
                       vers="${vers}.${SUBLEVEL}"
               fi
       fi
       vers="${vers}${EXTRAVERSION}"

       echo SRCREV_machine_kb-$(echo $branch | sed 's,refs/heads/,,' | sed 's,/,-,g') ?= \"$(git rev-parse $branch)\"
       echo LINUX_VERSION_kb-$(echo $branch | sed 's,refs/heads/,,' | sed 's,/,-,g') ?= \"${vers}\"
     done
    )
fi

echo
echo "# yocto-kernel-cache entries"
(
 if [ -d yocto-kernel-cache ]; then
   cd yocto-kernel-cache
 elif [ -d yocto-kernel-cache.git ]; then
   cd yocto-kernel-cache.git
 else
   echo "Unable to find yocto-kernel-cache repository." >&2
   exit 1
 fi
 for branch in `git for-each-ref --format='%(refname)' refs/heads | grep -- -wr` ; do
   # Process ONLY branches with '-wr' in the name...
   base_branch=$(echo $branch | sed 's,refs/heads/,,')
   base_version=$(echo $base_branch | sed 's,yocto-,,' | sed 's,-wr,,')
   if [ -n "${version}" -a "${base_version}" != "${version}" ]; then
      # Not the version we care about...
      continue
   fi
   echo KERNEL_CACHE_BRANCH_${base_version} = \"${base_branch}\"
   echo SRCREV_meta_${base_version} = \"$(git rev-parse ${base_branch})\"
   echo LINUX_VERSION_${base_version} = \"$(git show ${base_branch}:kver | sed 's,v,,')\"
 done
)
