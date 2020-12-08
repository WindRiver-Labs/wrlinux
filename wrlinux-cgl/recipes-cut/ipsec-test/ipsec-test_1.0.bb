#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "ipsec-test"
DESCRIPTION = "The ipsec-test package contains a ipsec-test World program"
SECTION = "apps"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

SRC_URI = "\
	file://files/COPYING \
	file://files/ipsec.sh \
	file://files/ipsec_cut_config.sh \
	file://files/makeTunnel.sh \
	file://files/myCertgen.sh \
	file://files/strongswanCertgen.sh \
	file://files/confGen.sh \
	file://files/README \
	"

do_patch() {
	cp -r ${WORKDIR}/files/* ${S}
}

do_install() {
	mkdir -p ${D}/opt/cut/ipsec-strongswan
	mkdir -p ${D}/opt/cut/scripts
	install -m 0755 ${S}/* ${D}/opt/cut/ipsec-strongswan
	rm ${D}/opt/cut/ipsec-strongswan/COPYING
	mv ${D}/opt/cut/ipsec-strongswan/ipsec.sh  ${D}/opt/cut/scripts
}

# ipsec.sh needs this
#
RDEPENDS_${PN} += "bash"

FILES_${PN} += "/opt/cut/*"
