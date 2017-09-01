#
# Copyright (C) 2013 Wind River Systems, Inc.
#
VALGRIND_powerpc = "${@bb.utils.contains("HOST_SYS","powerpc-wrs-linux-gnuspe","","valgrind",d)}"
