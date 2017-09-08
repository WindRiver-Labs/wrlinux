#
# Copyright (C) 2012, 2015 Wind River Systems, Inc.
#
SUMMARY		= "An IP address pool manager"
DESCRIPTION	= "IpPool is implemented as a separate server daemon \
to allow any application to use its address pools. This makes it possible \
to define address pools that are shared by PPP, L2TP, PPTP etc. It may be \
useful in some VPN server setups. IpPool comes with a command line \
management application, ippoolconfig to manage and query address pool \
status. A pppd plugin is supplied which allows pppd to request IP \
addresses from ippoold. \
"

HOMEPAGE	= "http://www.openl2tp.org/"
SECTION 	= "console/network"
LICENSE 	= "GPLv2+"
SRC_URI		= \
"https://sourceforge.net/projects/openl2tp/files/${BPN}/${PV}/${BPN}-${PV}.tar.gz \
 file://ippool_usl_timer.patch \
 file://ippool_parallel_make_and_pic.patch \
 file://ippool_init.d.patch \
 file://always_syslog.patch \
 file://makefile-add-ldflags.patch \
 file://runtest.sh \
 file://ippool.service \
"

LIC_FILES_CHKSUM = "file://LICENSE;md5=4c59283b82fc2b166455e0fc23c71c6f"
SRC_URI[md5sum] = "e2401e65db26a3764585b97212888fae"
SRC_URI[sha256sum] = "d3eab7d6cad5da8ccc9d1e31d5303e27a39622c07bdb8fa3618eea314412075b"

inherit systemd

DEPENDS += "readline ppp ncurses gzip-native"
#/etc/init.d/ippoold uses /base_libdir/lsb/init-functions
RDEPENDS_${PN} += "lsb rpcbind"

#overwrite SYS_LIBDIR=${libdir}
#overwrite EXTRA_OEMAKE to avoid "-e MAKEFLAGS" as it will 
#override the CFLAGS... in application
#INSTALL will be install
EXTRA_OEMAKE = "CC='${CC}' AS='${AS}' LD='${LD}' AR='${AR}' NM='${NM}' \
	STRIP='${STRIP}' "
EXTRA_OEMAKE += "PPPD_VERSION=${PPPD_VERSION} SYS_LIBDIR=${libdir}"

#enable self tests
EXTRA_OEMAKE += "IPPOOL_TEST=y"

#use these for debug features, default all not set
#EXTRA_OEMAKE += "USE_DMALLOC=y IPPOOL_DEBUG=y"
#DEPENDS += "dmalloc", no dmalloc package

do_compile_prepend() {
	#fix the CFLAGS= in main Makefile, to have the extra CFLAGS in env
	sed -i -e "s/^CFLAGS=/CFLAGS+=/" \
		${S}/Makefile 

	sed -i -e "s:-I/usr/include/pppd:-I=/usr/include/pppd:" \
		${S}/pppd/Makefile

	#ignore the OPT_CFLAGS?= in Makefile, 
	#it should be in CFLAGS from env
	export OPT_CFLAGS=
}

# Construct and install ippool.service
#   For sysvinit we supply an init file, but don't invoke it,
#   so for systemd we disable the service.
#
SYSTEMD_SERVICE_${PN} = "ippool.service"
SYSTEMD_AUTO_ENABLE = "disable"

# supply lcl_install_systemd_service() function
#
lcl_install_systemd_service () {
	install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/$1 ${D}${systemd_unitdir}/system
        sed -i -e 's,@STATEDIR@,${localstatedir},g' \
               -e 's,@SYSCONFDIR@,${sysconfdir},g' \
               -e 's,@SBINDIR@,${sbindir},g' \
               -e 's,@BINDIR@,${bindir},g' \
               -e 's,@BASE_SBINDIR@,${base_sbindir},g' \
               -e 's,@BASE_BINDIR@,${base_bindir},g' \
               ${D}${systemd_unitdir}/system/$1

}

do_install() {
	oe_runmake DESTDIR=${D} install
	
	# support both sysvinit and systemd
	install -d -m 0755 ${D}${sysconfdir}/init.d
	install -m 0755 ${S}/debian/init.d ${D}${sysconfdir}/init.d/ippoold
	if [ "${base_libdir}" != "lib" ]; then
	  sed -i -e "s:^\. /lib/lsb/init-functions:\. ${base_libdir}/lsb/init-functions:" \
		${D}${sysconfdir}/init.d/ippoold
	fi
	lcl_install_systemd_service ippool.service

	#install self test
	install -d ${D}/opt/${BPN}
	install ${S}/test/all.tcl  ${S}/test/ippool.test  \
		${S}/test/test_procs.tcl ${D}/opt/${BPN}
	install ${WORKDIR}/runtest.sh ${D}/opt/${BPN}
	#fix the ../ippoolconfig in test_procs.tcl
	sed -i -e "s:../ippoolconfig:ippoolconfig:" \
		${D}/opt/${BPN}/test_procs.tcl
}

PACKAGES =+ "${PN}-test"

FILES_${PN} += "${libdir}/pppd/${PPPD_VERSION}/ippool.so"
FILES_${PN}-dbg += "${libdir}/pppd/${PPPD_VERSION}/.debug/ippool.so"
FILES_${PN}-test = "/opt/${BPN}"

#needs tcl to run tests
RDEPENDS_${PN}-test += "tcl ${BPN}"

PPPD_VERSION="${@get_ppp_version(d)}"

def get_ppp_version(d):
    import re

    pppd_plugin = d.expand('${STAGING_LIBDIR}/pppd')
    if not os.path.isdir(pppd_plugin):
        return None

    bb.debug(1, "pppd plugin dir %s" % pppd_plugin)
    r = re.compile("\d*\.\d*\.\d*") 
    for f in os.listdir(pppd_plugin):
        if os.path.isdir(os.path.join(pppd_plugin, f)):
           ma = r.match(f)
           if ma:
               bb.debug(1, "pppd version dir %s" % f)
               return f
           else:
               bb.debug(1, "under pppd plugin dir %s" % f)

    return None
