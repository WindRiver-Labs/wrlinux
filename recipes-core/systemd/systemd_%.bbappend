#
# Copyright (C) 2014 Wind River Systems, Inc.
#
# LOCAL REV: add WR specific scripts
#

DEPENDS += "systemd-systemctl-native"

SYSTEMD_DISABLED_SERVICES = " \
  systemd-udevd.service \
  systemd-udevd-control.socket \
  systemd-udevd-kernel.socket \
  proc-sys-fs-binfmt_misc.automount \
"

pkg_postinst_${PN}_append() {

ln -sf /dev/null $D${sysconfdir}/udev/rules.d/80-net-setup-link.rules

container_enable=${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'Yes', 'No', d)}

if [ X"${container_enable}" = "XYes" ]; then
	echo "Disabling the following systemd services in $D: "
	OPTS=""
	if [ -n "$D" ]; then
		OPTS="--root=$D"
	fi

	for i in ${SYSTEMD_DISABLED_SERVICES} ; do
		echo -n "$i: " ; systemctl ${OPTS} mask $i
	done
fi
}

do_install_append() {
        # Enable all sysrq functions
        if ${@bb.utils.contains('DISTRO_FEATURES','systemdebug','true','false',d)}; then
                sed -i -e 's/^kernel\.sysrq *=.*/kernel\.sysrq = 1/' ${D}/${exec_prefix}/lib/sysctl.d/50-default.conf
        fi
}
