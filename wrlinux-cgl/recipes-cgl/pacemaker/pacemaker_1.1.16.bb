#
# Copyright (C) 2015, 2016, 2017 Wind River Systems, Inc.
#
SUMMARY = "Scalable High-Availability cluster resource manager"
DESCRIPTION = "Pacemaker is an advanced, scalable High-Availability cluster resource \
manager for Linux-HA (Heartbeat) and/or Corosync. \
It supports "n-node" clusters with significant capabilities for	\
managing resources and dependencies. \
It will run scripts at initialization, when machines go up or down, \
when related resources fail and can be configured to periodically check \
resource health."
HOMEPAGE = "www.clusterlabs.org"

LICENSE = "GPLv2+ & LGPLv2.1+"
LIC_FILES_CHKSUM = "file://COPYING;md5=19a64afd3a35d044a80579d7aafc30ff"

SRC_URI = "https://github.com/ClusterLabs/pacemaker/archive/Pacemaker-${PV}.tar.gz \
           file://fix-header-defs-lookup.patch \
           file://configure_ac.patch \
           file://fix-search-libesmtp-config.patch \
           file://pacemaker-use-pkg-config.patch"

SRC_URI_append_libc-uclibc = " file://kill-stack-protector.patch"

SRC_URI[md5sum] = "95798324b1a71195a47199ce633828ec"
SRC_URI[sha256sum] = "6b4b5c3f8571f57e46246a09c59b2ecbf59591b610bb3c9515e9ca84c834c75a"

inherit autotools-brokensep pythonnative pkgconfig systemd

DEPENDS = " \
	bzip2 \
	dbus \
	glib-2.0 \
	gnutls \
	libxml2 \
	libxslt \
	ncurses \
	util-linux \
	zlib \
	cluster-glue \
	cluster-resource-agents \
	corosync \
	libqb \
	net-snmp \
	"
#default configure will try like cman, corosync, snmp, heartbeat ...
#if not explicitly configure --with-
#explicitly need corosync to build

PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
PACKAGECONFIG[systemd] = "--enable-systemd,--disable-systemd,systemd"
PACKAGECONFIG[libesmtp] = "--with-esmtp=yes,--with-esmtp=no,libesmtp"

S = "${WORKDIR}/${BPN}-Pacemaker-${PV}"

SYSTEMD_SERVICE_${PN} = "pacemaker.service pacemaker_remote.service crm_mon.service"
SYSTEMD_AUTO_ENABLE = "disable"

#default OCF root place
#or get from Makefile which is from cluster-glue
OCF_ROOT_DIR = "/usr/lib/ocf"

#disable help2man and xmlhelp as it will run binary on host
EXTRA_OECONF = "--with-corosync=yes 	\
		--disable-fatal-warnings \
		--disable-pretty 	\
		--disable-upstart	\
		--with-lcrso-dir=${libdir}/lcrso \
		--libexecdir=${libdir} \
		ac_cv_path_HELP2MAN= 	\
		ac_cv_path_XSLTPROC= 	\
		ac_cv_path_SNMPCONFIG=${STAGING_BINDIR}/net-snmp-config	\
"

CFLAGS += "-I${STAGING_INCDIR}/heartbeat"

do_install_append() {
	find ${D} -name "*.pyo" -exec rm {} \;
	find ${D} -name "*.pyc" -exec rm {} \;
	find ${D} -name "*.py" | xargs sed -i -e "s:${STAGING_BINDIR_NATIVE}:${bindir}:g"
	#configuration file
	install -D -m 0644 ${S}/mcp/pacemaker.sysconfig ${D}${sysconfdir}/default/pacemaker
	rm -rf ${D}${localstatedir}/run
	rm -rf ${D}${localstatedir}/lib/heartbeat/cores
}

FILES_${PN}-doc += "${datadir}/pacemaker/crm_cli.txt ${datadir}/pacemaker/templates/"
FILES_${PN} += " \
	${OCF_ROOT_DIR}/resource.d \
	${datadir}/pacemaker/*.rng \
	${libdir}/service_crm.so \
	${libdir}/lcrso/pacemaker.lcrso \
	${base_libdir}/systemd/system \
	"
FILES_${PN}-dbg += "${libexecdir}/${BPN}/.debug ${libdir}/lcrso/.debug"

PACKAGES =+ "${PN}-tests ${PN}-snmp ${PN}-cli ${PN}-libs ${PN}-cluster-libs"

FILES_${PN}-tests = "${datadir}/pacemaker/tests ${datadir}/pacemaker/stonithdtest ${PYTHON_SITEPACKAGES_DIR}/cts"
RDEPENDS_${PN}-tests += "python-core bash"

FILES_${PN}-snmp = "${datadir}/snmp/mibs/PCMK-MIB.txt"

#follow fedora that cli contains command line tools that can be used
#to query and control the cluster from other devices which may or
#may not be part of the cluster.
FILES_${PN}-cli = " \
	${sbindir}/cibadmin ${sbindir}/crm_diff ${sbindir}/crm_mon \
	${sbindir}/crm_failcount ${sbindir}/crm_resource	\
	${sbindir}/crm ${sbindir}/crm_standby ${sbindir}/crm_verify\
	${sbindir}/crmadmin ${sbindir}/iso8601 ${sbindir}/ptest \
	${sbindir}/crm_shadow ${sbindir}/cibpipe	\
	${sbindir}/crm_simulate ${sbindir}/crm_report	\
	${sbindir}/crm_ticket ${PYTHON_SITEPACKAGES_DIR}/crm	\
	"
RDEPENDS_${PN}-cli += "python-core ${PN}-libs"
DESCRIPTION_${PN}-cli = "${DESCRIPTION} - cli tools"
SECTION_${PN}-cli = "apps"

FILES_${PN}-libs = " \
	${libdir}/libcib.so.* ${libdir}/libcrmcommon.so.*	\
	${libdir}/libpe_status.so.* ${libdir}/libpe_rules.so.*	\
	${libdir}/libpengine.so.* ${libdir}/libtransitioner.so.*	\
	"
DESCRIPTION_${PN}-libs = "${DESCRIPTION} - libraries for cluster and cli tools"
SECTION_${PN}-libs = "libs"

FILES_${PN}-cluster-libs = "${libdir}/libcrmcluster.so.* ${libdir}/libstonithd.so.*"
DESCRIPTION_${PN}-cluster-libs = "${DESCRIPTION} - libraries for cluster nodes"
SECTION_${PN}-cluster-libs = "libs"

RDEPENDS_${PN} += " ${PN}-cli ${PN}-libs ${PN}-cluster-libs cluster-resource-agents corosync perl"
RDEPENDS_${PN}-cluster-libs += " ${PN}-libs"
