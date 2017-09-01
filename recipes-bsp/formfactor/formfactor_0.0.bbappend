#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#
# LOCAL REV: WR specific fixes
#   - Adding RDEPENDS on fbset, a WR specific package
#
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_${PN} += "fbset"
