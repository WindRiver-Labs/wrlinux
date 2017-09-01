#
# Copyright (C) 2012-2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_append := "${THISDIR}/${BPN}-${PV}:"

SRC_URI_append := " file://valgrind-ppc-unequal-cache-line-size.patch \
                    file://eliminate-test-timeout.patch \
"

# don't build on powperpc e500v2 bsps for now
COMPATIBLE_HOST = '(i.86|x86_64|powerpc|powerpc64|arm).*-linux((?!spe).)*$'

COMPATIBLE_MACHINE_armv5 = "(none)"
COMPATIBLE_MACHINE_armv6 = "(none)"
