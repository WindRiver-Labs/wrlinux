#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "ntop is network top"
DESCRIPTION = "ntop is a network traffic probe that shows the network usage, \
similar to what the popular top Unix command does."

SECTION = "console/network"

LICENSE = "GPLv2+ & GPLv3 & OpenSSL"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://LICENSE-OpenSSL.txt;md5=a409f902e447ddd889cffa0c70e7c7c2 \
"

SRC_URI = "${SOURCEFORGE_MIRROR}/ntop/ntop-${PV}.tar.gz \
	file://ntop_configure_in.patch \
	file://ntop_init.patch \
	file://ntop_webInterface.patch \
	file://ntop_configure_in_net_snmp_config_exist.patch \
	file://ntop.service \
	file://use-static-inline.patch \
	file://support-arm64.patch \
"

inherit autotools-brokensep update-rc.d useradd pythonnative pkgconfig systemd

DEPENDS = "geoip rrdtool python zlib libpcap gdbm"

PACKAGECONFIG ??= "openssl snmp plugins"
PACKAGECONFIG[openssl] = "--with-ssl,--without-ssl,openssl,openssl"
PACKAGECONFIG[snmp] = \
"--enable-snmp=yes NETSNMP=${STAGING_BINDIR_CROSS}/net-snmp-config, \
--disable-snmp,net-snmp,"
PACKAGECONFIG[plugins] = "--enable-plugins=yes,--disable-plugins,,"

FILES_${PN}_append = "${libdir}/ntop/plugins ${libdir}/libntop-*.so \
	${libdir}/libntopreport-*.so ${libdir}/lib*-${PV}.so"
FILES_${PN}-dev = "${includedir} ${libdir}/libntop.so \
	${libdir}/libntopreport.so \
	${libdir}/libnetflowPlugin.so ${libdir}/libsflowPlugin.so \
	${libdir}/librrdPlugin.so \
	${libdir}/*.a ${libdir}/libntopreport.a ${libdir}/*.la"
FILES_${PN}-dbg += "${libdir}/ntop/plugins/.debug"

#prefer specify pcap-config but it has bugs for now
#--with-pcap-config=${STAGING_BINDIR_CROSS}/pcap-config
EXTRA_OECONF += "ac_cv_file_aclocal_m4=yes ac_cv_file_depcomp=no \
"

do_configure () {
	cp ${STAGING_DATADIR_NATIVE}/aclocal/libtool.m4 libtool.m4.in
	cat acinclude.m4.in acinclude.m4.ntop libtool.m4.in > acinclude.m4
	cp 3rd_party/* ./

	#config nDPI  too
	cd nDPI
	./configure ${CONFIGUREOPTS} --with-pic
	cd ..

	sed -i -e 's:^CFG_DBFILE_DIR=$localstatedir/ntop:CFG_DBFILE_DIR=$localstatedir/lib/ntop:' ${S}/configure.in

	#fix the CFLAGS, CPPFLAGS, LDFLAGS, remove the host include
	sed -i \
	  -e 's:\(^CFLAGS="\$.*\) -I/usr/local/include -I/opt/local/include":\1":' \
	  -e 's:\(^CPPFLAGS="\$.*\) -I/usr/local/include -I/opt/local/include":\1":' \
	  -e 's:\(^LDFLAGS="\$.*\) -L/usr/local/lib -L/opt/local/lib":\1":' \
	  ${S}/configure.in

	#replace the DISTRO RELEASE in configure.in which are host's
	#with our release, although those doesn't affect functionality
	sed -i -e \
	  '/DEFINEOS="LINUX"/{N;s/DISTRO=.*/DISTRO="${DISTRO}"/;N;s/RELEASE=.*/RELEASE="${DISTRO_VERSION}"/;}' \
	  ${S}/configure.in

	#osName is from uname -r in original configure.in which
	#should be ${LINUX_VERSION}-WR${DISTRO_VERSION}_${LINUX_KERNEL_TYPE}
	#which will show in ntop's "show configuration"
	sed -i -e \
	  's:^osName=.*:osName=${CSL_VER_KERNEL}-WR${DISTRO_VERSION}_${LINUX_KERNEL_TYPE}:' \
	  ${S}/configure.in

	#rename configureextra to configureextra_rename to avoid
	#configure.in to guess host OS and pull in more configure, non needed
	#which will cause some cross-compiling failure on specific host
	#e.g. SUSE(SLED...)

	test ! -f configureextra || mv -f configureextra configureextra_rename

	#make sure configure finds python includdirs/libs with these envs
	export BUILD_SYS=${BUILD_SYS} HOST_SYS=${HOST_SYS} \
	       STAGING_INCDIR=${STAGING_INCDIR} \
	       STAGING_LIBDIR=${STAGING_LIBDIR}

	autotools_do_configure
}

do_compile_prepend () {
	cd nDPI
	oe_runmake
	cd ..
}

do_install_append () {
	#remove the empty dirs
	rm -rf ${D}${libdir}/plugins
	#no where use CFG_RUN_DIR
	rm -rf ${D}${localstatedir}/ntop

	install -d -m 0755 ${D}${sysconfdir}/init.d
	install -m 0755 ${S}/packages/RedHat/ntop.init \
		${D}${sysconfdir}/init.d/ntop
	install -m 0644 ${S}/packages/RedHat/ntop.conf.sample \
		${D}${sysconfdir}/ntop.conf

	#change ntop dir in ntop.conf
	#don't use the -P as the ntop.init didn't support it
	sed -i -e "s:^--db-file-path /usr/share/ntop:--db-file-path /var/lib/ntop:" \
	       -e "s:^#? -P /var/ntop:#? -P /var/lib/ntop:" \
		${D}${sysconfdir}/ntop.conf

	# For systemd
	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -d ${D}${libexecdir}
		install -m 0755 ${S}/packages/RedHat/ntop.init ${D}${libexecdir}/ntop-helper
		install -d ${D}${systemd_unitdir}/system
		install -m 0644 ${WORKDIR}/ntop.service ${D}${systemd_unitdir}/system
		sed -i -e 's,@LIBEXECDIR@,${libexecdir},g' \
		       -e 's,@SYSCONFDIR@,${sysconfdir},g' \
		       ${D}${systemd_unitdir}/system/ntop.service
	fi

	# Fix host-user-contaminated issue
	chown -R root:root ${D}
}

INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME = "${PN}"
INITSCRIPT_PARAMS = "start 93 . stop 7 0 1 2 3 4 5 6 ."

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "-M -g ntop -r -d ${localstatedir}/lib/${PN} \
-s /usr/sbin/nologin -c 'ntop' ntop"
GROUPADD_PARAM_${PN} = "-r ntop"

SYSTEMD_SERVICE_${PN} = "ntop.service"
SYSTEMD_AUTO_ENABLE = "disable"

pkg_postinst_${PN} () {
#!/bin/sh -e

	chown -R ntop:ntop ${localstatedir}/lib/${PN}
}

