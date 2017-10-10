#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#

PACKAGES_append_osv-wrlinux = " packagegroup-wr-boot"

WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS ?= ""
ALLOW_EMPTY_packagegroup-wr-boot_osv-wrlinux = "1"
RDEPENDS_packagegroup-wr-boot_osv-wrlinux = "${PN} ${WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS}"

# add wr-init
RDEPENDS_${PN}_append_osv-wrlinux = " wr-init"

# Need these, but images may choose to pull them from various
# packages, e.g. busybox or bash+busybox-oe-min.
# The following only works with the RPM backend...
FILERDEPENDS_${PN}_osv-wrlinux = "/bin/sh /usr/bin/run-parts /sbin/start-stop-daemon /sbin/ifup"
