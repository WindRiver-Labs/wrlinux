#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "802.1q VLAN Implementation for Linux"
DESCRIPTION = "802.1q VLAN Implementation for Linux,See \
http://scry.wanfear.com/~greear/vlan.html for more information"
RRECOMMENDS_${PN} = "kernel-module-8021q"
HOMEPAGE = "http://www.candelatech.com/~greear/vlan.html"
SECTION = "network"
LICENSE = "GPL-2.0"

S = "${WORKDIR}/vlan/"

SRC_URI = "http://www.candelatech.com/~greear/vlan/${BPN}.${PV}.tar.gz \
    file://support-cross-build.patch \
"

inherit autotools-brokensep

do_install() {
    install -d "${D}${sbindir}"
    install -m 755 "${S}/vconfig" "${D}${sbindir}/vconfig"
}

LIC_FILES_CHKSUM = "file://vconfig.c;beginline=2;endline=18;md5=f127529ff725032a5ad6178492c50897"
SRC_URI[md5sum] = "5f0c6060b33956fb16e11a15467dd394"
SRC_URI[sha256sum] = "3b8f0a1bf0d3642764e5f646e1f3bbc8b1eeec474a77392d9aeb4868842b4cca"
