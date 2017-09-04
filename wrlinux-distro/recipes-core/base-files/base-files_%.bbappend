do_install_append_osv-wrlinux () {
	if [ 1 -eq ${@bb.utils.contains('DISTRO_FEATURES', 'ima', 1', '0', d)} ]; then
		sed -i -e 's/\/dev\/root[ ]*\/[ ]*[^ ]*[ ]*[^ ]*/&,iversion/' ${D}${sysconfdir}/fstab
	fi
}

