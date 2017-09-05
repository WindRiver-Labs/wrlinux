#
# Copyright (C) 2012 Wind River Systems Inc.
#
# This package matches a FEATURE_PACKAGES_packagegroup-wr-core-security definition in
# core-image.bbclass that may be used to customize an image by
# adding "wr-core-security" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: security"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
  file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "

PR = "r2"

PACKAGES = "${PN}-utils ${PN}-trust \ 
            ${PN}-access ${PN}-detection \
            ${PN}-crypto ${PN}-auth ${PN}"

ALLOW_EMPTY_${PN}-utils = "1"
ALLOW_EMPTY_${PN}-trust = "1"
ALLOW_EMPTY_${PN}-access = "1"
ALLOW_EMPTY_${PN}-detection = "1"
ALLOW_EMPTY_${PN}-crypto = "1"
ALLOW_EMPTY_${PN}-auth = "1"
ALLOW_EMPTY_${PN} = "1"

# afong: These two were originally in the package list, no apps were using them, removed.
# 	libgssglue
# 	libmhash
RDEPENDS_${PN} = "\
	${PN}-utils \
	${PN}-trust \
	${PN}-access \
	${PN}-detection \
	${PN}-crypto \
	${PN}-auth \
        "

RDEPENDS_${PN}-utils = "\
	${@bb.utils.contains('BBFILE_COLLECTIONS', 'security', 'keyutils', '', d)} \
	nspr \
	${@bb.utils.contains('BBFILE_COLLECTIONS', 'security', 'xmlsec1', '', d)} \
        "

RDEPENDS_${PN}-trust = "\
	gnupg \
	${@bb.utils.contains('BBFILE_COLLECTIONS', 'security', 'keynote', '', d)} \
        "

RDEPENDS_${PN}-access = "\
	${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'audit auditd', '', d)} \
        "

RDEPENDS_${PN}-detection = "\
	${@bb.utils.contains('BBFILE_COLLECTIONS', 'security', 'samhain', '', d)} \
        "

RDEPENDS_${PN}-crypto = "\
	${@bb.utils.contains('BBFILE_COLLECTIONS', 'security', 'ecryptfs-utils', '', d)} \
	gnutls \
	nss \
        "

RDEPENDS_${PN}-auth = "\
	krb5 \
	pinentry \
        "

# jjmac: (2012.05.17)
#       Due back in security-core when package upreves are complete.
#        pyetree
