#
# Copyright (C) 2016, 2017 Wind River Systems, Inc.
#

SUMMARY = "Pacemaker command line interface for management and configuration"
DESCRIPTION = "crm shell, a Pacemaker command line interface for management and configuration"

HOMEPAGE = "https://crmsh.github.io"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

DEPENDS = "asciidoc-native \
           docbook-xsl-stylesheets-native \
           libxslt-native \
           python-setuptools-native \
           "
RDEPENDS_${PN} = "pacemaker python-lxml gawk"

SRC_URI = "https://github.com/ClusterLabs/crmsh/archive/${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
           file://tweaks_for_build.patch \
          "

SRC_URI[md5sum] = "0a475d3c56a158dc991de61a26450eb5"
SRC_URI[sha256sum] = "ac78b7786f6a52cc3d86b3d80b2d8627e84873330cd4846d5ea48869189ad864"

inherit autotools-brokensep distutils-base

export HOST_SYS
export BUILD_SYS

# Allow to process DocBook documentations without requiring
# network accesses for the dtd and stylesheets
export SGML_CATALOG_FILES = "${STAGING_DATADIR_NATIVE}/xml/docbook/xsl-stylesheets/catalog.xml"

FILES_${PN} += "${PYTHON_SITEPACKAGES_DIR}/${BPN}"
