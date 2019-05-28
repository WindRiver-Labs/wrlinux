# Copyright (C) 2015 Wind River Systems, Inc.
#
FILESEXTRAPATHS_prepend_df-cgl := "${THISDIR}/systemd:"

SRC_URI_append_df-cgl = " \
       file://add-a-interface-to-skip-automount-devtmpfs-to-dev-pa.patch \
	"

