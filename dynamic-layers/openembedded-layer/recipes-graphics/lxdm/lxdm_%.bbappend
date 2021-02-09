#
# Copyright (C) 2015-2016 Wind River Systems, Inc.
#

# lxdm default theme is "Industrial"
# we change to use our own
DEFAULT_LXDM_THEME ?= "Windriver"

do_install_append() {
    sed -i -e 's,^disable=0,disable=1,' ${D}${sysconfdir}/lxdm/lxdm.conf

    # Set the default theme
    sed -i -e "s,^theme=.*,theme=${DEFAULT_LXDM_THEME}," ${D}${sysconfdir}/lxdm/lxdm.conf

    # Set the default session to xfce4
    sed -i -e "s,.*session=.*,session=${bindir}/startxfce4," ${D}${sysconfdir}/lxdm/lxdm.conf
}

RDEPENS_${PN} += "${@bb.utils.contains('DEFAULT_LXDM_THEME', 'Windriver', 'wr-themes-lxdm', '',d)}"
