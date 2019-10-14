#
# Copyright (C) 2015 - 2017 Wind River Systems, Inc.
#

# Remove systemtap from RDEPENDS
# Systemtap is NOT supported, perf is the preferred tool for system-wide debug
SYSTEMTAP_osv-wrlinux = ""

# We have to do this, too, because a bbappend in yocto-bsps explicitly adds systemtap.
RDEPENDS_${PN}_remove_osv-wrlinux = "systemtap"

# Valgrind only works on powerpc w/o an SPE.
VALGRIND_powerpc = "${@bb.utils.contains("HOST_SYS","powerpc-wrs-linux-gnuspe","","valgrind",d)}"
