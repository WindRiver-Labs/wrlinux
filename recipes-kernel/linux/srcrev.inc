#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

MACHINEOVERRIDES =. "kb-${@d.getVar('KBRANCH', True).replace("/", "-")}:"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "afd1340d4b7c2180ee0e5dbf79499fedf1a023a6"
SRCREV_machine_kb-standard-base ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-beagleboard ?= "59b8c4f5e8ddb9c33c62fff22204fe2b0d8c703e"
SRCREV_machine_kb-standard-beaglebone ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-edgerouter ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "3216acd3efa2093cdf006211dd32640f2b69fef7"
SRCREV_machine_kb-standard-mti-malta32 ?= "6d0052275c433f5a66282ad9f53525a7b6d36dfd"
SRCREV_machine_kb-standard-mti-malta64 ?= "c8adcd782e648cb70780443ee90e2f56e2209c5a"
SRCREV_machine_kb-standard-preempt-rt-base ?= "f792c32d8f19a31874ec40c033f36ef250e596ae"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "e070b530923e4989c7bc5941edc722ee8ef3642f"
SRCREV_machine_kb-standard-preempt-rt-rebase ?= "5e69631e37265cb476821bb5da84b32c4a95feb5"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "f792c32d8f19a31874ec40c033f36ef250e596ae"
SRCREV_machine_kb-standard-qemuarm64 ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-qemuppc ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-tiny-base ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-tiny-common-pc ?= "26c1863a744836d9171dff262b864cb67f4d537c"
SRCREV_machine_kb-standard-wr-base ?= "26c1863a744836d9171dff262b864cb67f4d537c"

# yocto-kernel-cache branch entry
SRCREV_meta = "8bbce61f5d3a063725c09fe4bc5afe3f227e9060"

LINUX_VERSION = "4.12.14"
