SUMMARY = "Initramfs kernel boot"
DESCRIPTION = "This package provides a compressed cpio image used for an \
initial ram disk for the kernel boot. Additionally, a kernel \
bundled with initramfs is included as well whenever \
feature/initramfs-install configured. \
"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

EXCLUDE_FROM_WORLD = "1"

DEPENDS = "virtual/kernel"

PROVIDES = "virtual/kernel-initramfs-image"

inherit kernelsrc kernel-arch

do_populate_lic[depends] += "virtual/kernel:do_deploy"
do_unpack[depends] += "virtual/kernel:do_deploy"

B = "${WORKDIR}/${BPN}-${PV}"

INSTALL_INITRAMFS = "${@'1' if d.getVar('INITRAMFS_IMAGE', True) and \
                               d.getVar('INITRAMFS_IMAGE_BUNDLE', True) != '1' and \
                               d.getVar('INITRAMFS_IMAGE_INSTALL', True) == '1' else '0'}"
INSTALL_BUNDLE    = "${@'1' if d.getVar('INITRAMFS_IMAGE', True) and \
                               d.getVar('INITRAMFS_IMAGE_BUNDLE', True) == '1' and \
                               d.getVar('INITRAMFS_IMAGE_INSTALL', True) == '1' else '0'}"

FILES_${PN} = "/boot/*"
ALLOW_EMPTY_${PN} = "1"
INITRAMFS_BASE_NAME = "${KERNEL_IMAGETYPE}-initramfs-${PV}-${PR}-${MACHINE}-${DATETIME}"
INITRAMFS_BASE_NAME[vardepsexclude] = "DATETIME"
INITRAMFS_EXT_NAME = "-${KERNEL_VERSION}"

python __anonymous () {
    image = d.getVar('INITRAMFS_IMAGE', True)
    if image:
        d.appendVarFlag('do_install', 'depends', ' ${INITRAMFS_IMAGE}:do_rootfs')
}

do_install() {
	if [ -z "${INITRAMFS_IMAGE}" ] ; then
		exit 0
	fi
	echo "Copying initramfs from ${DEPLOY_DIR_IMAGE} ..."
	if [ "x${INSTALL_INITRAMFS}" = "x1" ] ; then
		for img in cpio.gz cpio.lzo cpio.lzma cpio.xz; do
			if [ -e "${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.$img" ]; then
				install -d ${D}/boot
				install -m 0644 ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.$img ${D}/boot/${INITRAMFS_IMAGE}${INITRAMFS_EXT_NAME}.$img
				break
			fi
		done
	elif [ "x${INSTALL_BUNDLE}" = "x1" ] ; then
		if [ -e "${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin" ]; then
			install -d ${D}/boot
			install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin ${D}/boot/${KERNEL_IMAGETYPE}-initramfs${INITRAMFS_EXT_NAME}
		fi
	fi
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

pkg_postinst_${PN} () {
#!/bin/sh
    if [ "x${INSTALL_BUNDLE}" = "x1" ] ; then
        update-alternatives --install /boot/${KERNEL_IMAGETYPE} ${KERNEL_IMAGETYPE} /boot/${KERNEL_IMAGETYPE}-initramfs${INITRAMFS_EXT_NAME} 50101 || true
    fi
}

pkg_prerm_${PN} () {
#!/bin/sh
    if [ "x${INSTALL_BUNDLE}" = "x1" ] ; then
        update-alternatives --remove ${KERNEL_IMAGETYPE} ${KERNEL_IMAGETYPE}-initramfs${INITRAMFS_EXT_NAME} || true
    fi
}

