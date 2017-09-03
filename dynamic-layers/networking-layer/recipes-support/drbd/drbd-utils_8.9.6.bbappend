#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "\
file://0001-drbd-8.4.4-drbd-tools-only-rmmod-if-DRBD-is-a-module.patch \
"
#COMPATIBLE_HOST = "(i.86|x86_64|powerpc|powerpc64|aarch64|arm).*-linux*"

