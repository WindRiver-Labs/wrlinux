#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#
SUMMARY = "Python Lex and Yacc"
DESCRIPTION = "Python ply: PLY is yet another implementation of lex and yacc for Python"
HOMEPAGE = "https://pypi.python.org/pypi/ply"
SECTION = "devel/python"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://README.md;beginline=3;endline=30;md5=39613fdd17adbac823a711a6aca64d1e"

SRCNAME = "ply"

SRC_URI = "https://files.pythonhosted.org/packages/source/p/${SRCNAME}/${SRCNAME}-${PV}.tar.gz"

SRC_URI[md5sum] = "c5c5767376eff902617fd9874f0c76b7"
SRC_URI[sha256sum] = "0d7e2940b9c57151392fceaa62b0865c45e06ce1e36687fd8d03f011a907f43e"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit setuptools
