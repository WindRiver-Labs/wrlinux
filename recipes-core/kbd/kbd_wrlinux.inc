# LOCAL REV: not accepted by oe-core
#

# The kbdrate application can only run on x86.
# It uses a hardware specific memory interface and addresses
# to access the keyboard driver.  PowerPC and ARM architectures
# may not have the same interface or keyboard driver loaded in
# in the same location
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Limit-kbdrate-to-x86-mips-and-sparc.patch"

