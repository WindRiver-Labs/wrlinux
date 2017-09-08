#
# Copyright (C) 2012 - 2015 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
        file://fixpaths.patch   \
        file://net-snmp-5.6.1-ln-mysql.patch \
        file://net-snmp-fix-double-free.patch \
        file://nodpkg.patch   \
        file://rpm519.patch \
"
