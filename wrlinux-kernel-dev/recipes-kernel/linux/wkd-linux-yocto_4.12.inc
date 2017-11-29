FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# force compatibility when "kernel-dev" is being used
COMPATIBLE_MACHINE = "${MACHINE}"

# force autorev by uncommenting the following line
#OVERRIDES .= ":kernel-autorev"
SRCREV_machine_${MACHINE}_kernel-autorev ?= "${AUTOREV}"
SRCREV_meta_kernel-autorev ?= "${AUTOREV}"

# pick up feature handlers
require linux-windriver-handlers.inc

# Allow production of customer userspace headers
require wkd-linux-yocto-headers.inc
