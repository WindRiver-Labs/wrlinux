#
# Copyright (C) 2012 Wind River Systems, Inc.
#
# LOCAL REV: WR specific fixes
#
# Enable/disable lm-sensors which provided by meta-oe
#

PACKAGECONFIG ??= ""
PACKAGECONFIG[lm-sensors] = "--enable-sensors,--disable-sensors,lmsensors,lmsensors-libsensors"

EXTRA_OEMAKE=''
EXTRA_OECONF += "--disable-stripping"

FILES_${PN} += "/usr/lib/sa"
FILES_${PN}-dbg += "/usr/lib/sa/.debug/"
