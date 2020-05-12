#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "An image suitable for a KVM host."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"


require recipes-base/images/wrlinux-image-ovp-kvm-minimal.bb

IMAGE_INSTALL += " \
    kernel-modules \
    packagegroup-base-extended \
    packagegroup-wr-base \
    packagegroup-wr-base-net \
    packagegroup-wr-boot \
    "

IMAGE_INSTALL += " \
   qemu \
   tunctl \
   udev \
   udev-extraconf \
   libvirt \
   libvirt-virsh \
   libvirt-libvirtd \
   socat \
   openvswitch \
   hwloc \
   aufs-util \
   packagegroup-ovp-debug \
   packagegroup-ovp-lttng-toolchain \
   packagegroup-containers \
   packagegroup-ovp-default-monitoring \
   packagegroup-ovp-criu \
   packagegroup-glusterfs \
   packagegroup-ovp-docker \
   spice \
   celt051 \
   python3-pyparsing \
   schedtool-dl \
   dpdk \
   ceph \
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

# enable build out .ext4 image file, shall be useful for qemu
IMAGE_FSTYPES += "ext4"
