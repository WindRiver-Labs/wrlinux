SUMMARY = "Provide poky metada for native recipe"
DESCRIPTION = "Provide poky metada for native recipe"

LICENSE = "GPL-2.0 & MIT"
LIC_FILES_CHKSUM = " \
    file://LICENSE.MIT;md5=030cb33d2af49ccebca74d0588b84a21 \
    file://LICENSE.GPL-2.0-only;md5=4ee23c52855c222cba72583d301d2338 \
"

SRCREV = "5890b72bd68673738b38e67019dadcbcaf643ed8"

SRC_URI = "git://git.yoctoproject.org/poky;branch=dunfell \
           "

S = "${WORKDIR}/git"


do_install() {
    install -d ${D}${datadir}
    cp -rf ${S} ${D}${datadir}/poky
    rm -rf ${D}${datadir}/poky/.git*
}

inherit native
