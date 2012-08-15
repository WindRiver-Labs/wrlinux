require recipes-devtools/python/python.inc

DEPENDS = "db-nativesdk gdbm-nativesdk openssl-nativesdk readline-nativesdk sqlite3-nativesdk zlib-nativesdk"
PR = "${INC_PR}.6"

FILESEXTRAPATHS_prepend := "${COREBASE}/meta/recipes-devtools/python/python-native:${COREBASE}/meta/recipes-devtools/python/python:"

SRC_URI += "file://04-default-is-optimized.patch \
           file://05-enable-ctypes-cross-build.patch \
           file://06-ctypes-libffi-fix-configure.patch \
           file://10-distutils-fix-swig-parameter.patch \
           file://11-distutils-never-modify-shebang-line.patch \
           file://12-distutils-prefix-is-inside-staging-area.patch \
           file://debug.patch \
           file://unixccompiler.patch \
           file://nohostlibs.patch \
           file://multilib.patch \
           file://add-md5module-support.patch \
           file://sys_platform_is_now_always_linux2.patch \
           "
S = "${WORKDIR}/Python-${PV}"

inherit nativesdk

RPROVIDES += "python-distutils-nativesdk python-compression-nativesdk python-textutils-nativesdk python-core-nativesdk"

EXTRA_OEMAKE = '\
  BUILD_SYS="" \
  HOST_SYS="" \
  LIBC="" \
  STAGING_LIBDIR=${STAGING_LIBDIR_NATIVE} \
  STAGING_INCDIR=${STAGING_INCDIR_NATIVE} \
'

do_configure_prepend() {
	autoreconf --verbose --install --force --exclude=autopoint Modules/_ctypes/libffi || bbnote "_ctypes failed to autoreconf"
}

do_install() {
	oe_runmake 'DESTDIR=${D}' install
	install -d ${D}${bindir}

	# Make sure we use /usr/bin/env python
	for PYTHSCRIPT in `grep -rIl ${bindir}/python ${D}${bindir}`; do
		sed -i -e '1s|^#!.*|#!/usr/bin/env python|' $PYTHSCRIPT
	done

	ln -sf python ${D}${bindir}/python2

}

require recipes-devtools/python/python-${PYTHON_MAJMIN}-manifest.inc

# package libpython2
PACKAGES =+ "libpython2-nativesdk"
FILES_libpython2-nativesdk = "${libdir}/libpython*.so.*"

# catch debug extensions (isn't that already in python-core-dbg?)
FILES_${PN}-dbg += "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/.debug"

# catch all the rest (unsorted)
PACKAGES += "${PN}-misc"
FILES_${PN}-misc = "${libdir}/python${PYTHON_MAJMIN}"

# catch manpage
PACKAGES += "${PN}-man"
FILES_${PN}-man = "${datadir}/man"

