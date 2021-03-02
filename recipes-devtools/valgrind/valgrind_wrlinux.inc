#
# Copyright (C) 2012-2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI_append := " file://valgrind-ppc-unequal-cache-line-size.patch \
"
