SUMMARY = "OSI Certified implementation of a complete cluster engine"

DESCRIPTION = "The Corosync Cluster Engine is a Group Communication System with additional \
features for implementing high availability within applications. The project \
provides four C Application Programming Interface features: \
* A closed process group communication model with virtual synchrony guarantees \
for creating replicated state machines. \
* A simple availability manager that restarts the application process when \
it has failed. \
* A configuration and statistics in-memory database that provide the \
ability to set, retrieve, and receive change notifications of \
information. \
* A quorum system that notifies applications when quorum is \
achieved or lost."

HOMEPAGE = "https://corosync.github.io/corosync/"

LICENSE = "BSD"

DEPENDS = "groff-native nspr nss"

SRC_URI = "https://github.com/corosync/corosync/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
           file://corosync.conf \
           file://volatiles \
          "

inherit autotools update-rc.d pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "corosync.service corosync-notifyd.service"
SYSTEMD_AUTO_ENABLE = "disable"

INITSCRIPT_NAME = "corosync"
INITSCRIPT_PARAMS = "remove"

PACKAGECONFIG[dbus] = "--enable-dbus,--disable-dbus,dbus"
PACKAGECONFIG[snmp] = "--enable-snmp,--disable-snmp,net-snmp"

FILES_${PN}-doc += "${datadir}/snmp/mibs/COROSYNC-MIB.txt"

do_install_append() {
	install -D -m 0644 ${WORKDIR}/corosync.conf ${D}/${sysconfdir}/corosync/corosync.conf.example
	install -D -m 0644 ${S}/tools/corosync-notifyd.sysconfig.example ${D}${sysconfdir}/sysconfig/corosync-notifyd

	install -d ${D}${sysconfdir}/default/volatiles
	install -m 0644 ${WORKDIR}/volatiles ${D}${sysconfdir}/default/volatiles/05_corosync

	rm -rf ${D}${localstatedir}/run || :

	if ${@bb.utils.contains('PACKAGECONFIG', 'qnetd', 'true', 'false', d)}; then
		chown -R coroqnetd:coroqnetd ${D}${sysconfdir}/${BPN}/qnetd
	fi

	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		# corosync 2.x provides both init scripts for sysvinit and systemd
		# corosync 1.x only has init scripts for sysvinit, so install init script and service file
		if [ ! -f ${D}${datadir}/${BPN}/corosync ]; then
			install -d ${D}${datadir}/${BPN}
			cp ${D}/${sysconfdir}/init.d/* ${D}${datadir}/${BPN}/
		fi

		if [ ! -f ${D}${systemd_system_unitdir}/corosync.service ]; then
			install -d ${D}${systemd_system_unitdir}
			install -m 0644 ${WORKDIR}/corosync.service ${D}${systemd_system_unitdir}
			sed -i -e 's,@DATADIR@,${datadir},g' ${D}${systemd_system_unitdir}/corosync.service
			install -m 0644 ${WORKDIR}/corosync-notifyd.service ${D}${systemd_system_unitdir}
			sed -i -e 's,@SYSCONFDIR@,${sysconfdir},g' \
				-e 's,@SBINDIR@,${sbindir},g' ${D}${systemd_system_unitdir}/corosync-notifyd.service
		fi

		install -d ${D}${sysconfdir}/tmpfiles.d
		echo "d ${localstatedir}/log/cluster - - - -" > ${D}${sysconfdir}/tmpfiles.d/corosync.conf

		if ${@bb.utils.contains('PACKAGECONFIG', 'qnetd', 'true', 'false', d)}; then
			install -m 0644 ${S}/conf/tmpfiles.d/corosync-qnetd.conf ${D}${sysconfdir}/tmpfiles.d
		fi
	fi
}
