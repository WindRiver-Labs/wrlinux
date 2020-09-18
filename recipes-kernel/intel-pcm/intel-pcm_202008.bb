#
# Copyright (C) 2020 Wind River Systems, Inc.
#
SUMMARY = "Intel Processor Counter Monitor"

DESCRIPTION = "Software that understands and dynamically adjusts to \
resource utilization of modern processors has performance and power \
advantages. The Intel Performance Counter Monitor provides sample C++ \
routines and utilities to estimate the internal resource utilization \
of the latest Intel Xeon and Core processors and gain a significant \
performance boost."

HOMEPAGE = "https://github.com/opcm/pcm"

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a912073092d19dfa437272dbac06bb35"

SRCREV = "4ed054e1b23baf9b282cb8dc243b0a064ad1bd99"
SRC_URI = "git://github.com/opcm/pcm.git \
	   file://0001-Replace-all-g-to-CXX-for-cross-compiling.patch \
           "

S = "${WORKDIR}/git"

RDEPENDS_${PN} = "sudo"

do_install() {
	install -d ${D}/${sbindir}
	install -m 0755 pcm.x ${D}/${sbindir}/pcm
	install -m 0755 pcm-memory.x ${D}/${sbindir}/pcm-memory
	install -m 0755 pcm-msr.x ${D}/${sbindir}/pcm-msr
	install -m 0755 pcm-power.x ${D}/${sbindir}/pcm-power
	install -m 0755 pcm-sensor.x ${D}/${sbindir}/pcm-sensor
	install -m 0755 pcm-core.x ${D}/${sbindir}/pcm-core
	install -m 0755 pcm-iio.x ${D}/${sbindir}/pcm-iio
	install -m 0755 pcm-latency.x ${D}/${sbindir}/pcm-latency
	install -m 0755 pcm-lspci.x ${D}/${sbindir}/pcm-lspci
	install -m 0755 pcm-numa.x ${D}/${sbindir}/pcm-numa
	install -m 0755 pcm-pcicfg.x ${D}/${sbindir}/pcm-pcicfg
	install -m 0755 pcm-pcie.x ${D}/${sbindir}/pcm-pcie
	install -m 0755 pcm-tsx.x ${D}/${sbindir}/pcm-tsx
	install -m 0755 pcm-raw.x ${D}/${sbindir}/pcm-raw
	install -m 0755 pcm-bw-histogram.sh ${D}/${sbindir}/pcm-bw-histogram

	install -d ${D}/${bindir}
	install -m 0755 daemon/client/Debug/client ${D}/${bindir}/pcm-client
	install -m 0755 daemon/daemon/Debug/daemon ${D}/${bindir}/pcm-daemon
	install -m 0755 pcm-sensor-server.x        ${D}/${bindir}/pcm-sensor-server
}
