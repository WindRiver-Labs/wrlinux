#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#

SUMMARY = "An IPC library for high performance servers"

DESCRIPTION = "libqb is a library with the primary purpose of providing high \
               performance client server reusable features. It provides high \
               performance logging, tracing, ipc, and poll. \
              "
HOMEPAGE = "https://github.com/ClusterLabs/libqb"

LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=321bf41f280cf805086dd5a720b37785"

SRC_URI = "https://github.com/ClusterLabs/libqb/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
           file://remove-clock_getres-check.patch \
           "

SRC_URI[md5sum] = "84fe3ba91f0082a94ad4a6564086bc79"
SRC_URI[sha256sum] = "98a6f8d7b83013747788ff7f1aace387ec532a8e7fbecc354ad9260f426dd518"

inherit autotools pkgconfig

do_install_append() {
       sed -i "s/^Version: UNKNOWN/Version: ${PV}/" ${D}${libdir}/pkgconfig/libqb.pc
}
