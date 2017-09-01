#
# Copyright (C) 2013 -2016 Wind River Systems, Inc.
#

# This patch is used to fix ash memleak problem, but it's rejected by upstream.
FILESEXTRAPATHS_append := "${THISDIR}/${P}"
SRC_URI_append = " file://0001-ash-fix-memleak.patch"

# For glibc-tiny
FILESEXTRAPATHS_prepend_wrlinux-tiny := "${THISDIR}/${P}/wrlinux-tiny:"
