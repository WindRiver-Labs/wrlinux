#
# Copyright (C) 2020 - 2021 Wind River Systems, Inc.
#
DESCRIPTION = "A full functional image that boots to a console."

require wrlinux-bin-image.inc

TARGET_IMAGE_INSTALL ?= " \
    kernel-modules \
    packagegroup-core-boot \
    gsettings-desktop-schemas \
"

IMAGE_INSTALL += "\
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', '${CONTAINER_CORE_BOOT}', '${TARGET_IMAGE_INSTALL}', d)} \
    openssh \
    ca-certificates \
    "

# Not needed by container image.
CONTAINER_IMAGE_REMOVE ?= "\
    ostree ostree-upgrade-mgr \
    docker \
    virtual/containerd \
    python3-docker-compose \
    linux-firmware-bcm43455 \
    linux-firmware-bcm43430 \
    u-boot-uenv \
    i2c-tools \
    alsa-utils \
    pm-utils \
    kernel-devicetree \
    kernel-image-image \
    kernel-module-brcmfmac \
    kernel-module-btbcm \
    kernel-module-bnep \
    kernel-module-hci-uart \
    kernel-module-snd-bcm2835 \
    kernel-module-spi-bcm2835 \
    kernel-module-i2c-bcm2835 \
    kernel-module-bcm2835-v4l2 \
    kernel-module-vc4 \
    kernel-module-v3d \
    kernel-module-bcm2835-gpiomem \
    boot-config u-boot \
    wr-themes \
    packagegroup-xfce-extended \
"

# No k8s by default
IMAGE_INSTALL_remove = "\
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', '${CONTAINER_IMAGE_REMOVE}', '', d)} \
    kubernetes \
"

# No recomendations for container image
NO_RECOMMENDATIONS = "${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', '1', '0', d)}"

# Remove debug-tweaks
IMAGE_FEATURES_remove = "debug-tweaks"

# Remove x11-base for container image
IMAGE_FEATURES_remove = "${@['', 'x11-base'][bb.utils.to_boolean(d.getVar('IMAGE_ENABLE_CONTAINER') or '0')]}"

# Remove x11 packages since the board doesn't support graphic display
IMAGE_FEATURES_remove_intel-socfpga-64 = "x11-base"
IMAGE_INSTALL_remove_intel-socfpga-64 = "packagegroup-xfce-extended wr-themes"

IMAGE_FEATURES_remove_nxp-s32g2xx = "x11-base"
IMAGE_INSTALL_remove_nxp-s32g2xx = "packagegroup-xfce-extended wr-themes"

IMAGE_FEATURES_remove_xilinx-zynq = "x11-base"
IMAGE_INSTALL_remove_xilinx-zynq = "packagegroup-xfce-extended wr-themes"

IMAGE_FEATURES_remove_ti-j72xx = "x11-base"
IMAGE_INSTALL_remove_ti-j72xx = "packagegroup-xfce-extended wr-themes"

IMAGE_FEATURES_remove_marvell-cn96xx = "x11-base"
IMAGE_INSTALL_remove_marvell-cn96xx = "packagegroup-xfce-extended wr-themes"

# Enable dhcpcd service if NetworkManager is not installed.
ROOTFS_POSTPROCESS_COMMAND += "enable_dhcpcd_service; "
enable_dhcpcd_service() {
    if [ ! -e ${IMAGE_ROOTFS}${sbindir}/NetworkManager \
        -a -f ${IMAGE_ROOTFS}${systemd_unitdir}/system/dhcpcd.service ]; then
        ln -sf ${systemd_unitdir}/system/dhcpcd.service \
            ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/dhcpcd.service
    fi
}
