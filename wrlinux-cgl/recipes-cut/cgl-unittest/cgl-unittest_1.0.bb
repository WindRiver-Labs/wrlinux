#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "cgl-unittest"
DESCRIPTION = "cgl-unittest"
SECTION = "apps"
LICENSE = "windriver"
LIC_FILES_CHKSUM = "file://license;md5=8cc536f28ecdfef562344c9fe2222252"

RDEPENDS_${PN} = "ntp ntp-utils ntp-tickadj ltp \
                  e2fsprogs e2fsprogs-resize2fs \
                  open-posix-testsuite \
"

SRC_URI = "\
	file://files/license \
	file://files/src/vul.c \
	file://files/src/get_memory.c \
	file://files/src/file_test.c \
	file://files/src/process.c \
	file://files/src/Makefile \
	file://files/rb-futex/nptl/tst-robust2.c \
	file://files/rb-futex/nptl/tst-robustpi5.c \
	file://files/rb-futex/nptl/tst-robust1.c \
	file://files/rb-futex/nptl/tst-robustpi6.c \
	file://files/rb-futex/nptl/tst-robustpi7.c \
	file://files/rb-futex/nptl/tst-robust3.c \
	file://files/rb-futex/nptl/tst-robust6.c \
	file://files/rb-futex/nptl/tst-robustpi4.c \
	file://files/rb-futex/nptl/Makefile \
	file://files/rb-futex/nptl/tst-robustpi8.c \
	file://files/rb-futex/nptl/tst-robust8.c \
	file://files/rb-futex/nptl/tst-robustpi3.c \
	file://files/rb-futex/nptl/tst-robust5.c \
	file://files/rb-futex/nptl/tst-robust7.c \
	file://files/rb-futex/nptl/tst-tpp.h \
	file://files/rb-futex/nptl/tst-robustpi2.c \
	file://files/rb-futex/nptl/tst-robust4.c \
	file://files/rb-futex/nptl/tst-robustpi1.c \
	file://files/rb-futex/Makefile \
	file://files/rb-futex/test-skeleton.c \
	file://files/rb-futex/Kernel_Uprev_Rb-pi-futex \
	file://files/rb-futex/tst-robust-run.sh \
	file://files/rb-futex/runtest.sh \
	file://files/README \
	file://files/resource/ssl.ca-0.1.tar.gz;unpack=no \
	file://files/resource/pktgen_eth_test.sh \
	file://files/resource/pci.ids \
	file://files/resource/corosync.conf.example \
	file://files/resource/crash_input \
	file://files/resource/avl.28.2.img \
	file://files/resource/avl.28.2.img_info \
	file://files/resource/openssl.cnf-test \
	file://files/resource/lsb-test-pam-2.0-2.src.rpm;unpack=no \
	file://files/env/runtime_env \
	file://files/Makefile \
	file://files/function.sh \
	file://files/testcase/smm.3.1 \
	file://files/testcase/smm.3.2 \
	file://files/testcase/sec.1.5 \
	file://files/testcase/std.3.1 \
	file://files/testcase/std.5.1 \
	file://files/testcase/std.4.1 \
	file://files/testcase/smm.7.7 \
	file://files/testcase/smm.7.6 \
	file://files/testcase/smm.8.1 \
	file://files/testcase/smm.8.2 \
	file://files/testcase/std.10.0 \
	file://files/testcase/std.17.1 \
	file://files/testcase/std.17.2 \
	file://files/testcase/std.17.3 \
	file://files/testcase/std.26.1 \
	file://files/testcase/std.26.2 \
	file://files/testcase/avl.21.1 \
	file://files/testcase/cdiag.2.4 \
	file://files/testcase/cdiag.2.2 \
	file://files/testcase/std.8.8 \
	file://files/testcase/smm.7.3 \
	file://files/testcase/avl.5.3 \
	file://files/testcase/sec.4.6 \
	file://files/testcase/avl.4.1 \
	file://files/testcase/spm.1.0 \
	file://files/testcase/sec.1.1 \
	file://files/testcase/prf.14.0 \
	file://files/testcase/sec.3.4 \
	file://files/testcase/sec.3.5 \
	file://files/testcase/smm.9.0 \
	file://files/testcase/avl.7.1 \
	file://files/testcase/sec.3.3 \
	file://files/testcase/prf.5.0 \
	file://files/testcase/prf.6.0 \
	file://files/testcase/prf.7.0 \
	file://files/testcase/sec.4.1 \
	file://files/testcase/sec.4.2 \
	file://files/testcase/sec.4.3 \
	file://files/testcase/sec.5.1 \
	file://files/testcase/smm.7.5 \
	file://files/testcase/sec.7.1 \
	file://files/testcase/spm.2.1 \
	file://files/testcase/prf.1.7 \
	file://files/testcase/prf.1.4 \
	file://files/testcase/sec.2.1 \
	file://files/testcase/prf.2.3 \
	file://files/testcase/avl.24.0 \
	file://files/testcase/sec.2.2 \
	file://files/testcase/std.16.0 \
	file://files/testcase/prf.4.2 \
	file://files/testcase/avl.26.0 \
	file://files/testcase/spm.3.0 \
	file://files/testcase/prf.1.6 \
	file://files/testcase/csm.4.0 \
	file://files/testcase/csm.1.0 \
	file://files/testcase/sec.3.1 \
	file://files/testcase/sec.3.2 \
	file://files/testcase/std.9.0 \
	file://files/testcase/cdiag.2.3 \
	file://files/testcase/avl.22.0 \
	file://files/testcase/sec.1.2 \
	file://files/testcase/smm.4.0 \
	file://files/testcase/sec.4.4 \
	file://files/testcase/smm.7.4 \
	file://files/testcase/avl.6.0 \
	file://files/testcase/avl.23.0 \
	file://files/testcase/avl.25.0 \
	file://files/testcase/smm.7.1 \
	file://files/testcase/prf.2.2 \
	file://files/testcase/avl.21.0 \
	file://files/testcase/prf.2.1 \
	file://files/testcase/sec.1.4 \
	file://files/testcase/smm.12.0 \
	file://files/testcase/smm.13.0 \
	file://files/testcase/smm.17 \
	file://files/testcase/smm.18 \
	file://files/testcase/sec.4.5 \
	file://files/testcase/smm.7.2 \
	file://files/testcase/avl.28.1 \
	file://files/testcase/avl.28.2 \
	file://files/testcase/avl.28.3 \
	file://files/testcase/sec.11.1 \
	file://files/testcase/sec.7.2 \
	file://files/testcase/sec.7.3 \
	file://files/testcase/sec.9.1 \
	file://files/testcase/sec.1.3 \
	file://files/testcase/sfa.1.0 \
	file://files/testcase/sfa.2.1 \
	file://files/testcase/sfa.2.2 \
	file://files/testcase/sfa.3.0 \
	file://files/testcase/sfa.4.0 \
	file://files/testcase/sfa.8.0 \
	file://files/testcase/sfa.10.0 \
	file://files/testcase/cfh.2.0 \
	file://files/testcase/caf.2.1 \
	file://files/testcase/caf.2.2 \
	file://files/testcase/std.6.1 \
	file://files/cover.conf \
	file://files/doc/how_to_add_testcase.txt \
	file://files/doc/test_case_template \
	file://files/doc/description_of_function.txt \
	file://files/config.sh \
	file://files/CHANGELOG \
	file://files/cgl_test.sh \
	file://files/scripts/bonding.sh \
	file://files/scripts/kexec-test.sh \
	file://files/scripts/iscsi.sh \
	file://files/scripts/saftest.sh \
	file://files/scripts/coredump_test.sh \
	file://files/scripts/kexec-test-install \
	file://files/scripts/selinux.sh \
	file://files/scripts/reboot.sh \
	file://files/scripts/tmpfs.sh \
	file://files/scripts/perf.sh \
	file://files/scripts/ocfs2.sh \
	file://files/scripts/gdb.sh \
	file://files/scripts/logcheck.sh \
	file://files/scripts/snmp.sh \
	file://files/scripts/cluster.sh \
	file://files/scripts/kdump.sh \
	"

EXTRA_OEMAKE = "\
	LDFLAGS="-lpthread -lc -lrt -lresolv -lm -lc ${LDFLAGS}" \
	"

do_patch() {
	cp -r ${WORKDIR}/files/* ${S}
}

do_install() {
	mkdir -p ${D}/opt/cut
	tar -C ${S} -hcpf - . \
         | tar -C ${D}/opt/cut -xpf - \
           --exclude='*.c' \
           --exclude='*.cpp' \
           --exclude='*.l' \
           --exclude='*.h' \
           --exclude='*.o' \
           --exclude='*/lib*.a' \
           --exclude='Makefile*' \
           --exclude=ballista \
           --exclude='*.pl' \
           --exclude='*.pm' \
           --exclude='*ebug*.list' \
           --exclude='*.cgi'
	   mv ${D}/opt/cut/src ${D}/opt/cut/bin

	# We can get QA ownership warnings if we do not do this!
	chown -R root:root ${D}/opt

}

FILES_${PN} += "/opt/cut/*"
FILES_${PN}-dbg += "/opt/cut/bin/.debug"
FILES_${PN}-dbg += "/opt/cut/rb-futex/nptl/.debug"
