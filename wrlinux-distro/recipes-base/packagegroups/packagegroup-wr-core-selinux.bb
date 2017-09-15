#
# Copyright (C) 2012 Wind River Systems Inc.
#
# This package matches a FEATURE_PACKAGES_packagegroup-wr-core-selinux definition in
# core-image.bbclass that may be used to customize an image by
# adding "wr-core-selinux" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: selinux"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
  file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "

inherit distro_features_check
# rdepends on packagegroup-core-lsb-desktop which rdepends on libx*
REQUIRED_DISTRO_FEATURES = "selinux"

PR = "r1"

PACKAGES = "${PN}-admin ${PN}-policy ${PN}-utils ${PN}"

# We need at least ONE policy
DEPENDS = "virtual/refpolicy"

ALLOW_EMPTY_${PN}-admin = "1"
ALLOW_EMPTY_${PN}-policy = "1"
ALLOW_EMPTY_${PN}-utils = "1"
ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
	${PN}-admin \
	${PN}-policy \
	${PN}-utils \
	"

RDEPENDS_${PN}-admin = "\
	sepolgen \
	"

RDEPENDS_${PN}-policy = "\
	refpolicy \
	"

RDEPENDS_${PN}-utils = "\
	checkpolicy \
	mcstrans \
	policycoreutils \
	policycoreutils-sandbox \
	policycoreutils-python \
	setools \
	setools-console \
	"
