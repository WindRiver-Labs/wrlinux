#
# Copyright (C) 2013, 2016 Wind River Systems, Inc.
#
VALGRIND_powerpc = "${@bb.utils.contains("HOST_SYS","powerpc-wrs-linux-gnuspe","","valgrind",d)}"
