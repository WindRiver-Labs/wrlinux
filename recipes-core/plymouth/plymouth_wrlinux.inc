FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LOGO = "${datadir}/plymouth/wrl.png"

SRC_URI += " \
	file://wrl.png \
	file://windriver.plymouth \
	file://windriver.script \
	file://plymouthd.conf \
	file://plymouthd.defaults \
"

do_install_append() {
    install -d ${D}${datadir}/plymouth/themes/windriver
    install -m 0644 ${WORKDIR}/windriver.plymouth   ${D}${datadir}/plymouth/themes/windriver/
    install -m 0644 ${WORKDIR}/windriver.script   ${D}${datadir}/plymouth/themes/windriver/
    install -m 0644 ${WORKDIR}/wrl.png   ${D}${datadir}/plymouth/themes/windriver/
    install -m 0644 ${WORKDIR}/wrl.png ${D}${datadir}/plymouth
    install -m 0644 ${WORKDIR}/plymouthd.conf ${D}${sysconfdir}/plymouth/
    install -m 0644 ${WORKDIR}/plymouthd.defaults ${D}${datadir}/plymouth/

}
