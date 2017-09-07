#
# Copyright (C) 2012-2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend_wrlinux-ovp := "${THISDIR}/${BPN}:"

SRC_URI_append_wrlinux-ovp = " \
            file://powerbtn \
            file://power.sh \
           "

PACKAGES_append_wrlinux-ovp = " ${PN}-default-scripts"
RDEPENDS_${PN}-default-scripts += "${BPN}"
FILES_${PN}-default-scripts = "${sysconfdir}/acpi/events/* ${sysconfdir}/acpi/actions/*"

do_install_append_wrlinux-ovp () {
	install -d ${D}${sysconfdir}/acpi/events
	install -m 0444 ${WORKDIR}/powerbtn ${D}${sysconfdir}/acpi/events/.
	install -d ${D}${sysconfdir}/acpi/actions
	install -m 0755 ${WORKDIR}/power.sh ${D}${sysconfdir}/acpi/actions/.
}
