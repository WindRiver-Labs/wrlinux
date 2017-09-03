#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "Cross Memory Attach test case (cma)"
DESCRIPTION = "Userspace test code that tests cma."
HOMEPAGE = "http://ozlabs.org/~cyeoh/cma/process_vm_readv.txt"

LICENSE = "PD"
LIC_FILES_CHKSUM = "file://README;md5=1061e8d11162cb10ea4b903ac393f078"
DEPENDS = ""
PV = "0.0.1"
SRC_URI = " http://ozlabs.org/~cyeoh/cma/cma-test-20110718.tgz \
file://0001-Fixed-unsafe-compare-and-readme.patch \
file://0001-cma-test-respect-CC-and-CFLAGS-if-set-in-environment.patch \
file://0001-Add-LDFLAGS-to-pass-external-ld-flags.patch \
"
SRC_URI[md5sum] = "cd447413534b6d0ef82f772c4f125af0"
SRC_URI[sha256sum] = "09512c74be88479b5adddbd765eca28a1b59203ea4a4f6937c9c352b311c1d84"
S = "${WORKDIR}/cma-test"

do_install() {
	install -d 0755 ${D}${bindir}
	install -m 0755 ${S}/setup_process_vm_readv_simple ${D}${bindir}
	install -m 0755 ${S}/setup_process_vm_readv_iovec ${D}${bindir}
	install -m 0755 ${S}/setup_process_vm_writev ${D}${bindir}
	install -m 0755 ${S}/t_process_vm_readv_iovec ${D}${bindir}
	install -m 0755 ${S}/t_process_vm_readv_simple ${D}${bindir}
	install -m 0755 ${S}/t_process_vm_writev ${D}${bindir}
}

COMPATIBLE_HOST = '(i.86.*|powerpc.*)-linux'
