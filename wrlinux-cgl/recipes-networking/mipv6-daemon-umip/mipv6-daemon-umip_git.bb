#
# Copyright (C) 2015 Wind River Systems, Inc.
#
DESCRIPTION = "The mobile IPv6 daemon allows nodes to remain \
reachable while moving around in the IPv6 Internet."
SUMMARY = "Mobile IPv6 (MIPv6) Daemon"
LICENSE = "GPLv2"
DEPENDS = "virtual/kernel"
DEPENDS += "openssl flex-native"
RRECOMMENDS_${PN} = "kernel-module-mip6 kernel-module-ipv6"

LIC_FILES_CHKSUM = "file://COPYING;md5=073dc31ccb2ebed70db54f1e8aeb4c33"
SRCREV = "cbd441c5db719db554ff2b4fcb02fef88ae2f791"
PE = "1"
PV = "git${SRCPV}"

S = "${WORKDIR}/git"

SRC_URI = "git://git.umip.org/umip.git;protocol=git \
	file://pmgr.c \
	file://pmgr.h \
	file://scan.c \
	file://add-dependency-to-support-parallel-compilation.patch \
	file://mip6d \
	file://mip6d.service \
"

inherit autotools-brokensep systemd update-rc.d

INITSCRIPT_NAME = "mip6d"
INITSCRIPT_PARAMS = "start 64 . stop 36 0 1 2 3 4 5 6 ."

SYSTEMD_SERVICE_${PN} = "mip6d.service"
SYSTEMD_AUTO_ENABLE = "disable"

do_configure(){
	autoreconf -if
	CPPFLAGS="${CPPFLAGS} -isystem ${STAGING_INCDIR}" \
	oe_runconf ac_cv_have_decl_IPV6_RTHDR_TYPE_2=yes enable_vt=yes
}

do_compile() {
	# Because these files are just copied, we want to set permissions.
	# And, yes, they can get overwritten during compilation!
	install -m 0644 ${WORKDIR}/*.[ch] ${S}/src/

        oe_runmake  CC="${CC}" \
        	AR="${AR}" \
		LDFLAGS="${LDFLAGS} -lpthread -lcrypt -lrt" \
		LEX=flex
}

do_install() {
        oe_runmake sbindir="${D}${sbindir}" initdir="${D}${sysconfdir}/init.d" mandir="${D}${mandir}" docdir="${D}${docdir}/mobile-ip6" NETWORK_MIP6_CONF="${D}${sysconfdir}" install

	install -d ${D}${sysconfdir}/init.d
	install -p -m 0755 ${WORKDIR}/mip6d ${D}${sysconfdir}/init.d/

	#install systemd service file
	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/mip6d.service ${D}${systemd_unitdir}/system
	sed -i -e 's,@SYSCONFDIR@,${sysconfdir},g' \
	    -e 's,@SBINDIR@,${sbindir},g' \
	    ${D}${systemd_unitdir}/system/mip6d.service
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
