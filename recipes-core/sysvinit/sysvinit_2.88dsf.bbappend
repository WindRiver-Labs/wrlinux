#
# Copyright (C) 2012-2014 Wind River Systems, Inc.
#
# LOCAL REV: add WR specific scripts
#
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://sysvinit_2.88dsf-add-service-script.patch"

PR = "r500"

do_install_append () {
	install -m 0755 ${S}/debian/service/service ${D}${base_sbindir}/service
	install -m 0755 ${S}/debian/service/service.8 ${D}${mandir}/man8
	ln -sf ${base_sbindir}/service ${D}/${base_bindir}/service
}

# handy to include /etc/os-release
#
RRECOMMENDS_${PN} += "os-release"
