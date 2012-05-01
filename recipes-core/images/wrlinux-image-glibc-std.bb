#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "An image which approximates WRLinux 4.3 glibc-std without graphics."

LICENSE = "MIT"

PR = "r0"

inherit core-image

# wrlinux feature definitions
#
PACKAGE_GROUP_rpm-plus = "rpm rpm-common rpm-build"
PACKAGE_GROUP_core-extended = "task-core-basic task-core-lsb"

# allows root login without a password
#
IMAGE_FEATURES += "debug-tweaks"

IMAGE_FEATURES += "apps-console-core"
IMAGE_FEATURES += "ssh-server-openssh"

# wrlinux features invoked
#
IMAGE_FEATURES += "rpm-plus core-extended"


# useful information while tuning filesystems
#
do_dumpo() {
    echo "Hi there!"
    echo "Distro features:  ${DISTRO_FEATURES}"
    echo "Image features:  ${IMAGE_FEATURES}"
    echo "Image contents:  ${IMAGE_INSTALL}"
    echo "Target arch:  ${TARGET_ARCH}"
    echo "Machine arch:  ${MACHINE_ARCH}"
    echo "Packages:  ${PACKAGE_INSTALL}"
    echo '${@base_contains("IMAGE_FEATURES", "debug-tweaks", "tweaking!", "no tweaking today",d)}'
    echo '${@base_contains("WRS_FEATURES", "no-busybox", "no busybox!", "just busybox",d)}'
    echo '${@base_contains("WRS_FEATURES", "busybox-plus", "busybox & utilites!", "just busybox",d)}'
}

addtask dumpo before do_rootfs



