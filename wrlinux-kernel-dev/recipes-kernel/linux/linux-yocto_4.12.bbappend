FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# force compatibility when "kernel-dev" is being used
COMPATIBLE_MACHINE = "${MACHINE}"

# force autorev by uncommenting the following line
#OVERRIDES .= ":kernel_autorev"
SRCREV_machine_${MACHINE}_kernel_autorev ?= "${AUTOREV}"
SRCREV_meta_kernel_autorev ?= "${AUTOREV}"

# pick up feature handlers
require linux-windriver-handlers.inc
