#
# Copyright (C) 2016 Wind River Systems, Inc.
#
SUMMARY = "Virtual EtherDrive blade AoE target"
SECTION = "console/network"
LICENSE = "GPL-2.0"

LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"

#integrate vblade.conf and vblade.init from Fedora vblade-14-6.fc12.src.rpm
SRC_URI = "${SOURCEFORGE_MIRROR}/aoetools/${BP}.tar.gz \
	   file://${BPN}.conf				\
	   file://${BPN}.init				\
	   file://${BPN}-makefile.patch			\
	   file://cross.patch				\
	   file://makefile-add-ldflags.patch		\
	   file://volatiles.99_vblade			\
	   file://vblade.service			\
	  "

SRC_URI[md5sum] = "510d98ba0f231284a5fbe2da11cb2d6e"
SRC_URI[sha256sum] = "a990378f273f10eb431e42954a871aed52714035bbab28c54cef600c458356bb"

inherit autotools-brokensep update-rc.d systemd

do_install_append() {
	install -D -m 0644 ${WORKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}.conf
	install -D -m 0755 ${WORKDIR}/${BPN}.init ${D}/${sysconfdir}/init.d/${BPN}

	if ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'true', 'false', d)}; then
		install -d ${D}/${sysconfdir}/default/volatiles
		install -m 0755 ${WORKDIR}/volatiles.99_vblade ${D}/${sysconfdir}/default/volatiles/99_vblade
	fi

	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -d ${D}/${bindir}
		install -m 0755 ${WORKDIR}/${BPN}.init ${D}/${bindir}/
		install -d ${D}${sysconfdir}/tmpfiles.d
		echo "d /var/run/${BPN} 0755 root root -" > ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf

	fi

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/vblade.service ${D}${systemd_unitdir}/system
	sed -e 's,@BINDIR@,${bindir},g' \
	    -i ${D}${systemd_unitdir}/system/*.service
}

INITSCRIPT_NAME = "vblade"
INITSCRIPT_PARAMS = "start 30 . stop 70 0 1 2 3 4 5 6 ."

SYSTEMD_SERVICE_${PN} = "vblade.service"
SYSTEMD_AUTO_ENABLE = "disable"

FILES_${PN} += "${systemd_unitdir}/*"
