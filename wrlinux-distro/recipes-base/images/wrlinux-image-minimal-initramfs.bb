require ${COREBASE}/meta/recipes-core/images/core-image-minimal-initramfs.bb

export IMAGE_BASENAME = "wrlinux-image-minimal-initramfs"

QB_DEFAULT_FSTYPE = "cpio.gz"

inherit wrlinux-image

# Use PACKAGE_INSTALL as core-image-minimal-initramfs does to only
# install specific packages.
# Install busybox clearly in case no-busybox is enabled.
PACKAGE_INSTALL += "busybox"
