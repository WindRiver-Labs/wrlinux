#
# Copyright (C) 2020 Wind River Systems, Inc.
#
DESCRIPTION = "Provides container base app sdk for Wind River Linux Assembly Tool."

LICENSE = "MIT"

# Control the installed packages strictly
WRTEMPLATE_IMAGE = "0"

NO_RECOMMENDATIONS = "1"

SDKIMAGE_LINGUAS = ""

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
    ${@bb.utils.contains('PACKAGE_CLASSES','package_deb','containerd-opencontainers','virtual/containerd',d)} \
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
REQUIRED_DISTRO_FEATURES = "ostree lat"

# Make sure the existence of ostree initramfs image
do_populate_sdk[depends] += "initramfs-ostree-image:do_image_complete"

deltask do_populate_sdk_ext
