DESCRIPTION = "Wind River logos for branding"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = "file://sidebar-logo.png \
           file://topbar-bg.png \
           ${@oe.utils.conditional('WRLINUX_BRANCH', 'LTS', 'file://banner_windriver_LTS.png', 'file://banner_windriver.png', d)} \
           file://COPYING"

S = "${WORKDIR}"

PACKAGE_ARCH = "all"

FILES_${PN} = "${datadir}/anaconda"

do_install() {
    install -d ${D}/${datadir}/anaconda/boot
    install -d ${D}/${datadir}/anaconda/pixmaps
    install -m 0755 sidebar-logo.png ${D}${datadir}/anaconda/pixmaps
    install -m 0755 topbar-bg.png ${D}${datadir}/anaconda/pixmaps
    install -d ${D}/${datadir}/anaconda/pixmaps/rnotes/en
    install -m 0755 banner_*.png ${D}/${datadir}/anaconda/pixmaps/rnotes/en
}
