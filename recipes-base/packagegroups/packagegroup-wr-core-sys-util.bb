#
# Copyright (C) 2012-2013-2013 Wind River Systems Inc.
#
# This package matches a FEATURE_PACKAGES_packagegroup-wr-core-sys-util definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-sys-util" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: sys-util"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r4"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = " \
    util-linux-fsck \
    e2fsprogs-e2fsck \
    e2fsprogs-mke2fs \
    elfutils \
    hdparm \
    iproute2 \
    iptables \
    iputils \
    iw \
    ldd \
    lsof \
    lvm2 \
    mdadm \
    mtd-utils \
    pam-plugin-wheel \
    parted \
    quota \
    sdparm \
    setserial \
    strace \
    tcf-agent \
    usbutils \
    watchdog \
    "
RRECOMMENDS_${PN} = " \
    mtd-utils-jffs2 \
    mtd-utils-ubifs \
    mtd-utils-misc \
    "

RDEPENDS_${PN}_append_x86 = " pmtools iasl"
RDEPENDS_${PN}_append_x86-64 = " pmtools iasl"
