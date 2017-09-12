#
# Copyright (C) 2012-2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend_wrlinux-ovp := "${THISDIR}/${BPN}:"

SRC_URI_append_wrlinux-ovp = " \
            file://powerbtn \
            file://power.sh \
           "

# reorder to prevent ${PN} from picking up -default-scripts files
PACKAGES_wrlinux-ovp = "${PN}-dbg ${PN}-staticdev ${PN}-dev ${PN}-doc ${PN}-locale ${PN}-default-scripts ${PN}"

RDEPENDS_${PN}-default-scripts += "${BPN}"
FILES_${PN}-default-scripts = " \
    ${sysconfdir}/acpi/events/powerbtn \
    ${sysconfdir}/acpi/actions/power.sh \
    "

do_install_append_wrlinux-ovp () {
	install -d ${D}${sysconfdir}/acpi/events
	install -m 0444 ${WORKDIR}/powerbtn ${D}${sysconfdir}/acpi/events/.
	install -d ${D}${sysconfdir}/acpi/actions
	install -m 0755 ${WORKDIR}/power.sh ${D}${sysconfdir}/acpi/actions/.
}
