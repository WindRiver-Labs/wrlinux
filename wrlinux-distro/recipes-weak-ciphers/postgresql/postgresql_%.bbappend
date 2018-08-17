#
# Copyright (C) 2017 - 2018 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " file://0001-postgresql-fix-openssl-no-des.patch"
