#
# Copyright (C) 2012 - 2017 Wind River Systems, Inc.
#
SUMMARY    ="Virtual Route Forwarding foundation package"

DESCRIPTION="Based on Linux container and underlying namespace, \
vrf package provides a framework to make easier to establish \
virtual router/switch with WRLinux"

SECTION    ="network"
LICENSE    ="GPLv2"
LIC_FILES_CHKSUM="file://COPYING;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI    = "file://vrf-1.1.tgz \
              file://vrf-package.list-remove-the-hardcoded-version-number.patch \
              file://vrf-helper-check-os-release-for-version-info.patch \
              file://vrf-create-add-the-mount-entry-for-tmp.patch \
              file://vrf-start-specify-the-delimiter-to-be-n-for-xargs.patch \
              file://vrf-stop-do-the-startup_stop_action-with-runtime-con.patch \
              file://vrf-attach-convert-the-key.patch \
              file://vrf-helper.in-down-device-before-change-its-name.patch \
              file://vrf-attach-make-interface-attach-when-vrf-stops.patch \
              file://vrf-attach-update-the-network-configuration-key.patch \
              file://vrf-create-do-not-create-var-run-and-var-lock.patch \
              file://vrf-fix-missing-var-and-lxc-rootfs-populating.patch \
"


S  = "${WORKDIR}/wrlinux-vrf"

#lxc-checkconfig depends on gzip's zgrep
RDEPENDS_${PN}   += "lxc libcgroup coreutils gzip"

#vlan and macvlan interfaces support in vrf
RRECOMMENDS_${PN} ="kernel-module-macvlan kernel-module-8021q"

inherit autotools

#configure where to store configuration files, vr's rootfs
#for example: /etc/vrf /usr/local/vrf
VRF_SYSDIR    = "/vrf/etc"
VRF_ROOTFSDIR = "/vrf/fs"

#define WRLINUX for example 
EXTRA_OECONF += "--with-vrf-sysconfdir='${VRF_SYSDIR}' \
	         --with-vrf-datadir='${VRF_ROOTFSDIR}' \
	         --enable-wrlinux"

do_install_append () {
    mv ${D}${VRF_SYSDIR}/package/wrlinux-cgl_package.list \
       ${D}${VRF_SYSDIR}/package/wrlinux-cgl_${WRLINUX_VERSION}_package.list
}


FILES_${PN}  += "${VRF_SYSDIR}/package/"
