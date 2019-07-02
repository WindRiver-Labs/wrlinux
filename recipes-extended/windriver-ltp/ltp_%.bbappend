#
# Copyright (C) 2014 Wind River Systems, Inc.
#

SRC_URI += " file://README \
             file://0001-Add-wr-runltp-into-wrLinux_ltp.patch \
             file://0002-Add-LTP-case-known-failure-reason-into-wrLinux_ltp.patch \
             file://0003-Add-LTP-skipped-case-list-into-wrLinux_ltp.patch \
             file://0004-Add-wr-ltp-diff-into-wrLinux_ltp.patch \
             file://0005-Add-wr-runposix-into-wrLinux_posix.patch \
             file://0006-Add-POSIX-test-known-failure-reason-into-wrLinux_pos.patch \
             file://0007-Add-POSIX-skipped-case-list-into-wrLinux_posix.patch \
             file://0008-Add-wr-runposix.install-into-wrLinux_posix.patch \
             file://0011-Change-the-POSIX-install-folder-to-opt-open_posix_testsuite.patch \
             file://0012-tracing_enabled-remove-this-test.patch \
             file://0013-Fix-POSIX-mmap-5-1-failure-in-cgl-platform.patch \
             file://0014-Add-testrun-plan-for-realtime-tests.patch \
             file://0016-Fix-invalid-argument-error-for-POSIX-test-case-pi_test.patch \
             file://0017-Change-some-auto-detecting-options-to-configurable-o.patch \
             file://0018-posix-skip-the-test-pthread_barrier_destroy_2-1.patch \
             file://0019-wrLinux_ltp-Remove-admin_tools.patch \
            "

do_compile(){
	oe_runmake
	cd ${S}/testcases/open_posix_testsuite/
	oe_runmake generate-makefiles
	oe_runmake conformance-all
    oe_runmake functional-all
	oe_runmake tools-all
}

do_install(){
	install -d ${D}/opt/ltp
	oe_runmake DESTDIR=${D} SKIP_IDCHECK=1 install

	# fixup not deploy STPfailure_report.pl to avoid confusing about it fails to run
	# as lacks dependency on some perl moudle such as LWP::Simple
	# And STPfailure_report.pl previously works as a tool for analyzing failures from LTP
	# runs on the OSDL's Scaleable Test Platform (STP) and it mainly accesses
	# http://khack.osdl.org to retrieve ltp test results run on
	# OSDL's Scaleable Test Platform, but now http://khack.osdl.org unaccessible
	rm -rf ${D}/opt/ltp/bin/STPfailure_report.pl

	# Install Posix Test Suite
	install -d ${D}/opt/open_posix_testsuite
	export prefix="/opt/open_posix_testsuite/"
	export exec_prefix="/opt/open_posix_testsuite/"
	cd ${S}/testcases/open_posix_testsuite/
	oe_runmake DESTDIR=${D} SKIP_IDCHECK=1 install

	# Install wrLinux_posix
	cp ${WORKDIR}/README ${S}/testcases/open_posix_testsuite/wrLinux_posix/
	cp -r ${S}/testcases/open_posix_testsuite/wrLinux_posix ${D}/opt/open_posix_testsuite/
	install -m 755 ${S}/testcases/open_posix_testsuite/wrLinux_posix/wr-runposix ${D}/opt/open_posix_testsuite/wrLinux_posix/
	install -m 755 ${S}/testcases/open_posix_testsuite/wrLinux_posix/wr-runposix.install ${D}/opt/open_posix_testsuite/wrLinux_posix/
	${D}/opt/open_posix_testsuite/wrLinux_posix/wr-runposix.install

    # Install wrLinux_ltp
	cp ${WORKDIR}/README ${S}/wrLinux_ltp/
	cp -r ${S}/wrLinux_ltp ${D}/opt/ltp/
	install -m 755 ${S}/wrLinux_ltp/wr-runltp ${D}/opt/ltp/wrLinux_ltp/
}

PACKAGECONFIG ??= ""
PACKAGECONFIG[libcap] = "--enable-libcap,--disable-libcap,libcap,"
PACKAGECONFIG[crypto] = "--enable-crypto,--disable-crypto,openssl,"
PACKAGECONFIG[selinux] = "--enable-selinux,--disable-selinux,libselinux,"
PACKAGECONFIG[acl] = "--enable-acl,--disable-acl,acl,"
PACKAGES += "open-posix-testsuite-dbg open-posix-testsuite"

FILES_open-posix-testsuite += "/opt/open_posix_testsuite/"

FILES_open-posix-testsuite-dbg += "\
    /opt/open_posix_testsuite/*/.debug \
    /opt/open_posix_testsuite/*/*/.debug \
    /opt/open_posix_testsuite/*/*/*/.debug \
    /opt/open_posix_testsuite/*/*/*/*/.debug \
    "

### These may be in .bb file after package is upgraded
###
FILES_${PN}-dbg += "\
    /opt/ltp/testcases/*/.debug \
    /opt/ltp/testcases/*/*/.debug \
    /opt/ltp/testcases/*/*/*/.debug \
    "
INSANE_SKIP_${PN} += "already-stripped"
###

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_open-posix-testsuite += "eglibc-utils"
RDEPENDS_${PN} += "open-posix-testsuite expect python python-textutils binutils binutils-symlinks gzip"

