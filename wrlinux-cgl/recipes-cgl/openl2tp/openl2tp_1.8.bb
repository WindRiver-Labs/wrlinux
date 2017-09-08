#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "An L2TP client/server, designed for VPN use."

DESCRIPTION = "\
OpenL2TP is a complete implementation of RFC2661 - Layer Two Tunneling \
Protocol Version 2, able to operate as both a server and a client. It \
is ideal for use as an enterprise L2TP VPN server, supporting more \
than 100 simultaneous connected users. It may also be used as a client \
home PC or roadwarrior laptop. OpenL2TP has been designed and \
implemented specifically for Linux. It consists of: \
\
-a daemon, openl2tpd, handling the L2TP control protocol exchanges \
for all tunnels and session a plugin for pppd to allow its \
PPP connections to run over L2TP sessions \
- a Linux kernel driver for efficient datapath (integrated into the \
standard kernel from 2.6.23).\
- a command line application, l2tpconfig, for management."

HOMEPAGE = "http://www.openl2tp.org"


DEPENDS = "readline flex ppp"

LICENSE = "GPLv2.0 & LGPL-2.1+"

LIC_FILES_CHKSUM = "file://COPYING;md5=e9d9259cbbf00945adc25a470c1d3585 \
                    file://LICENSE;md5=f8970abd5ea9be701a0deedf5afd77a5"

SRC_URI = "${SOURCEFORGE_MIRROR}/openl2tp/${BPN}-${PV}.tar.gz \
           file://openl2tpd-cli-parser-readline.patch \
           file://openl2tpd-initscript-fix.patch \
           file://openl2tpd-pedantic-compilation.patch \
           file://openl2tpd-enable-tests.patch \
           file://openl2tpd-initscript-fix-sysconfig.patch \
           file://openl2tpd-initscript-fix-warning.patch \
           file://makefile-add-ldflags.patch \
           file://openl2tpd.service \
           file://0001-openl2tp-remove-the-bashisms-from-openl2tpd.patch \
          "

SRC_URI[md5sum] = "e3d08dedfb9e6a9a1e24f6766f6dadd0"
SRC_URI[sha256sum] = "1c97704d4b963a87fbc0e741668d4530933991515ae9ab0dffd11b5444f4860f"

inherit systemd

SYSTEMD_SERVICE_${PN} = "openl2tpd.service"
SYSTEMD_AUTO_ENABLE = "disable"

EXTRA_OEMAKE = "CC='${CC}' LD='${CCLD}' AS='${AS}' \
	AR='${AR}' NM='${NM}' STRIP='${STRIP}' \
	DESTDIR='${D}' \
	SYS_LIBDIR='${libdir}'" 
PARALLEL_MAKE = ""

do_install () {
    oe_runmake PREFIX=${prefix} DESTDIR=${D} SYS_LIBDIR=${libdir} install
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${sysconfdir}/default
    install -m 0755 ${S}/etc/rc.d/init.d/openl2tpd ${D}${sysconfdir}/init.d/openl2tpd
    install -m 0755 ${S}/etc/sysconfig/openl2tpd ${D}${sysconfdir}/default/openl2tpd

    mkdir -p ${D}/opt/${BPN}/
    for i in all.tcl configfile.test peer_profile.test ppp_profile.test \
    session_profile.test session.test system.test test_procs.tcl \
    thirdparty_lns.test tunnel_profile.test tunnel.test; do
        install -m 0755 ${S}/test/$i ${D}/opt/${BPN}/
    done

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/openl2tpd.service ${D}${systemd_unitdir}/system
        sed -i -e 's,@STATEDIR@,${localstatedir},g' \
               -e 's,@SYSCONFDIR@,${sysconfdir},g' \
               -e 's,@SBINDIR@,${sbindir},g' \
               -e 's,@BINDIR@,${bindir},g' \
               -e 's,@BASE_SBINDIR@,${base_sbindir},g' \
               -e 's,@BASE_BINDIR@,${base_bindir},g' \
               ${D}${systemd_unitdir}/system/openl2tpd.service
    fi
}

PACKAGES += "${PN}-testing"
FILES_${PN}-testing += "/opt/openl2tp/*"
