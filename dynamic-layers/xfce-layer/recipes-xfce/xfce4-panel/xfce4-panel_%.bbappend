#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://xfce4-panel-menu_48x48.png \
            file://xfce4-panel-menu_32x32.png \
            file://xfce4-panel-menu_24x24.png \
            file://xfce4-panel-menu_22x22.png \
            file://xfce4-panel-menu_16x16.png \
           "

do_install_append(){
    cp -f ${WORKDIR}/xfce4-panel-menu_48x48.png ${D}${datadir}/icons/hicolor/48x48/apps/xfce4-panel-menu.png
    cp -r ${WORKDIR}/xfce4-panel-menu_32x32.png ${D}${datadir}/icons/hicolor/32x32/apps/xfce4-panel-menu.png
    cp -r ${WORKDIR}/xfce4-panel-menu_24x24.png ${D}${datadir}/icons/hicolor/24x24/apps/xfce4-panel-menu.png
    cp -r ${WORKDIR}/xfce4-panel-menu_22x22.png ${D}${datadir}/icons/hicolor/22x22/apps/xfce4-panel-menu.png
    cp -r ${WORKDIR}/xfce4-panel-menu_16x16.png ${D}${datadir}/icons/hicolor/16x16/apps/xfce4-panel-menu.png
}
