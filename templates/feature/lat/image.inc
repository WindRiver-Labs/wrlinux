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
    if [ -e ${DEPLOY_DIR}/${IMAGE_PKGTYPE}/.pkgdata.tar.bz2 -a -e ${DEPLOY_DIR}/${IMAGE_PKGTYPE}/.pkgdata.tar.bz2.sha256sum ]; then
        cp ${DEPLOY_DIR}/${IMAGE_PKGTYPE}/.pkgdata.tar.bz2 \
            ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata/pkgdata.tar.bz2
        cp ${DEPLOY_DIR}/${IMAGE_PKGTYPE}/.pkgdata.tar.bz2.sha256sum \
            ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata/pkgdata.tar.bz2.sha256sum
    fi

    if [ ! -e ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata/pkgdata.tar.bz2 ]; then
        copy_pkgdata ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata
    fi
}

copy_pkgdata() {
    dest=$1
    install -d $dest
    tar cfj $dest/pkgdata.tar.bz2 -C ${TMPDIR}/pkgdata ${MACHINE}
    (
        cd $dest;
        sha256sum pkgdata.tar.bz2 > pkgdata.tar.bz2.sha256sum
    )
}

POPULATE_SDK_PRE_TARGET_COMMAND += "copy_ostree_initramfs_to_sdk;"
copy_ostree_initramfs_to_sdk() {
    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/genimage/data/initramfs
    if [ -L ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.${INITRAMFS_FSTYPES} ];then
        cp -f ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.${INITRAMFS_FSTYPES} \
            ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/genimage/data/initramfs/
    fi
}

do_populate_sdk_prepend() {
    localdata = bb.data.createCopy(d)
    if localdata.getVar('MACHINE') == 'bcm-2xxx-rpi4':
        localdata.appendVar('QB_OPT_APPEND', ' -bios @DEPLOYDIR@/qemu-u-boot-bcm-2xxx-rpi4.bin')
    localdata.setVar('QB_MEM', '-m 512')

    bb.build.exec_func('do_write_qemuboot_conf', localdata)
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

    qemuboot_conf="${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.qemuboot.conf"
    if [ -e $qemuboot_conf ]; then
        sed -e '/^staging_bindir_native =/d' \
            -e '/^staging_dir_host =/d' \
            -e '/^staging_dir_native = /d' \
            -e '/^kernel_imagetype =/d' \
            -e 's/^deploy_dir_image =.*$/deploy_dir_image = @DEPLOYDIR@/' \
            -e 's/^image_link_name =.*$/image_link_name = @IMAGE_LINK_NAME@/' \
            -e 's/^image_name =.*$/image_name = @IMAGE_NAME@/' \
            -e 's/^qb_default_fstype =.*$/qb_default_fstype = wic/' \
                $qemuboot_conf > \
                    ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/qemu_data/qemuboot.conf.in
    fi
}

POPULATE_SDK_PRE_TARGET_COMMAND += "copy_bootfile;"
copy_bootfile() {
	if [ -n "${BOOTFILES_DIR_NAME}" -a -d "${DEPLOY_DIR_IMAGE}/${BOOTFILES_DIR_NAME}" ]; then
	    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/bootfiles
		cp -rf ${DEPLOY_DIR_IMAGE}/${BOOTFILES_DIR_NAME} ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/bootfiles/
	fi
}

# Make sure code changes can result in rebuild
do_populate_sdk[vardeps] += "extract_pkgdata_postinst"
SDK_POST_INSTALL_COMMAND += "${extract_pkgdata_postinst}"
extract_pkgdata_postinst() {
    cd $target_sdk_dir/sysroots/${SDK_SYS}${datadir}/pkgdata/;
    mkdir $target_sdk_dir/sysroots/pkgdata;
    tar xf pkgdata.tar.bz2 -C $target_sdk_dir/sysroots/pkgdata;
}
