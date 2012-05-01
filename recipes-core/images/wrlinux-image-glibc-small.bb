#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "A foundational basic image that boots to a console."

LICENSE = "MIT"

PR = "r0"

inherit core-image


# allows root login without a password
#
IMAGE_FEATURES += "debug-tweaks"

# We override what gets set in core-image.bbclass
#
IMAGE_INSTALL = "\
    task-core-boot \
    "

# For debug purposes we dump info about the image
#
do_dumpo() {
    echo "Distro features:  ${DISTRO_FEATURES}"
    echo "Image features:  ${IMAGE_FEATURES}"
    echo "Image contents:  ${IMAGE_INSTALL}"
    echo "Target arch:  ${TARGET_ARCH}"
    echo "Machine arch:  ${MACHINE_ARCH}"
    echo "Packages:  ${PACKAGE_INSTALL}"
}

addtask dumpo before do_rootfs

