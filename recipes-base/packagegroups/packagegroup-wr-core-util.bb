#
# Copyright (C) 2012-2013 Wind River Systems Inc.
#
# This package matches a FEATURE_PACKAGES_packagegroup-wr-core-util definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-util" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: util"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r3"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = " \
    at \
    bzip2 \
    cronie \
    diffutils \
    gzip \
    ncurses-terminfo \
    tcl \
    tzdata \
    unzip \
    which \
    zip \
    "
