require ${COREBASE}/meta/recipes-core/images/core-image-minimal-initramfs.bb

export IMAGE_BASENAME = "wrlinux-image-minimal-initramfs"

QB_DEFAULT_FSTYPE = "cpio.gz"

inherit wrlinux-image

# Use PACKAGE_INSTALL as core-image-minimal-initramfs does to only
# install specific packages.
# Install busybox clearly in case no-busybox is enabled.
PACKAGE_INSTALL += "busybox"

# Install mdadm and necessary kernel module to initramfs
# to support boot from raid
PACKAGE_INSTALL_append_intel-x86-64 = " \
                mdadm \
                lvm2 \
                lvm2-udevrules \
                ${@bb.utils.contains('INITRAMFS_SCRIPTS', 'initramfs-module-udev', 'initramfs-module-lvm', '', d)} \
"
