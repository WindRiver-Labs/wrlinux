#
# Copyright (C) 2016 Wind River Systems, Inc.
#

require corosync.inc

LIC_FILES_CHKSUM = "file://LICENSE;md5=25656171d1e4054c636a9893067f8c30"

SRC_URI += "file://corosync.service \
            file://corosync-notifyd.service \
            file://corosync-remove-gplv3-code-for-1.x.patch \
            file://corosync-docs-in-makefile-am.patch;striplevel=0 \
            file://fix-replace-fnmatch-in-configure-ac.patch \
            file://corosync-docs-in-configure-ac.patch \
            file://corosync-wr-use-urandom.patch;striplevel=0 \
            file://fix-pkgconfig-in-configure_ac.patch \
            file://corosync-notifyd.patch \
            file://corosync-1.x-remove-bashisms.patch \
           "

SRC_URI[md5sum] = "5d39bc0c725dbbc6249eb6ef91542156"
SRC_URI[sha256sum] = "57a844b836ed426f92af772523c7b2a50d563203d550a4336d860eb06743e1b6"

PACKAGECONFIG ??= "dbus snmp"

# Note Corosync defaults to building with NSS support.
# lcrso dir should be a common place that other packages
# such as openais also install lsrso files to this directory
EXTRA_OECONF = "--disable-nss --disable-rdma --with-lcrso-dir=${libdir}/lcrso"

FILES_${PN} += "${libdir}/lcrso"
FILES_${PN}-dbg += "${libdir}/lcrso/.debug"
