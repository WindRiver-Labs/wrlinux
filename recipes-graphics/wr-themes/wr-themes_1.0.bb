#
# Copyright (C) 2015 Wind River Systems, Inc.
#

SUMMARY = "Wind River Linux Desktop Themes"
DESCRIPTION = "This not a full theme for desktop environment, only includes \
               windriver branded desktop wallpapers and lxdm login theme. \
"
HOMEPAGE = "http://www.windriver.com"
SECTION = "x11"
LICENSE = "windriver"
LICENSE_FLAGS = "commercial_windriver"
LIC_FILES_CHKSUM = "file://COPYING;md5=eb3421117285c0b7ccbe9fbc5f1f37d7"

SRC_URI = "file://wallpapers \
           file://lxdm-theme \
           file://COPYING \
"

S = "${WORKDIR}"

# We have two theme for now: gray and blue,
# there maybe more in the future.
DEFAULT_WALLPAPER ?= "gray"

inherit distro_features_check

REQUIRED_DISTRO_FEATURES = "x11"

do_install() {
	install -d ${D}${datadir}/backgrounds/Windriver/
	install -m 0644 ${WORKDIR}/wallpapers/* ${D}/${datadir}/backgrounds/Windriver/

	install -d ${D}${datadir}/lxdm/themes/Windriver/
	install -m 0644 ${WORKDIR}/lxdm-theme/* ${D}${datadir}/lxdm/themes/Windriver/
	sed -i "s/%DEFAULT_BACKGROUND%/windriver-login-${DEFAULT_WALLPAPER}.png/" \
		${D}${datadir}/lxdm/themes/Windriver/gtkrc
}

PACKAGES += "${PN}-lxdm ${PN}-wallpapers"
ALLOW_EMPTY_${PN} = "1"

FILES_${PN}-lxdm = "${datadir}/lxdm/themes/Windriver/"
FILES_${PN}-wallpapers = "${datadir}/backgrounds/Windriver/"

RDEPENDS_${PN} = "lxdm xfdesktop ${PN}-lxdm ${PN}-wallpapers"
