#
# Copyright (C) 2012 Wind River Systems, Inc.
#
# LOCAL REV: CVE patch, not accepted by oe-core
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://libxml2-fix-CVE-2012-2807.patch \
	   "
