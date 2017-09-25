#
# Copyright (C) 2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " file://openssl-no-des.patch"

PACKAGECONFIG_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'des', '', d)}"
