SUMMARY = "initramfs-framework module for resize rootfs on wic image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
RDEPENDS_${PN} = " \
    initramfs-framework-base \
    e2fsprogs-resize2fs \
    e2fsprogs-e2fsck \
    gptfdisk \
"

SRC_URI = "file://resizefs_grub"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/init.d
}

do_install_append_intel-x86-64() {
    install -m 0755 ${S}/resizefs_grub ${D}/init.d/10-resizefs
}

FILES_${PN} = "/init.d/10-resizefs"

COMPATIBLE_MACHINE = "intel-x86-64"
