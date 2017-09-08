#
# Copyright (C) 2015 Wind River Systems, Inc.
#
SUMMARY = "Implementation of the Service Availability Forum \
Application Interface Specification (AIS)"

DESCRIPTION = "OpenAIS is an open source implementation of the \
SA Forum (www.saforum.org) Application Interface Specification. \
The project currently implements APIs to improve availability \
by reducing MTTR. APIs available are cluster membership, \
application failover, checkpointing, eventing, distributed \
locking, messaging, closed process groups, and extended virtual \
synchrony passthrough. It is possible to write redundant \
applications that tolerate hardware, operating system, and \
application faults. Cluster software developers can write \
plugins to use the infrastructure provided by OpenAIS."

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=4cb00dd52a063edbece6ae248a2ba663"

DEPENDS = "corosync"
RDEPENDS_${PN}-testing = "${PN}"


SRC_URI = " \
      ftp://ftp@openais.org/downloads/openais-${PV}/openais-${PV}.tar.gz \
      file://fix-lcrso-linkage.patch \
      file://fix-replace-fnmatch-in-configure-ac.patch \
      file://openais-wr-no-html-docs.patch \
      file://openais-fix-init-script.patch \
      file://openais-saTmrTimerReschedule-test-error.patch \
      file://openais-fix-corosync-not-quit.patch \
      file://openais-fix-resource-cleanup-entry.patch \
      file://openais_init.d.patch \
      file://openais.service \
"

SRC_URI[md5sum] = "e500ad3c49fdc45d8653f864e80ed82c"
SRC_URI[sha256sum] = "974b4959f3c401c16156dab31e65a6d45bbf84dd85a88c2a362712e738c06934"

inherit autotools-brokensep pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "openais.service"
SYSTEMD_AUTO_ENABLE = "disable"

# install lcrso files into a common directory that corosync could find them
EXTRA_OECONF = "--with-lcrso-dir=${libdir}/lcrso"

EXCLUDE_FROM_WORLD = "${@bb.utils.contains('DISTRO_FEATURES', 'openais', '0', '1', d)}"

do_install_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -m 0755 -D ${D}${sysconfdir}/init.d/openais ${D}${datadir}/${BPN}/openais
        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/openais.service ${D}${systemd_system_unitdir}
        sed -i -e 's,@DATADIR@,${datadir},g' ${D}${systemd_system_unitdir}/openais.service
    fi

    mkdir -p ${D}/opt/${BPN}-tests/
    for i in ckptbench testckpt testclm testevt testlck testlck2 testmsg testmsg2 testmsg3 testtmr; do
        install -m 0755 ${S}/test/$i ${D}/opt/${BPN}-tests/
    done
}

PACKAGES =+ "${PN}-testing"
FILES_${PN} += "${libdir}/lcrso"
FILES_${PN}-testing += "/opt/${BPN}-tests/*"
FILES_${PN}-dbg += "${libdir}/lcrso/.debug /opt/${BPN}-tests/.debug"
