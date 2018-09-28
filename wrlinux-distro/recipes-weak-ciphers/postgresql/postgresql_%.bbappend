#
# Copyright (C) 2017 - 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'file://0001-postgresql-fix-openssl-no-des.patch', '', d)}"
