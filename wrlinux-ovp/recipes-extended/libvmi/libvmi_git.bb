DESCRIPTION = "An introspection library, written in C, focused on reading \
               and writing memory from virtual machines (VM's)."
HOMEPAGE = "https://github.com/bdpayne/libvmi"
LICENSE = "LGPLv3"
LIC_FILES_CHKSUM = "file://COPYING.LESSER;md5=e6a600fd5e1d9cbde2d983680233ad02"
SECTION = "console/tools"
PV = "0.10.1"

DEPENDS = "libvirt libcheck bison fuse"

SRC_URI = "git://github.com/bdpayne/libvmi.git \
	   file://example_conf.patch \
	   file://Adds-argument-checking-to-examples.patch \
	  "

SRCREV = "ab0638de5186938b50cf1dbc4ae3ac244b24e6de"

S = "${WORKDIR}/git"

inherit autotools-brokensep pkgconfig

# Noramlly dynamic libs would be of the form libXX.so.1.0.0 in which case
# bitbake should be able to properly populate the -dev package and the main
# packages. Since libvmi uses the form libXX.1.0.0.so it breaks this automatic
# packaging so we need to be more explicit about what goes where.
FILES_${PN} += "${libdir}/libvmi-0.9.so"
FILES_${PN}-dev = "${includedir} ${libdir}/${BPN}.so ${libdir}/*.la \
                ${libdir}/*.o ${libdir}/pkgconfig ${datadir}/pkgconfig \
                ${datadir}/aclocal ${base_libdir}/*.o \
                ${libdir}/${BPN}/*.la ${base_libdir}/*.la"

# No xen!
#
PACKAGECONFIG ??= ""

# enable, disable, depends, rdepends
#
PACKAGECONFIG[xen] = "--enable-xen,--disable-xen,xen,"

# We include a sample conf file to which we have added
# a WindRiver-HVM domain
#
do_install_append () {
	mkdir ${D}${sysconfdir}
	cp etc/*.conf ${D}${sysconfdir}
}

# Construction of grammar.h is not parallel safe.
#
PARALLEL_MAKE = "-j1"
