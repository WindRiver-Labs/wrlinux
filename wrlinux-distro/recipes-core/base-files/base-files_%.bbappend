do_install_append_osv-wrlinux () {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'true', 'false', d)}; then
		sed -i -e 's/\/dev\/root[ ]*\/[ ]*[^ ]*[ ]*[^ ]*/&,iversion/' ${D}${sysconfdir}/fstab
	fi
}

BASEFILESISSUEINSTALL_osv-wrlinux = "do_install_wrlissue"

do_install_wrlissue () {
	if [ "${hostname}" ]; then
		echo ${hostname} > ${D}${sysconfdir}/hostname
	fi

	install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
	printf "${DISTRO_NAME} ${DISTRO_PRETTY_VERSION} " >> ${D}${sysconfdir}/issue
	printf "${DISTRO_NAME} ${DISTRO_PRETTY_VERSION} " >> ${D}${sysconfdir}/issue.net

	printf "\\\n \\\l\n" >> ${D}${sysconfdir}/issue
	echo >> ${D}${sysconfdir}/issue
	echo "%h" >> ${D}${sysconfdir}/issue.net
	echo >> ${D}${sysconfdir}/issue.net
}
