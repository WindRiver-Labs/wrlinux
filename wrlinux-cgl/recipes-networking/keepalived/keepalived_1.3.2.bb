# Copyright (C) 2015, 2017 Wind River Systems, Inc.

DESCRIPTION = "High Availability monitor built upon LVS, VRRP and service pollers"
HOMEPAGE = "http://www.keepalived.org/"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "http://www.keepalived.org/software/${BP}.tar.gz \
           file://set-init-type.patch \
           "

SRC_URI[md5sum] = "744025d57c7f065c42fe925b0283897e"
SRC_URI[sha256sum] = "bb6729a7b7402ef5ef89e895b2dd597880702a4e2351d4da2f88bf24284e38f4"

DEPENDS = "libnfnetlink libnl openssl"

inherit autotools pkgconfig systemd update-rc.d

INITSCRIPT_NAME = "keepalived"
INITSCRIPT_PARAMS = "remove"

SYSTEMD_SERVICE_${PN} = "keepalived.service"
SYSTEMD_AUTO_ENABLE ?= "disable"

PACKAGECONFIG ??= "snmp"
PACKAGECONFIG[snmp] = "--enable-snmp,--disable-snmp,net-snmp"

EXTRA_OECONF = "--with-init-type=${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', 'SYSV', d)} \
                --with-systemdsystemunitdir=${systemd_system_unitdir} \
                --disable-libiptc \
                "
EXTRA_OEMAKE = "initdir=${sysconfdir}/init.d"

do_install_append() {
    if [ -f ${D}${sysconfdir}/init.d/${BPN} ]; then
        chmod 0755 ${D}${sysconfdir}/init.d/${BPN}
        sed -i 's#rc.d/##' ${D}${sysconfdir}/init.d/${BPN}
    fi

    install -D -m 0644 ${S}/${BPN}/${BPN}.service ${D}${systemd_system_unitdir}/${BPN}.service
}

FILES_${PN} += "${datadir}/snmp/mibs/KEEPALIVED-MIB.txt"
