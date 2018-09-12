#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "Monit is a tool used for system monitoring and error recovery"
DESCRIPTION = "Monit is a free open source utility for managing and monitoring, processes, programs, files, directories and filesystems on a UNIX system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations."
HOMEPAGE = "http://mmonit.com/monit/"
BUGTRACKER = "https://savannah.nongnu.org/bugs/?group=monit"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=393a5ca445f6965873eca0259a17f833"
DEPENDS = "openssl ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'libpam', '', d)} bison-native"

SRC_URI = "http://ftp.twaren.net/BSD/OpenBSD/distfiles/monit-${PV}.tar.gz \
           file://wr-monit-ssl-fix.patch \
           file://init \
           file://monit-INSTALL_PROG.patch \
           file://monit-cpu-num.patch \
           file://monit-wr-make-parser-deps.patch \
           file://monit.service \
           file://0001-disable-SSLv2.patch \
          "

SRC_URI[md5sum] = "bcbaab776a54d1e34e3a057c925de9ca"
SRC_URI[sha256sum] = "6963046fa976b682d27ac8e78cf7107d76c6907aef27b30f725f371ce64fb4bf"

INITSCRIPT_NAME = "monit"
INITSCRIPT_PARAMS = "defaults 99"

inherit autotools-brokensep update-rc.d systemd

EXTRA_OECONF += "\
                 --with-ssl-lib-dir=${STAGING_LIBDIR} \
                 --with-crypto-lib-dir=${STAGING_LIBDIR} \
                 --with-ssl-incl-dir=${STAGING_INCDIR} \
                 ${@bb.utils.contains('DISTRO_FEATURES', 'pam', '', '--without-pam', d)}"

do_install_append() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/monit
	sed -i 's:# set daemon  120:set daemon  120:' ${S}/monitrc
	sed -i 's:include /etc/monit.d/:include /${sysconfdir}/monit.d/:' ${S}/monitrc
	install -m 600 ${S}/monitrc ${D}${sysconfdir}/monitrc
	install -m 700 -d ${D}${sysconfdir}/monit.d/

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/monit.service ${D}${systemd_unitdir}/system
	sed -i -e 's,@BINDIR@,${bindir},g' ${D}${systemd_unitdir}/system/*.service
}

CONFFILES_${PN} += "${sysconfdir}/monitrc"
FILES_${PN} += "${systemd_unitdir}"
