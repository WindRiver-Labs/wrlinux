FILESEXTRAPATHS_prepend_wrlinux-ovp := "${THISDIR}/files:"

SRC_URI_append_wrlinux-ovp = " \
	file://rules-add-kvm-rule.patch \
"

FILES_udev_append_wrlinux-ovp = " ${rootlibexecdir}/udev/rules.d/99-kvm.rules"

PACKAGECONFIG_append_wrlinux-ovp = " resolved"
