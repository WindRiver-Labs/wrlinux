#
# Copyright (C) 2015 Wind River Systems, Inc.
#
SUMMARY = "Reusable cluster components"
DESCRIPTION = \
"Cluster Glue is a set of libraries, tools and utilities suitable for \
the Heartbeat/Pacemaker cluster stack. In essence, Glue is everything that \
is not the cluster messaging layer (Heartbeat), nor the cluster resource \
manager (Pacemaker), nor a Resource Agent."
HOMEPAGE = "www.linux-ha.org"

LICENSE = "GPLv2 & LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

DEPENDS = "libaio libxml2 libtool glib-2.0 bzip2 util-linux net-snmp \
           docbook-xsl-stylesheets-native docbook-xml-dtd4-native \
           libxslt-native asciidoc-native \
           openssl openipmi openhpi openldap libcap libtasn1 \
           libgpg-error curl gnutls zlib \
          "

PACKAGECONFIG[libnet] = "--enable-libnet,--disable-libnet,libnet"

SRC_URI = "http://hg.linux-ha.org/glue/archive/glue-${PV}.tar.bz2 \
           file://ribcl_py_in.patch \
           file://volatiles \
           file://cluster-glue-volatile.conf \
           file://cluster-glue-pkg-config.patch \
           file://cluster-glue-not-check-doc-output-with-xmllint.patch \
           file://make-xsltproc-use-catalog.patch \
          "

SRC_URI_append_libc-uclibc = " file://kill-stack-protector.patch"
SRC_URI[md5sum] = "ec620466d6f23affa3b074b72bca7870"
SRC_URI[sha256sum] = "feba102fa1e24b6be2005089ebe362b82d6567af60005cf371679b1b44ec503f"

S = "${WORKDIR}/Reusable-Cluster-Components-glue--glue-${PV}"

inherit autotools-brokensep pkgconfig useradd systemd

SYSTEMD_SERVICE_${PN} = "logd.service"
SYSTEMD_AUTO_ENABLE = "disable"

HA_USER = "hacluster"
HA_GROUP = "haclient"

#help2man is disabled when cross compiling
EXTRA_OECONF = "--with-daemon-user=${HA_USER} --with-daemon-group=${HA_GROUP} \
                --enable-fatal-warnings=no \
                --with-systemdsystemunitdir=${systemd_unitdir}/system \
                ac_cv_path_HELP2MAN= \
                ac_cv_path_SNMPCONFIG=${STAGING_BINDIR_CROSS}/net-snmp-config \
               "

# Allow to process DocBook documentations without requiring
# network accesses for the dtd and stylesheets
export SGML_CATALOG_FILES = "${STAGING_DATADIR_NATIVE}/xml/docbook/xsl-stylesheets/catalog.xml"

export STYLESHEET_PREFIX = "${STAGING_DATADIR_NATIVE}/xml/docbook/xsl-stylesheets"

#there is a bug in configure.ac, it is using net-snmp-config not $SNMPCONFIG
do_configure_prepend () {
	sed -i -e 's/SNMPLIB=`net-snmp-config --libs`/SNMPLIB=`$SNMPCONFIG --libs`/g' configure.ac
}

do_install_append() {
	install -d ${D}${sysconfdir}/default/volatiles
	install -m 0644 ${WORKDIR}/volatiles ${D}${sysconfdir}/default/volatiles/04_cluster-glue
	sed -i -e 's:^#!/bin/bash:#!/bin/sh:g' ${D}${libdir}/stonith/plugins/xen0-ha-dom0-stonith-helper
	sed -i -e 's/timeout=\$\[timeout-1]/timeout=$((timeout-1))/g' ${D}${libdir}/stonith/plugins/xen0-ha-dom0-stonith-helper
	sed -i -e 's:^#!/bin/bash:#!/bin/sh:g' ${D}${libdir}/stonith/plugins/external/xen0-ha

	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/tmpfiles.d/
		install -m 0644 ${WORKDIR}/cluster-glue-volatile.conf ${D}${sysconfdir}/tmpfiles.d/
	fi
}

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "--system ${HA_GROUP}"
USERADD_PARAM_${PN} = "--system --home ${localstatedir}/lib/heartbeat/cores/${HA_USER} -M -g ${HA_GROUP} \
                       -s ${sbindir}/nologin -c 'cluster user' ${HA_USER}"

