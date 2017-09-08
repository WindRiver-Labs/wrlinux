#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "An open source implementation of the diameter protocol"
DESCRIPTION = \
"freeDiameter is an open source Diameter protocol implementation. It \
provides an extensible platform for deploying a Diameter network for \
your Authentication, Authorization and Accounting needs."

HOMEPAGE = "http://www.freediameter.net"

DEPENDS = "flex bison cmake-native libgcrypt gnutls libidn lksctp-tools"
RDEPENDS_${PN} = "glib-2.0 gnutls libidn"
RDEPENDS_${PN}-ptest = "cmake"

pkgname = "freeDiameter"

SRC_URI = "http://www.freediameter.net/hg/${pkgname}/archive/${PV}.tar.gz;downloadfilename=${pkgname}-${PV}.tar.gz \
           file://Replace-murmurhash-algorithm-with-Robert-Jenkin-s-ha.patch \
          "
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', \
           'file://install_test.patch \
            file://run-ptest \
            file://pass-ptest-env.patch', '', d)} \
            file://freediameter.service \
            file://freediameter.init \
           "

S = "${WORKDIR}/${pkgname}-${PV}"

PTEST_PATH = "${libdir}/${pkgname}/ptest"

inherit cmake update-rc.d ptest systemd

EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX:PATH=/usr \
        -DDEFAULT_CONF_PATH:PATH=${sysconfdir}/${pkgname} \
        -DBUILD_TEST_APP:BOOL=ON -DBUILD_DBG_MONITOR:BOOL=ON  \
        -DBUILD_TESTING:BOOL=ON \
        -DBUILD_APP_RADGW:BOOL=ON \
        -DBUILD_APP_REDIRECT:BOOL=ON \
        -DBUILD_TEST_ACCT:BOOL=ON \
        -DBUILD_TEST_NETEMUL:BOOL=ON -DBUILD_TEST_RT_ANY:BOOL=ON \
        -DINSTALL_LIBRARY_SUFFIX:PATH=${baselib} \
        -DINSTALL_EXTENSIONS_SUFFIX:PATH=${baselib}/${pkgname} \
        -DINSTALL_TEST_SUFFIX:PATH=${PTEST_PATH}-tests \
        -DCMAKE_SKIP_RPATH:BOOL=ON \
"
#INSTALL_LIBRARY_SUFFIX is relative to CMAKE_INSTALL_PREFIX
#specify it on cmd line will fix the SET bug in CMakeList.txt

#-DBUILD_APP_ACCT:BOOL=ON This needs POSTGRESQL support
#-DBUILD_APP_DIAMEAP:BOOL=ON  -DBUILD_APP_SIP:BOOL=ON -DBUILD_TEST_SIP:BOOL=ON
#These need MySQL support
#-DBUILD_DBG_INTERACTIVE:BOOL=ON This needs SWIG support
#-DALL_EXTENSIONS=ON will enable all

do_install_append() {

	#install the sample configuration file
	install -d -m 0755 ${D}${sysconfdir}/${pkgname}
	for i in ${S}/doc/*.conf.sample; do
		install -m 0644 $i ${D}${sysconfdir}/${pkgname}/
	done
	mv ${D}${sysconfdir}/${pkgname}/freediameter.conf.sample \
	  ${D}${sysconfdir}/${pkgname}/freeDiameter.conf.sample
	#install daemon init related files
	install -d -m 0755 ${D}${sysconfdir}/default
	install -d -m 0755 ${D}${sysconfdir}/init.d
	install -m 0644 ${S}/contrib/debian/freediameter-daemon.default \
	  ${D}${sysconfdir}/default/${BPN}
	install -m 0755 ${WORKDIR}/freediameter.init ${D}${sysconfdir}/init.d/${BPN}

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/freediameter.service ${D}${systemd_unitdir}/system/
	sed -i -e 's,@BINDIR@,${bindir},g' ${D}${systemd_unitdir}/system/*.service
}

do_install_ptest() {
	sed -i "s#\(EXTENSIONS_DIR=\).*\$#\1${libdir}/${pkgname}/#" ${D}${PTEST_PATH}/run-ptest
	mv ${D}${PTEST_PATH}-tests/* ${D}${PTEST_PATH}/
	rmdir ${D}${PTEST_PATH}-tests
	install -m 0644 ${B}/tests/CTestTestfile.cmake ${D}${PTEST_PATH}/
}

FILES_${PN}-dbg += "${libdir}/${pkgname}/.debug/* \
	           "

#include the extensions in main package
FILES_${PN} += "${libdir}/${pkgname}/* \
		${systemd_unitdir}/* \
		"

INITSCRIPT_NAME = "${BPN}"
INITSCRIPT_PARAMS = "start 30 . stop 70 0 1 2 3 4 5 6 ."
SYSTEMD_SERVICE_${PN} = "freediameter.service"
SYSTEMD_AUTO_ENABLE = "disable"
