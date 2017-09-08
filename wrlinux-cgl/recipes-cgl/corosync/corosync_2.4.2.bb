#
# Copyright (C) 2015, 2017 Wind River Systems, Inc.
#

require corosync.inc

LIC_FILES_CHKSUM = "file://LICENSE;md5=a85eb4ce24033adb6088dd1d6ffc5e5d"

DEPENDS += "libqb"

SRC_URI += "file://corosync-2.x-remove-bashisms.patch"

SRC_URI[md5sum] = "7e9b72c21817bb6630c9bfaaa4076420"
SRC_URI[sha256sum] = "0dd0ee718253c18c5090e0304eec72a7be8b18b6fe5e03de59ce095fa08c8b63"

PACKAGECONFIG ??= "dbus qdevice qnetd snmp ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
PACKAGECONFIG[rdma] = "--enable-rdma,--disable-rdma"
PACKAGECONFIG[systemd] = "--enable-systemd,--disable-systemd"
PACKAGECONFIG[qdevice] = "--enable-qdevices,--disable-qdevices"
PACKAGECONFIG[qnetd] = "--enable-qnetd,--disable-qnetd"

SYSTEMD_SERVICE_${PN} += "corosync-qnetd.service corosync-qdevice.service"

EXTRA_OECONF = "BASHPATH=${base_bindir}/sh"
EXTRA_OEMAKE = "tmpfilesdir_DATA="

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "--system coroqnetd"
USERADD_PARAM_${PN} = "--system -d / -M -s /bin/nologin -c 'User for corosync-qnetd' -g coroqnetd coroqnetd"

inherit useradd
