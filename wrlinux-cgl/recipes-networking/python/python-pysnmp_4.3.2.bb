#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#
SUMMARY = "A pure-Python SNMPv1/v2c/v3 library"
DESCRIPTION = "SNMP v1/v2c/v3 engine and apps written in pure-Python. \
  Supports Manager/Agent/Proxy roles, scriptable MIBs, asynchronous \
  operation (asyncio, twisted, asyncore) and multiple transports.\
"
HOMEPAGE = "https://pypi.python.org/pypi/pysnmp"
SECTION = "devel/python"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=254abdcaf3a38296357792b0688b821c"

SRCNAME = "pysnmp"

SRC_URI = "https://files.pythonhosted.org/packages/source/p/${SRCNAME}/${SRCNAME}-${PV}.tar.gz"

SRC_URI[md5sum] = "9a4d23c4c1edea1c77faed72c469d8e8"
SRC_URI[sha256sum] = "7c2bd81df17aa7dca0057a68e7a32284a72231309a0237d66d5b803b5c118977"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit setuptools

RDEPENDS_${PN} += "python-pycrypto \
                   python-pyasn1 \
                   python-pysmi \
"
