#
# Copyright (C) 2012-2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_append := "${THISDIR}/valgrind-3.15.0:"

SRC_URI_append := " file://valgrind-ppc-unequal-cache-line-size.patch \
                    file://eliminate-test-timeout.patch \
"
