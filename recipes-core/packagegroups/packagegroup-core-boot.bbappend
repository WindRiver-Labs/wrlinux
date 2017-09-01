#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#

PACKAGES += "packagegroup-wr-boot"

WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS ?= ""
ALLOW_EMPTY_packagegroup-wr-boot = "1"
RDEPENDS_packagegroup-wr-boot = "${PN} ${WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS}"

# add wr-init
RDEPENDS_${PN} += "wr-init"

# Need these, but images may choose to pull them from various
# packages, e.g. busybox or bash+busybox-oe-min.
# The following only works with the RPM backend...
FILERDEPENDS_${PN} = "/bin/sh /usr/bin/run-parts /sbin/start-stop-daemon /sbin/ifup"
