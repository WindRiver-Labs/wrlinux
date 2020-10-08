include wic.inc

RDEPENDS_${PN} += " \
    nativesdk-python3 \
    nativesdk-parted \
    nativesdk-syslinux \
    nativesdk-gptfdisk \
    nativesdk-dosfstools \
    nativesdk-mtools \
    nativesdk-bmap-tools \
    nativesdk-btrfs-tools \
    nativesdk-squashfs-tools \
    nativesdk-pseudo \
    nativesdk-e2fsprogs \
    nativesdk-e2fsprogs-mke2fs \
    nativesdk-e2fsprogs-e2fsck \
    nativesdk-util-linux \
    nativesdk-tar \
    nativesdk-chrpath \
"

FILES_${PN} += "${SDKPATHNATIVE}"

do_install_append() {
    ln -snf -r ${D}${datadir}/poky/meta/recipes-core/systemd/systemd-systemctl/systemctl ${D}${bindir}/systemctl
}

inherit nativesdk
