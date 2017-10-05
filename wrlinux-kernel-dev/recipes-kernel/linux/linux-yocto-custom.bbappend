# Example of how to expand on linux-yocto-custom to
# build a custom kernel repo. Usually used in conjunciton
# with the feature/kernfeatures-clear template.

# Use mainline
SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;nocheckout=1;name=machine"

# Using a local kernel clone
#SRC_URI = "git:///home/<user>/git/linux.git;nocheckout=1;name=machine"

LINUX_VERSION ?= "4.12"
KERNEL_VERSION_SANITY_SKIP="1"

# tag: v4.22 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
SRCREV_machine="6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c"

COMPATIBLE_MACHINE = "qemux86-64"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://defconfig"

# pick up feature handlers
require linux-windriver-handlers.inc
