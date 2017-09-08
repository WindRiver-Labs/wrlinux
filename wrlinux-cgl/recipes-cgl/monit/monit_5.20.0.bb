#
# Copyright (C) 2017 Wind River Systems, Inc.
#
SUMMARY = "Monit is a tool used for system monitoring and error recovery"
DESCRIPTION = "Monit is a free open source utility for managing and monitoring, processes, programs, files, directories and filesystems on a UNIX system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations."
HOMEPAGE = "http://mmonit.com/monit/"
BUGTRACKER = "https://savannah.nongnu.org/bugs/?group=monit"

LICENSE = "AGPL-3.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=ea116a7defaf0e93b3bb73b2a34a3f51"
DEPENDS = "openssl ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'libpam', '', d)}"

SRC_URI = "http://www.mmonit.com/monit/dist/${BP}.tar.gz \
           file://init \
           "

SRC_URI[md5sum] = "769a44ee13b4e1f90156b58dc2f7ea7c"
SRC_URI[sha256sum] = "ebac395ec50c1ae64d568db1260bc049d0e0e624c00e79d7b1b9a59c2679b98d"

INITSCRIPT_NAME = "monit"
INITSCRIPT_PARAMS = "defaults 99"

inherit autotools-brokensep update-rc.d systemd

EXTRA_OECONF += "\
                 --with-ssl-lib-dir=${STAGING_LIBDIR} \
                 --with-crypto-lib-dir=${STAGING_LIBDIR} \
                 --with-ssl-incl-dir=${STAGING_INCDIR} \
                 ${@bb.utils.contains('DISTRO_FEATURES', 'pam', '', '--without-pam', d)} \
                 libmonit_cv_setjmp_available=yes \
                 libmonit_cv_vsnprintf_c99_conformant=yes"

do_configure_prepend() {
    rm -rf ${S}/m4
}

do_install_append() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/monit
	sed -i 's:# set daemon  120:set daemon  120:' ${S}/monitrc
	sed -i 's:include /etc/monit.d/:include /${sysconfdir}/monit.d/:' ${S}/monitrc
	install -m 600 ${S}/monitrc ${D}${sysconfdir}/monitrc
	install -m 700 -d ${D}${sysconfdir}/monit.d/

	install -d ${D}${systemd_unitdir}/system
	install -D -m 0644 ${S}/system/startup/monit.service ${D}${systemd_unitdir}/system/monit.service
}

CONFFILES_${PN} += "${sysconfdir}/monitrc"
FILES_${PN} += "${systemd_unitdir}"
