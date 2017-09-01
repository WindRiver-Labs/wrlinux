# This bbappend file is mainly to make connman work with systemd in situation
# where we are starting our target via nfs.
#
# Once this change is accepted by oe-core, this bbappend file should be removed
# from this layer.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://connman-systemd-wrapper"

do_install_append () {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
	install -d ${D}${sbindir}
	install -m 0755 ${WORKDIR}/connman-systemd-wrapper ${D}${sbindir}
	sed -i 's:@SBINDIR@:${sbindir}:g' ${D}${sbindir}/connman-systemd-wrapper
	sed -i 's#ExecStart=.*#ExecStart=${sbindir}/connman-systemd-wrapper#' ${D}${systemd_unitdir}/system/connman.service
    fi
}
