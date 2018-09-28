#
# Copyright (C) 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'file://0001-fix-compileation-failure-if-openssl-disables-ecXXX-w.patch', '', d)}"
