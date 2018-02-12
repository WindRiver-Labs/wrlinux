#
# Copyright (C) 2014 Wind River Systems, Inc.
#
SUMMARY = "A compression/decompression library"
DESCRIPTION = "Snappy is a fast data compression and decompression library \
It was designed to be very fast and stable, but not to achieve a high \
compression ratio."

LICENSE = "NewBSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=b2c8cef4261c6377dcae51b2903d704b"

SRC_URI = "http://src.fedoraproject.org/repo/pkgs/snappy/snappy-1.1.1.tar.gz/8887e3b7253b22a31f5486bca3cbc1c2/snappy-1.1.1.tar.gz"

SRC_URI[md5sum] = "8887e3b7253b22a31f5486bca3cbc1c2"
SRC_URI[sha256sum] = "d79f04a41b0b513a014042a4365ec999a1ad5575e10d5e5578720010cb62fab3"

inherit autotools pkgconfig

PACKAGECONFIG ??= ""
PACKAGECONFIG[lzo] = "ac_cv_lib_lzo2_lzo1x_1_15_compress=yes,ac_cv_lib_lzo2_lzo1x_1_15_compress=no,lzo,"
