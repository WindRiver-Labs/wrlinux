do_install_append_osv-wrlinux () {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'true', 'false', d)}; then
		sed -i -e 's/\/dev\/root[ ]*\/[ ]*[^ ]*[ ]*[^ ]*/&,iversion/' ${D}${sysconfdir}/fstab
	fi
}