PACKAGES += "\
	 ${PN}-plugin-compress \
	 ${PN}-plugin-compress-dbg \
	 ${PN}-plugin-compress-staticdev \
	 ${PN}-plugin-test \
	 ${PN}-plugin-test-dbg \
	 ${PN}-plugin-test-dev \
	 ${PN}-plugin-test-staticdev \
	 ${PN}-plugin-stonith2 \
	 ${PN}-plugin-stonith2-dbg \
	 ${PN}-plugin-stonith2-dev \
	 ${PN}-plugin-stonith2-staticdev \
	 ${PN}-plugin-stonith2-ribcl \
	 ${PN}-plugin-stonith-external \
	 ${PN}-plugin-raexec \
	 ${PN}-plugin-raexec-dbg \
	 ${PN}-plugin-raexec-dev \
	 ${PN}-plugin-raexec-staticdev \
	 ${PN}-plugin-interfacemgr \
	 ${PN}-plugin-interfacemgr-dbg \
	 ${PN}-plugin-interfacemgr-dev \
	 ${PN}-plugin-interfacemgr-staticdev \
	 ${PN}-lrmtest \
	 "

FILES_${PN} = "${sysconfdir} ${libdir}/lib*.so.* ${sbindir} ${datadir}/cluster-glue/*sh ${datadir}/cluster-glue/*pl\
	${libdir}/heartbeat/transient-test.sh \
	${libdir}/heartbeat/logtest \
	${libdir}/heartbeat/ipctransientserver \
	${libdir}/heartbeat/base64_md5_test \
	${libdir}/heartbeat/ipctest \
	${libdir}/heartbeat/ipctransientclient \
	${libdir}/heartbeat/ha_logd \
	${libdir}/heartbeat/lrmd \
	${localstatedir}/lib/heartbeat	\
	${localstatedir}/lib/heartbeat/cores	\
	${localstatedir}/lib/heartbeat/cores/root	\
	${localstatedir}/lib/heartbeat/cores/nobody	\
	${localstatedir}/lib/heartbeat/cores/${HA_USER}	\
	"

#without these plugins, lrmd will crash although can run
RDEPENDS_${PN} += "${PN}-plugin-interfacemgr ${PN}-plugin-raexec ${PN}-plugin-stonith2"

FILES_${PN}-dbg += "${libdir}/heartbeat/.debug/"

FILES_${PN}-plugin-compress = "${libdir}/heartbeat/plugins/compress/*.so"
FILES_${PN}-plugin-compress-staticdev = "${libdir}/heartbeat/plugins/compress/*.*a"
FILES_${PN}-plugin-compress-dbg = "${libdir}/heartbeat/plugins/compress/.debug"

FILES_${PN}-plugin-test = "${libdir}/heartbeat/plugins/test/test.so"
FILES_${PN}-plugin-test-staticdev = "${libdir}/heartbeat/plugins/test/test.*a"
FILES_${PN}-plugin-test-dbg = "${libdir}/heartbeat/plugins/test/.debug/"
FILES_${PN}-plugin-stonith2 = " \
	${libdir}/stonith/plugins/xen0-ha-dom0-stonith-helper \
	${libdir}/stonith/plugins/stonith2/*.so \
	"
FILES_${PN}-plugin-stonith2-ribcl = "${libdir}/stonith/plugins/stonith2/ribcl.py"
RDEPENDS_${PN}-plugin-stonith2-ribcl += "python"

FILES_${PN}-plugin-stonith2-dbg = "${libdir}/stonith/plugins/stonith2/.debug/"
FILES_${PN}-plugin-stonith2-staticdev = "${libdir}/stonith/plugins/stonith2/*.*a"

FILES_${PN}-plugin-stonith-external = "${libdir}/stonith/plugins/external/"
RDEPENDS_${PN}-plugin-stonith-external += "perl python"
FILES_${PN}-plugin-raexec = "${libdir}/heartbeat/plugins/RAExec/*.so"
FILES_${PN}-plugin-raexec-staticdev = "${libdir}/heartbeat/plugins/RAExec/*.*a"
FILES_${PN}-plugin-raexec-dbg = "${libdir}/heartbeat/plugins/RAExec/.debug/"

FILES_${PN}-plugin-interfacemgr = \
	"${libdir}/heartbeat/plugins/InterfaceMgr/generic.so"
FILES_${PN}-plugin-interfacemgr-staticdev = \
	"${libdir}/heartbeat/plugins/InterfaceMgr/generic.*a"
FILES_${PN}-plugin-interfacemgr-dbg = \
	"${libdir}/heartbeat/plugins/InterfaceMgr/.debug/"

FILES_${PN}-lrmtest = "${datadir}/cluster-glue/lrmtest/"
