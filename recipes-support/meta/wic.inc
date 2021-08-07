SUMMARY = "Provide wic tool"
DESCRIPTION = "A wic tool which is working on Yocto build system \
poky (oe-core and bitbake)"

LICENSE = "GPL-2.0 & MIT"
LIC_FILES_CHKSUM = " \
    file://LICENSE.MIT;md5=030cb33d2af49ccebca74d0588b84a21 \
    file://LICENSE.GPL-2.0-only;md5=4ee23c52855c222cba72583d301d2338 \
"

SRCREV = "5890b72bd68673738b38e67019dadcbcaf643ed8"

SRC_URI = "git://git.yoctoproject.org/poky;branch=dunfell \
           file://wic_wrapper.sh \
           file://0001-fixup-native-python3-incorrect-searching.patch \
           file://0001-update-wic-help-create-for-sdk.patch \
           file://0001-get-FAKEROOTCMD-from-environment.patch \
           file://0001-get-vars-from-environment.patch \
           file://0001-wic-set-DEFAULT_OVERHEAD_FACTOR.patch \
           file://0001-wic-disable-psuedo-under-root.patch \
           "

S = "${WORKDIR}/git"

do_install() {
    install -d ${D}${datadir}
    cp -rf ${S} ${D}${datadir}/poky
    rm -rf ${D}${datadir}/poky/.git*

    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/wic_wrapper.sh ${D}${bindir}/wic
}

INSANE_SKIP_${PN} = "file-rdeps"