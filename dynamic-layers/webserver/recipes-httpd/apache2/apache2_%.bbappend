# LOCAL REV: related to files layout, selinux prefers Debian style.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://volatiles.04_apache2"

EXTRA_OECONF += "--enable-layout=Debian --prefix=${base_prefix}/"

do_configure_prepend() {
	sed -i -e 's:$''{prefix}/usr/lib/cgi-bin:$''{libdir}/cgi-bin:g' ${S}/config.layout
}

do_install_append() {
	install -d ${D}${sysconfdir}/default/volatiles
	install -m 0644 ${WORKDIR}/volatiles.04_apache2 ${D}${sysconfdir}/default/volatiles/04_apache2

	# The /var/run is introduced by the --enable-layout=Debian, remove it as
	# it is created on startup.
	rm -rf ${D}${localstatedir}/run
}

FILES_${PN} += "${libdir}/cgi-bin"

#Disable parallel make install
PARALLEL_MAKEINST = ""

FILES_${PN} += "${datadir}/${BPN}/"
