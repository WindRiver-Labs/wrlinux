#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

MACHINEOVERRIDES =. "kb-${@d.getVar('KBRANCH', True).replace("/", "-")}:"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "67b62d8d7bd9f19f0f4fad044787d947ebc4ec25"
SRCREV_machine_kb-standard-base ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-beagleboard ?= "59b8c4f5e8ddb9c33c62fff22204fe2b0d8c703e"
SRCREV_machine_kb-standard-beaglebone ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-edgerouter ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "8c360c7c3eebeb9251ddd8e9cde39908677f5850"
SRCREV_machine_kb-standard-mti-malta32 ?= "371926551d44c140a0fb869cec34762b40bdf1a6"
SRCREV_machine_kb-standard-mti-malta64 ?= "9d63d9c11c44ceabd452d7ee49cf55a88c39383f"
SRCREV_machine_kb-standard-preempt-rt-base ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-preempt-rt-rebase ?= "5e69631e37265cb476821bb5da84b32c4a95feb5"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-qemuarm64 ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-qemuppc ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-tiny-base ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-tiny-common-pc ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_machine_kb-standard-wr-base ?= "16de0149674ed12d983b77a453852ac2e64584b4"

# yocto-kernel-cache branch entry
SRCREV_meta = "6895e1104b39ef7ccf2d9eeb5947bfe4221fd10f"

LINUX_VERSION = "4.12.12"
