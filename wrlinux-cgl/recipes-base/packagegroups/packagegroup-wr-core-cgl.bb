#
# Copyright (C) 2012 Wind River Systems Inc.
#
# This package matches a PACKAGE_GROUP_packagegroup-wr-core-cgl definition in
# wrlinux-image.bbclass that may be used to customize an image by
# adding "wr-core-cgl" to IMAGE_FEATURES.
#

DESCRIPTION = "Wind River Linux core package group: cgl"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
  file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
  file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
  "


PACKAGES = "${PN}"

ALLOW_EMPTY_${PN} = "1"

# crash is not available for mips.
#
def crash_be_gone(d):
    if d.getVar('TARGET_ARCH', True).startswith('mips'):
            return ""
    return "crash"

# Do not change anything that might have already been defined.
#
CRASH ?= "${@crash_be_gone(d)}"

NUMACTL = "numactl"
NUMACTL_arm = ""
NUMACTL_armeb = ""

RDEPENDS_${PN} = "\
	boost \
	cluster-glue \
	corosync \
	${CRASH} \
	device-mapper-multipath \
	drbd-utils \
	ecryptfs-utils \
	edac-utils \
	freediameter \
	ippool \
	iscsi-initiator-utils \
	lksctp-tools \
	libgssglue \
	logcheck \
	lvm2 \
	monit \
	${NUMACTL} \
	ocfs2-tools \
	openhpi \
	openl2tp \
	pacemaker \
	crmsh \
	passwdqc \
	postgresql \
	quagga \
	quagga-bgpd \
	quagga-isisd \
	quagga-ospf6d \
	quagga-ospfclient \
	quagga-ospfd \
	quagga-ripd \
	quagga-ripngd \
	${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'quagga-watchquagga', '', d)} \
	resource-agents \
	rng-tools \
	rpcbind \
	smartmontools \
	ucarp \
	pciutils \
	ipvsadm \
	"
