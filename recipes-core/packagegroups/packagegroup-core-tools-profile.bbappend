#
# Copyright (C) 2015 Wind River Systems, Inc.
#

# Remove systemtap from RDEPENDS
# Systemtap is NOT supported, perf is the preferred tool for system-wide debug
SYSTEMTAP = ""

# Valgrind only works on powerpc w/o an SPE.
VALGRIND_powerpc = "${@bb.utils.contains("HOST_SYS","powerpc-wrs-linux-gnuspe","","valgrind",d)}"
