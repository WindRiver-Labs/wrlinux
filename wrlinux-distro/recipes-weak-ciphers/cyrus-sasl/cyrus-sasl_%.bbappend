#
# Copyright (C) 2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend_osv-wrlinux := "${THISDIR}/${BPN}:"

SRC_URI_append_osv-wrlinux = " file://openssl-no-des.patch"

PACKAGECONFIG_remove_osv-wrlinux = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'des', '', d)}"
