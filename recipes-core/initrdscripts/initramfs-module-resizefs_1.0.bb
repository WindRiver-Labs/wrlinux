SUMMARY = "initramfs-framework module for resize rootfs on wic image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
RDEPENDS_${PN} = " \
    initramfs-framework-base \
    e2fsprogs-resize2fs \
    util-linux-sfdisk \
    util-linux-blkid \
    util-linux-fdisk \
    util-linux-blockdev \
    grep \
    gawk \
"

SRC_URI = "file://resizefs_grub \
           file://resizefs_uboot \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/init.d
}

do_install_append_intel-x86-64() {
    install -m 0755 ${S}/resizefs_grub ${D}/init.d/10-resizefs
}

do_install_append_bcm-2xxx-rpi4() {
    install -m 0755 ${S}/resizefs_uboot ${D}/init.d/10-resizefs
}


FILES_${PN} = "/init.d/10-resizefs"

COMPATIBLE_MACHINE = "(intel-x86-64|bcm-2xxx-rpi4)"
