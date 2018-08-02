FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'weston-demo', 'file://weston.config', '', d)}"
HAS_XWAYLAND = "${@bb.utils.contains('DISTRO_FEATURES', 'weston-demo', 'yes', 'no', d)}"

do_install_append() {
	if [ "${HAS_XWAYLAND}" = "yes" ]; then
		install -Dm0755 ${WORKDIR}/weston.config ${D}${sysconfdir}/default/weston
	fi
}
