SUMMARY = "Chromium Virtual Keyboard"
DESCRIPTION = "Virtual Keyboard Extension for Chromium"
HOMEPAGE = "https://apps.xontab.com/VirtualKeyboard"
SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a8366463bacd4f2ec5edd419e8a113ff"

SRC_URI = " \
            git://github.com/xontab/${BPN}.git \
"
SRCREV = "e2b9adf4885cc4ed600cd9bccb77e0df8ff549aa"

S = "${WORKDIR}/git"
PV = "1.11.3+git${SRCPV}"

do_install() {
    install -d ${D}${datadir}/
    cp -r ${S} ${D}${datadir}/chrome-virtual-keyboard

    # remove unecessary artifacts
    rm  -f ${D}${datadir}/chrome-virtual-keyboard/_config.yml
    rm  -rf ${D}${datadir}/chrome-virtual-keyboard/.git/
}

FILES_${PN} += "${datadir}/chrome-virtual-keyboard"
