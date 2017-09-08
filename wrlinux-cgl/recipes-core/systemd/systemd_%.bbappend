# Copyright (C) 2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_prepend := "${THISDIR}/systemd:"

SRC_URI += "\
	file://add-a-interface-to-skip-automount-devtmpfs-to-dev-pa.patch \
	"

