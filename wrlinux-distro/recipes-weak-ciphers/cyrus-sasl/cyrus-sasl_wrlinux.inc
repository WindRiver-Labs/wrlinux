#
# Copyright (C) 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend_osv-wrlinux := "${THISDIR}/cyrus-sasl:"

SRC_URI_append_osv-wrlinux = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'file://openssl-no-des.patch', '', d)}"

PACKAGECONFIG_remove_osv-wrlinux = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'des', '', d)}"
