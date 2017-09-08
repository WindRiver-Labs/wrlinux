#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#
SUMMARY = "SNMP SMI/MIB Parser"
DESCRIPTION = "A pure-Python implementation of SNMP/SMI MIB \
  parsing and conversion library. Can produce PySNMP MIB modules. \
"
HOMEPAGE = "https://pypi.python.org/pypi/pysmi"
SECTION = "devel/python"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=38dc38520f3c5d1ac660db97808a8d7c"

SRCNAME = "pysmi"

SRC_URI = "https://files.pythonhosted.org/packages/source/p/${SRCNAME}/${SRCNAME}-${PV}.tar.gz"

SRC_URI[md5sum] = "01cce1977b68d7f79e0d994699163123"
SRC_URI[sha256sum] = "999f6db9e16f4cc2804263d825553dbdd188c4313ca5c1244eeb20a3c4a60116"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit setuptools

RDEPENDS_${PN} = "python-ply"
