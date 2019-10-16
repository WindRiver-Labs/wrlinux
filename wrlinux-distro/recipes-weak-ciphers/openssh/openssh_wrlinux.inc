#
# Copyright (C) 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/openssh:"

SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'file://fix-missing-macro-guards-of-ecc.patch', '', d)}"
