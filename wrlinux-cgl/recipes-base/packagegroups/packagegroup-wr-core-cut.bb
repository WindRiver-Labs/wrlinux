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
  file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "


PACKAGES = "${PN}"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
        cyclictest \
        death-notify \
        gen-coredump \
        ipsec-test \
        libevent \
        cgl-unittest \
        expect \
        perf \
        saftest \
        "
