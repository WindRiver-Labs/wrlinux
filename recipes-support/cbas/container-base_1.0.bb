#
# Copyright (C) 2020 Wind River Systems, Inc.
#
DESCRIPTION = "Provides container base app sdk for CBAS."

LICENSE = "MIT"

# Control the installed packages strictly
WRTEMPLATE_IMAGE = "0"

NO_RECOMMENDATIONS = "1"

# Implementation of Full Image generator with Application SDK
TOOLCHAIN_HOST_TASK_append = " \
    nativesdk-wic \
    nativesdk-genimage \
    nativesdk-bootfs \
    nativesdk-appsdk \
"
TOOLCHAIN_TARGET_TASK_append = " qemuwrapper-cross"

POPULATE_SDK_PRE_TARGET_COMMAND += "copy_pkgdata_to_sdk;"
copy_pkgdata_to_sdk() {
    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata
    tar cfj ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata/pkgdata.tar.bz2 \
        -C ${TMPDIR}/pkgdata ${MACHINE}
}

POPULATE_SDK_PRE_TARGET_COMMAND += "copy_ostree_initramfs_to_sdk;"
copy_ostree_initramfs_to_sdk() {
    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/genimage/data/initramfs
    if [ -L ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.${INITRAMFS_FSTYPES} ];then
        cp -f ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.${INITRAMFS_FSTYPES} \
            ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/genimage/data/initramfs/
    fi
}

IMAGE_CLASSES += "qemuboot"
do_populate_sdk_prepend() {
    localdata = bb.data.createCopy(d)
    if localdata.getVar('MACHINE') == 'bcm-2xxx-rpi4':
        localdata.appendVar('QB_OPT_APPEND', ' -bios @DEPLOYDIR@/qemu-u-boot-bcm-2xxx-rpi4.bin')
    localdata.setVar('QB_MEM', '-m 512')

    bb.build.exec_func('do_write_qemuboot_conf', localdata)

    d.setVar('PACKAGE_INSTALL', 'packagegroup-base')
}


POPULATE_SDK_PRE_TARGET_COMMAND += "copy_qemu_data;"
copy_qemu_data() {
    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/qemu_data
    if [ -e ${DEPLOY_DIR_IMAGE}/qemu-u-boot-bcm-2xxx-rpi4.bin ]; then
        cp -f ${DEPLOY_DIR_IMAGE}/qemu-u-boot-bcm-2xxx-rpi4.bin ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/qemu_data/
    fi
    if [ -e ${DEPLOY_DIR_IMAGE}/ovmf.qcow2 ]; then
        cp -f ${DEPLOY_DIR_IMAGE}/ovmf.qcow2 ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/qemu_data/
    fi

    sed -e '/^staging_bindir_native =/d' \
        -e '/^staging_dir_host =/d' \
        -e '/^staging_dir_native = /d' \
        -e '/^kernel_imagetype =/d' \
        -e 's/^deploy_dir_image =.*$/deploy_dir_image = @DEPLOYDIR@/' \
        -e 's/^image_link_name =.*$/image_link_name = @IMAGE_LINK_NAME@/' \
        -e 's/^image_name =.*$/image_name = @IMAGE_NAME@/' \
        -e 's/^qb_default_fstype =.*$/qb_default_fstype = wic/' \
            ${IMGDEPLOYDIR}/container-base-${MACHINE}.qemuboot.conf > \
                ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/qemu_data/qemuboot.conf.in
}

# Make sure code changes can result in rebuild
do_populate_sdk[vardeps] += "extract_pkgdata_postinst"
SDK_POST_INSTALL_COMMAND += "${extract_pkgdata_postinst}"
extract_pkgdata_postinst() {
    cd $target_sdk_dir/sysroots/${SDK_SYS}${datadir}/pkgdata/;
    tar xf pkgdata.tar.bz2;
}

IMAGE_INSTALL = "\
    base-files \
    base-passwd \
    ${VIRTUAL-RUNTIME_update-alternatives} \
    openssh \
    ca-certificates \
    packagegroup-base \
    "

# - The ostree are not needed for container image.
# - No docker or k8s by default
IMAGE_INSTALL_remove = "\
    ostree ostree-upgrade-mgr \
    kubernetes \
    docker \
    virtual/containerd \
    python3-docker-compose \
"

# Only need tar.bz2 for container image
IMAGE_FSTYPES_remove = " \
    live wic wic.bmap ostreepush otaimg \
"

# No bsp packages for container
python () {
    d.setVar('WRTEMPLATE_CONF_WRIMAGE_MACH', 'wrlnoimage_mach.inc')
}

IMAGE_FEATURES += "package-management"

inherit wrlinux-image features_check
REQUIRED_DISTRO_FEATURES = "ostree cbas"

# Make sure the existence of ostree initramfs image
do_populate_sdk[depends] += "initramfs-ostree-image:do_image_complete"

deltask do_populate_sdk_ext
