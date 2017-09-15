#
# Copyright (C) 2015 Wind River Systems Inc.
#

DESCRIPTION = "Packagegroup for glusterfs components"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PACKAGE_ARCH = "${MACHINE_ARCH}"

ALLOW_EMPTY_${PN} = "1"

PACKAGES = "\
    packagegroup-glusterfs \
    packagegroup-glusterfs-dbg \
    packagegroup-glusterfs-dev \
"

RDEPENDS_packagegroup-glusterfs = "\
    fuse \
    fuse-utils \
    dpdk-dev-libibverbs \
    libulockmgr \
    glusterfs \
    glusterfs-rdma \
    glusterfs-geo-replication \
    glusterfs-fuse \
    glusterfs-server \
    xfsdump \
    xfsprogs \
"
