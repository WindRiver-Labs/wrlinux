# Derived from c3-app-container.inc in meta-overc.  In recognition
# that not everyone that wants to build containers will be using
# meta-overc we include this file. This also assumes a distro other
# than 'overc' or 'wrlinux-overc' will be used, which in most cases is
# the correct assumption.

SUMMARY ?= "${PN} -- application container"
DESCRIPTION ?= "An application container which will run \
                the application(s) ${IMAGE_INSTALL}."
HOMEPAGE ?= "http://www.windriver.com"

LICENSE ?= "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

IMAGE_FSTYPES ?= "tar.bz2"
IMAGE_FSTYPES_remove = "live"

IMAGE_FEATURES ?= ""

inherit image
