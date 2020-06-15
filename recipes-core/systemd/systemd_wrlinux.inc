#
# Copyright (C) 2014 Wind River Systems, Inc.
#
# LOCAL REV: add WR specific scripts
#

DEPENDS += "systemd-systemctl-native"

pkg_postinst_udev_append() {
	ln -sf /dev/null $D${sysconfdir}/udev/rules.d/80-net-setup-link.rules
}

do_install_append() {
        # Enable all sysrq functions
        if ${@bb.utils.contains('DISTRO_FEATURES','systemdebug','true','false',d)}; then
                sed -i -e 's/^kernel\.sysrq *=.*/kernel\.sysrq = 1/' ${D}/${exec_prefix}/lib/sysctl.d/50-default.conf
        fi
}
