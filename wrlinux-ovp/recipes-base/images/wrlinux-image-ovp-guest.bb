#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "An image suitable for a OVP guest."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"


require recipes-base/images/wrlinux-image-ovp-kvm-minimal.bb

# OVP specific packages
IMAGE_INSTALL += " \
    packagegroup-ovp-trace-tools \
    hwloc \
    system-report \
    acpid-default-scripts \
"

IMAGE_INSTALL_append_qemux86-64 = " dpdk"

# Taken from wr-base/recipes-base/images/wrlinux-image-glibc-std.bb
IMAGE_INSTALL += " \
    kernel-modules \
    packagegroup-base-extended \
    packagegroup-wr-base \
    packagegroup-containers \
    packagegroup-wr-base-net \
    packagegroup-wr-boot \
    "

# Taken from wr-base/recipes-base/images/wrlinux-image-glibc-std.bb
IMAGE_FEATURES += " \
    nfs-server \
    package-management \
    wr-core-db \
    wr-core-interactive \
    wr-core-net \
    wr-core-perl \
    wr-core-python \
    wr-core-sys-util \
    wr-core-util \
    wr-core-mail \
    "

COMPATIBLE_MACHINE = "qemux86|qemux86-64"
