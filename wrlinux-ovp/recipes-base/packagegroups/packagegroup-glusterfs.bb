#
# Copyright (C) 2015 Wind River Systems Inc.
#

DESCRIPTION = "Packagegroup for glusterfs components"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
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
