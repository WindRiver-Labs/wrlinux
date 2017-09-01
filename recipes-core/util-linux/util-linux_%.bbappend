#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#
# In openembedded upstream recipe hwclock's priority is set to 10
# problem happens on nslu2
# we don't support this board, change it back to normal
# to support full features of hwclock from util-linux
ALTERNATIVE_PRIORITY[hwclock] = "100"

#include util-linux-agetty too
RRECOMMENDS_${PN} += " util-linux-agetty"

BBCLASSEXTEND = "native nativesdk"
