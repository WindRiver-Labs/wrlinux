#
# Copyright (C) 2017 Wind River Systems, Inc.
#

inherit grub-efi
# Override the efi_hddimg_populate() from grub-efi.bbclass for copying
# signed efi/kernel images and their *.p7b files to hddimg:
#   ${IMAGE_ROOTFS}/boot/efi/EFI/   -> hddimg/
#   ${DEPLOY_DIR_IMAGE}/bzImage     -> hddimg/
#   ${DEPLOY_DIR_IMAGE}/bzImage.p7b -> hddimg/
#   ${DEPLOY_DIR_IMAGE}/*initramfs* -> hddimg/initrd

efi_hddimg_populate() {
    DEST=$1

    install -d ${DEST}${EFIDIR}

    bbnote "Trying to install ${IMAGE_ROOTFS}/boot/efi${EFIDIR} as ${DEST}/${EFIDIR}"
    if [ -d ${IMAGE_ROOTFS}/boot/efi${EFIDIR} ]; then
        cp -af ${IMAGE_ROOTFS}/boot/efi${EFIDIR}/* ${DEST}${EFIDIR}
    else
        bbwarn "${IMAGE_ROOTFS}/boot/efi${EFIDIR} doesn't exist"
    fi

    bbnote "Trying to install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} as ${DEST}/${KERNEL_IMAGETYPE}"
    # cleanup vmlinuz that deployed by OE
    rm -f ${DEST}/vmlinuz

    if [ -e ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ${DEST}/${KERNEL_IMAGETYPE}
        if [ -e ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.p7b ] ; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.p7b ${DEST}/${KERNEL_IMAGETYPE}.p7b
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.p7b ${DEST}/${KERNEL_IMAGETYPE}_bakup.p7b
        fi

        if [ -e ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.sig ] ; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.sig ${DEST}/${KERNEL_IMAGETYPE}.sig
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}.sig ${DEST}/${KERNEL_IMAGETYPE}_bakup.sig
        fi

        # create a backup kernel for recovery boot
        install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ${DEST}/${KERNEL_IMAGETYPE}_bakup
    else
        bbwarn "${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} doesn't exist"
    fi

    # allow to copy ${INITRD_IMAGE_LIVE} as initrd if ${INITRAMFS_IMAGE} was not built
    if [ -z "${INITRAMFS_IMAGE}" ]; then
        INITRAMFS_IMAGE=${INITRD_IMAGE_LIVE}
    fi

    if [ -n "${INITRAMFS_IMAGE}" ]; then
        initramfs=${INITRAMFS_IMAGE}-${MACHINE}.cpio.gz
        bbnote "Trying to install ${DEPLOY_DIR_IMAGE}/${initramfs} as ${DEST}/initrd"
        if [ -e ${DEPLOY_DIR_IMAGE}/${initramfs} ]; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs} ${DEST}/initrd
            if [ -e ${DEPLOY_DIR_IMAGE}/${initramfs}.p7b ] ; then
                install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs}.p7b ${DEST}/initrd.p7b
                install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs}.p7b ${DEST}/initrd_bakup.p7b
            fi
            if [ -e ${DEPLOY_DIR_IMAGE}/${initramfs}.sig ] ; then
                install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs}.sig ${DEST}/initrd.sig
                install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs}.sig ${DEST}/initrd_bakup.sig
            fi

            # create a backup initrd for recovery boot
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${initramfs} ${DEST}/initrd_bakup
        else
            bbwarn "${DEPLOY_DIR_IMAGE}/${initramfs} doesn't exist"
        fi
    fi

    # copy custom boot menu for hddimg:
    #  - initrd is always needed to mount rootfs from /dev/ram0 (rootfs.img)
    if [ -e ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc ${DEST}${EFIDIR}/boot-menu.inc
        if [ -e ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc.p7b ] ; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc.p7b ${DEST}${EFIDIR}/boot-menu.inc.p7b
        fi
        if [ -e ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc.sig ] ; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/boot-menu-hddimg.inc.sig ${DEST}${EFIDIR}/boot-menu.inc.sig
        fi
    fi
}

# Override the efi_populate_common() from live-vm-common.bbclass
# for feature efi-secure-boot.
# efi_populate_common DEST BOOTLOADER
efi_populate_common() {
        # DEST must be the root of the image so that EFIDIR is not
        # nested under a top level directory.
        DEST=$1

        install -d ${DEST}${EFIDIR}

        if [ "${EFI_PROVIDER}" = "extra_hddimg_populate" ]; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/${EFI_BOOT_IMAGE} ${DEST}${EFIDIR}/${EFI_BOOT_IMAGE}
        else
            install -m 0644 ${DEPLOY_DIR_IMAGE}/$2-${EFI_BOOT_IMAGE} ${DEST}${EFIDIR}/${EFI_BOOT_IMAGE}
        fi
        EFIPATH=$(echo "${EFIDIR}" | sed 's/\//\\/g')
        printf 'fs0:%s\%s\n' "$EFIPATH" "${EFI_BOOT_IMAGE}" >${DEST}/startup.nsh
}
