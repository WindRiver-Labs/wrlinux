#
# Copyright (C) 2012 Wind River Systems Inc.
#
# This package matches a PACKAGE_GROUP_packagegroup-wr-core-networking definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-networking" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: networking"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
  file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "


PACKAGES = "${PN}"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
	geoip \
	geoip-perl \
	apache2 \
	bind \
	bridge-utils \
	freeradius \
	ifenslave \
	inetutils \
	ipsec-tools \
	libnet-ssleay-perl \
	libnet-libidn-perl \
	libnet-telnet-perl \
	libtext-iconv-perl \
	libxml-libxml-perl \
	libxml-namespacesupport-perl \
	libxml-sax-writer-perl \
	netcat \
	netcat-openbsd \
	netkit-rsh-client \
	netkit-telnet \
	ntop \
	ppp \
	python-paste \
	radvd \
	rdate \
	rdist \
	rsync \
	strongswan \
	tftp-hpa \
	tnftp \
	vlan \
	vsftpd \
	wireless-tools \
	wpa-supplicant \
	xinetd \
	samba \
	ntp \
	traceroute \
	tunctl \
	"
