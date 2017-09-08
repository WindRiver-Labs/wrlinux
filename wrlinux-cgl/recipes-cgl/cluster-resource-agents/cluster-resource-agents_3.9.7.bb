#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#
SUMMARY = "Open Source HA Reusable Cluster Resource Scripts"
DESCRIPTION = "A set of scripts to interface with several services to operate in a High \
               Availability environment for both Pacemaker and rgmanager service managers. \
               "
HOMEPAGE = "www.linux-ha.org"

LICENSE = "GPLv2 & LGPLv2.1 & GPLv3"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
		    file://COPYING.GPLv3;md5=d32239bcb673463ab874e80d47fae504 \
		   "

#libnet is an optional dependency, if no libnet available
#then send_arp.linux.c will be used when building
#docbook-xsl-native docbook-xml-dtd-4.4-native are doc build dependencies
DEPENDS = "cluster-glue glib-2.0 libnet xmlto-native \
           docbook-xsl-stylesheets-native docbook-xml-dtd4-native"

RDEPENDS_${PN} += "iproute2 iputils-arping e2fsprogs lvm2 ethtool util-linux procps perl"
#ip.sh requires ip ethtool arping ping ping6 rdisc: iproute2 iputils-arping ethtool
#fs.sh requires fsck fsck.ext2 fsck.ext3 fsck.ext4 fsck.xfs quotaon quotacheck e2fsprogs
#lvm.sh requires lvm: lvm2
#netfs.sh mount.nfs mount.nfs4 mount.cifs rpc.nfsd rpc.statd rpc.mountd
#mount, fuser grep sed awk (busybox) findfs(util-linux) pkill(procps)
#hostname(net-tools or busybox) ps(busybox or procps)
#sed(busybox or sed) gawk (gawk)

RDEPENDS_ocft = "bash"

SRC_URI = "https://github.com/ClusterLabs/resource-agents/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
           file://IPv6addr_meta_data.patch \
           file://volatile.99_resource-agents \
           file://fix-install-sh-not-found.patch \
           file://ldirectord.service \
           file://do-not-re-evaluate-OCF_ROOT_DIR-for-cross-compile.patch \
          "
SRC_URI_append_libc-uclibc = " file://kill-stack-protector.patch"

SRC_URI[md5sum] = "c59096b1bacc704e8a5a285f15729109"
SRC_URI[sha256sum] = "e5bd62658fbc236acb83b709f64b2cd9fae52aa4a420a44fed5eb667e928b152"

S = "${WORKDIR}/resource-agents-${PV}"

inherit autotools-brokensep systemd

SYSTEMD_PACKAGES = "ldirectord"
SYSTEMD_SERVICE_ldirectord = "ldirectord.service"
SYSTEMD_AUTO_ENABLE = "disable"

# ARM build fails on send_arp.linux.c with
#
# cc1: warnings being treated as errors
# send_arp.linux.c: In function 'send_pack':
# send_arp.linux.c:106: error: cast increases required alignment of target type
# send_arp.linux.c: In function 'recv_pack':
# send_arp.linux.c:207: error: cast increases required alignment of target type
#
# The code itself doesn't look that bad, so just disable -Werror
# EXTRA_OECONF_arm += "--disable-fatal-warnings"

#default ocf root dir in configure.ac
#can be changed with --with-ocf-root= when configure
OCF_ROOT_DIR = "/usr/lib/ocf"

PACKAGES =+ "ldirectord ldirectord-doc ocft"

#use local docbook
export SGML_CATALOG_FILES = "${STAGING_DATADIR_NATIVE}/xml/docbook/xsl-stylesheets/catalog.xml"
export STYLESHEET_PREFIX = "${STAGING_DATADIR_NATIVE}/xml/docbook/xsl-stylesheets"

do_configure_prepend () {
	#fix the doc build which will run IPv6addr(binary) to get meta_data
	#currently this is the only binary, others are just scripts
	#use IPv6addr.meta_data from IPv6addr_meta_data.patch,
	#which is from IPv6addr.c's meta_data_addr function
	sed -i -e '/metadata-IPv6addr.xml:/{N;s/OCF_ROOT=.*/cat IPv6addr.meta_data > $@/}' \
	  ${S}/doc/man/Makefile.am

	sed -i 's/redhat/windriver/' ${S}/Makefile.am
}

do_install_append() {
	rm -rf ${D}/var/run/

	install -d ${D}/${sysconfdir}/default/volatiles
	install -m 644 ${WORKDIR}/volatile.99_resource-agents ${D}/${sysconfdir}/default/volatiles/99_resource-agents

	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -m 0644 ${WORKDIR}/ldirectord.service ${D}${systemd_unitdir}/system/
		sed -i 's,@DATADIR@,${datadir},g' ${D}${systemd_unitdir}/system/ldirectord.service

		install -d ${D}${datadir}/resource-agents
		install -m 755 ${B}/ldirectord/init.d/ldirectord ${D}${datadir}/resource-agents/
	fi
}

FILES_ldirectord = "${sbindir}/ldirectord \
                    ${sysconfdir}/ha.d/resource.d/ldirectord \
                    ${sysconfdir}/init.d/ldirectord \
                    ${sysconfdir}/logrotate.d/ldirectord \
                    ${systemd_unitdir}/system/ldirectord.service \
                    ${datadir}/resource-agents/ldirectord \
                    ${OCF_ROOT_DIR}/resource.d/heartbeat/ldirectord \
                   "
FILES_ldirectord-doc = "${mandir}/man8/ldirectord.8*"

# Missing:
# Authen::Radius
# Net::LDAP
# Net::IMAP::Simple::SSL
# Net::IMAP::Simple
#RDEPENDS_ldirectord += " \
#	libdbi-perl \
#	libmailtools-perl \
#	libnet-dns-perl \
#	libsocket6-perl \
#	libwww-perl \
#	"
RDEPENDS_ldirectord += " perl \
	perl-module-socket \
	perl-module-sys-hostname \
	perl-module-sys-syslog \
	perl-module-strict \
	perl-module-net-ftp \
	perl-module-net-smtp \
	perl-module-vars \
	perl-module-posix \
	perl-module-pod-usage \
	perl-module-getopt-long \
	"

FILES_${PN} += " \
	${libdir}/heartbeat/findif \
	${libdir}/heartbeat/ocf-returncodes \
	${libdir}/heartbeat/ocf-shellfuncs \
	${libdir}/heartbeat/send_arp \
	${libdir}/heartbeat/send_ua \
	${libdir}/heartbeat/sfex_daemon \
	${libdir}/heartbeat/tickle_tcp \
	${datadir}/resource-agents/ra-api-1.dtd \
	${datadir}/cluster	\
	${OCF_ROOT_DIR}/resource.d/ \
	${OCF_ROOT_DIR}/lib/heartbeat/* \
	"

FILES_ocft += " \
	${datadir}/resource-agents/ocft \
	${sbindir}/ocft \
	"

FILES_${PN}-dbg += " \
	${libdir}/${BPN}/heartbeat/.debug/ \
	${OCF_ROOT_DIR}/resource.d/heartbeat/.debug/ \
	"
