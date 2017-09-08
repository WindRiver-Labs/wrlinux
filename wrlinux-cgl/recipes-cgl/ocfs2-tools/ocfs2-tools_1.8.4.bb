#
# Copyright (C) 2016 Wind River Systems, Inc.
#
SUMMARY = "tools for managing OCFS2 cluster"
DESCRIPTION = "tools for managing OCFS2 cluster filesystems \
  OCFS2 is a general purpose cluster filesystem. Unlike the initial release \
  of OCFS, which supported only Oracle database workloads, OCFS2 provides \
  full support as a general purpose filesystem.  OCFS2 is a complete \
  rewrite of the previous version, designed to work as a seamless addition \
  to the Linux kernel. \
   \
  This package installs the tools to manage the OCFS2 filesystem, \
  including mkfs, tunefs, fsck, debugfs, and the utilities to control \
  the O2CB clustering stack."

HOMEPAGE = "http://oss.oracle.com/projects/ocfs2-tools/"

SECTION = "base"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"

DEPENDS += "e2fsprogs e2fsprogs-native glib-2.0 ncurses util-linux psmisc readline ncurses \
            libaio corosync python-pygobject-native\
           "

SRC_URI = "git://oss.oracle.com/git/ocfs2-tools.git \
           file://umode_t.patch \
           file://add-configure-option-ocfs2_controld.patch \
           file://disable-ocfs2-stack-user-support.patch \
           file://o2cb.service \
           file://ocfs2.service \
          "

SRCREV = "0b8be47d61dbdcd08d21c83f0b3993735b884ef9"

S = "${WORKDIR}/git"

inherit autotools-brokensep pythonnative pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "ocfs2.service o2cb.service"
SYSTEMD_AUTO_ENABLE = "disable"

PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'openais', 'openais', '', d)} \
"
PACKAGECONFIG[openais] = "--enable-ocfs2_controld=yes,--enable-ocfs2_controld=no,openais corosync pacemaker"

# This can't be enabled any more since python-pygtk was removed in oe-core
# the PACKAGECONFIG is kept and we will see if there is any alternative
# when upgraded.
PACKAGECONFIG[ocfs2console] = "--enable-ocfs2console=yes,--enable-ocfs2console=no,python-pygtk"

EXTRA_OECONF = "--sbindir=/sbin"

PARALLEL_MAKE = ""

do_configure_prepend () {
	# fix here or EXTRA_OECONF
	sed -i -e '/^PYTHON_INCLUDES="-I/c\
PYTHON_INCLUDES="-I=/usr/include/python${PYTHON_BASEVERSION}"' \
		${S}/pythondev.m4
	sed -i  -e 's:PYTHON_PREFIX/lib/python:PYTHON_PREFIX/${baselib}/python:' \
	    -e 's:PYTHON_EXEC_PREFIX}/lib/python:PYTHON_EXEC_PREFIX}/${baselib}/python:' \
		${S}/python.m4

	# fix the AIS_TRY_PATH which will search corosync|openais
	# AIS_TRY_PATH=":/usr/lib64/:/usr/lib:/usr/local/lib64:/usr/local/lib"
	sed -i -e '/^AIS_TRY_PATH=":\/usr\/lib64:/s;:;:=;g' ${S}/configure.in
}

do_install_append() {
	install -d ${D}${sysconfdir}/ocfs2
	install -m 0644 ${S}/documentation/samples/cluster.conf ${D}${sysconfdir}/ocfs2/cluster.conf.example

	install -d ${D}${sysconfdir}/default
	install -m 0644 ${S}/vendor/common/o2cb.sysconfig ${D}${sysconfdir}/default/o2cb

	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${S}/vendor/common/ocfs2.init ${D}${sysconfdir}/init.d/ocfs2
	install -m 0755 ${S}/vendor/common/o2cb.init ${D}${sysconfdir}/init.d/o2cb

	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -m 0644 ${WORKDIR}/o2cb.service ${D}${systemd_unitdir}/system/
		sed -i 's,@DATADIR@,${datadir},g' ${D}${systemd_unitdir}/system/o2cb.service
		install -m 0644 ${WORKDIR}/ocfs2.service ${D}${systemd_unitdir}/system/
		sed -i 's,@DATADIR@,${datadir},g' ${D}${systemd_unitdir}/system/ocfs2.service

		install -d ${D}${datadir}/ocfs2
		install -m 0755 ${S}/vendor/common/o2cb.init ${D}${datadir}/ocfs2/o2cb
		install -m 0755 ${S}/vendor/common/ocfs2.init ${D}${datadir}/ocfs2/ocfs2
	fi

	install -d ${D}${bindir}
	for i in ocfs2console o2image o2cb_ctl debugfs.ocfs2; do
		if [ -f ${D}${base_sbindir}/$i ]; then
			mv ${D}${base_sbindir}/$i ${D}${bindir}
		fi
	done
}

# default ocfs2console is enabled by configure
PACKAGES =+ "${PN}-console"
DESCRIPTION_${PN}-console = "tools for managing OCFS2 cluster filesystems - \
graphical interface"

FILES_${PN} += "${datadir}/ocfs2"
FILES_${PN}-console = "${sbindir}/ocfs2console ${PYTHON_SITEPACKAGES_DIR}/ocfs2interface/*"
FILES_${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/ocfs2interface/.debug"

RDEPENDS_${PN} = "bash python"
