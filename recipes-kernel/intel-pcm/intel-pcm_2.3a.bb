#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "Intel Processor Counter Monitor"

DESCRIPTION = "Software that understands and dynamically adjusts to \
resource utilization of modern processors has performance and power \
advantages. The Intel Performance Counter Monitor provides sample C++ \
routines and utilities to estimate the internal resource utilization \
of the latest Intel Xeon and Core processors and gain a significant \
performance boost."

HOMEPAGE = "http://software.intel.com/en-us/articles/intel-performance-counter-monitor-a-better-way-to-measure-cpu-utilization"

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=bcc6ed4c19e32796aa1407d3ddc9d30a"

SRC_URI = "https://software.intel.com/system/files/article/326559/intelperformancecountermonitorv2.3a.zip \
	file://0001-intel-pcm-modify-Makefile-to-fit-wrlinux-build-syste.patch \
	file://0001-wr-kernel-intel-pcm-fix-No-GNU_HASH-in-the-elf-binar.patch"

SRC_URI[md5sum] = "554d38719dc0df35e0880334e6a8685d"
SRC_URI[sha256sum] = "72ad7cb5cf3fe687f324d245c3bbb9f0da6a93a686b7844bf60ea699c553a8cb"

S = "${WORKDIR}/IntelPerformanceCounterMonitorV2.3a"

RDEPENDS_${PN} = "sudo"

do_install() {
	install -d ${D}/${sbindir}
	install -m 0755 pcm.x ${D}/${sbindir}/pcm.x
	install -m 0755 pcm-memory.x ${D}/${sbindir}/pcm-memory.x
	install -m 0755 pcm-msr.x ${D}/${sbindir}/pcm-msr.x
	install -m 0755 pcm-power.x ${D}/${sbindir}/pcm-power.x
	install -m 0755 pcm-sensor.x ${D}/${sbindir}/pcm-sensor.x
}
