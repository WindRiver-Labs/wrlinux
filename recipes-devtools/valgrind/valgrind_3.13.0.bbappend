#
# Copyright (C) 2012-2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_append := "${THISDIR}/${BPN}-${PV}:"

SRC_URI_append := " file://valgrind-ppc-unequal-cache-line-size.patch \
                    file://eliminate-test-timeout.patch \
"
