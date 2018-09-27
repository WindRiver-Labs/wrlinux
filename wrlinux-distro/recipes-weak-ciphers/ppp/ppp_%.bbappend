#
# Copyright (C) 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " file://pppd-disable-MS-CHAP-authentication-support.patch"
