#
# Copyright (C) 2012 Wind River Systems Inc.
#
# This package matches a PACKAGE_GROUP_packagegroup-wr-core-cgl definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-cgl" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: cgl testing"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
  file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "


PACKAGES = "${PN}"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
        cyclictest \
        gen-coredump \
        ipsec-test \
        libevent \
        cgl-unittest \
        expect \
        perf \
        "
