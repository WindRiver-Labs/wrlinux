#
# Copyright (C) 2014 Wind River Systems, Inc.
#
SUMMARY = "Utility for IPMI control"
DESCRIPTION = "This package contains a utility for interfacing with devices that support \
the Intelligent Platform Management Interface specification. IPMI is \
an open standard for machine health, inventory, and remote power control. \
\
This utility can communicate with IPMI-enabled devices through either a \
kernel driver such as OpenIPMI or over the RMCP LAN protocol defined in \
the IPMI specification. IPMIv2 adds support for encrypted LAN \
communications and remote Serial-over-LAN functionality. \
\
It provides commands for reading the Sensor Data Repository (SDR) and \
displaying sensor values, displaying the contents of the System Event \
Log (SEL), printing Field Replaceable Unit (FRU) information, reading and \
setting LAN configuration, and chassis power control."
HOMEPAGE = "http://ipmitool.sourceforge.net/"
SECTION = "kernel/userland"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://COPYING;md5=9aa91e13d644326bf281924212862184"

DEPENDS = "openssl readline ncurses"

SRC_URI = "${SOURCEFORGE_MIRROR}/ipmitool/ipmitool-${PV}.tar.bz2 \
           "

SRC_URI[md5sum] = "f7408aa2b40333db0413d4aab6bbe978"
SRC_URI[sha256sum] = "97fa20efd9c87111455b174858544becae7fcc03a3cb7bf5c19b09065c842d02"


inherit autotools

# --disable-dependency-tracking speeds up the build
# --enable-file-security adds some security checks
# --disable-intf-free disables FreeIPMI support - we don't want to depend on
#   FreeIPMI libraries, FreeIPMI has its own ipmitoool-like utility.
#
EXTRA_OECONF = "--disable-dependency-tracking --enable-file-security --disable-intf-free"



