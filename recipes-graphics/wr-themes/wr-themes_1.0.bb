#
# Copyright (C) 2015 - 2020 Wind River Systems, Inc.
#

SUMMARY = "Wind River Linux Desktop Themes"
DESCRIPTION = "This not a full theme for desktop environment, only includes \
               windriver branded desktop wallpapers and lxdm login theme. \
"
HOMEPAGE = "http://www.windriver.com"
SECTION = "x11"
LICENSE = "MIT & CC-BY-ND-3.0"
LICENSE_FLAGS = "commercial_windriver"
LIC_FILES_CHKSUM = "file://CC-BY-ND-3.0;md5=009338acda935b3c3a3255af957e6c14 \
                    file://MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                   "

# Unpack directly to S.
#
SRC_URI = "file://wallpapers;subdir=${BP} \
           file://lxdm-theme;subdir=${BP} \
           file://COPYING;subdir=${BP} \
"

# We have two theme for now: gray and blue,
# there maybe more in the future.
#
DEFAULT_WALLPAPER ?= "gray"

inherit features_check

REQUIRED_DISTRO_FEATURES = "x11"

# Replace the default do_unpack to also unpack licenses.
#
python do_unpack () {
    import shutil
    bb.build.exec_func('base_do_unpack', d)
    ldir = d.getVar('COMMON_LICENSE_DIR')
    sdir = d.getVar('S')
    shutil.copy(ldir+'/CC-BY-ND-3.0',sdir)
    shutil.copy(ldir+'/MIT',sdir)
}

do_install() {
	install -d ${D}${datadir}/backgrounds/Windriver/
	install -m 0644 ${S}/wallpapers/* ${D}/${datadir}/backgrounds/Windriver/

	install -d ${D}${datadir}/lxdm/themes/Windriver/
	install -m 0644 ${S}/lxdm-theme/* ${D}${datadir}/lxdm/themes/Windriver/
	sed -i "s/%DEFAULT_BACKGROUND%/windriver-login-${DEFAULT_WALLPAPER}.png/" \
		${D}${datadir}/lxdm/themes/Windriver/gtkrc
       sed -i "s/%DEFAULT_BACKGROUND%/windriver-login-${DEFAULT_WALLPAPER}.png/" \
                ${D}${datadir}/lxdm/themes/Windriver/gtk.css
}

PACKAGES += "${PN}-lxdm ${PN}-wallpapers"
ALLOW_EMPTY_${PN} = "1"

FILES_${PN}-lxdm = "${datadir}/lxdm/themes/Windriver/"
FILES_${PN}-wallpapers = "${datadir}/backgrounds/Windriver/"

RDEPENDS_${PN} = "lxdm xfdesktop ${PN}-lxdm ${PN}-wallpapers"
