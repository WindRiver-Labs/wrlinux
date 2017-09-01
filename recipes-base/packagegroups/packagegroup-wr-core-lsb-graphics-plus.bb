#
# Copyright (C) 2012-2013 Wind River Systems Inc.
#
# This package matches a FEATURE_PACKAGES_packagegroup-wr-core-lsb-graphics-plus definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-lsb-graphics-plus" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: lsb-graphics-plus"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r1"

ALLOW_EMPTY_${PN} = "1"

inherit distro_features_check
# rdepends on packagegroup-core-lsb-desktop which rdepends on libx*
REQUIRED_DISTRO_FEATURES = "x11"

RDEPENDS_${PN} = " \
    jpeg \
    packagegroup-core-lsb-desktop \
    "

#Valid for all arches except mips64 with 64bit userspace
# mips64 with n32 has host: mips64-wrs-linux-gnun32
# mips64 with n64 has host: mips64-wrsmllib64-linux
# qemumips has host: mips-wrs-linux
# qemumips-64 has host: mips64-wrs-linux
COMPATIBLE_HOST = '((x86_64.*|i.86.*|powerpc.*|arm.*|aarch64.*|mips-.*|mips32.*)-linux|mips64.*-linux-gnun32)'
