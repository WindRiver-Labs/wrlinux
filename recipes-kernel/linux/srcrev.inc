#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

MACHINEOVERRIDES =. "kb-${@d.getVar('KBRANCH', True).replace("/", "-")}:"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "63eabe4fc5b8645a2a1258ee9b2ec0e5c62b4236"
SRCREV_machine_kb-standard-base ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-beagleboard ?= "59b8c4f5e8ddb9c33c62fff22204fe2b0d8c703e"
SRCREV_machine_kb-standard-beaglebone ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-edgerouter ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "b04b0f91588f4f21017edb96a441b8a498d926e9"
SRCREV_machine_kb-standard-mti-malta32 ?= "64ac80375bc1c2e87002994c3112f30aa614d73e"
SRCREV_machine_kb-standard-mti-malta64 ?= "d481a271022e211857045b48d595826d8df051c4"
SRCREV_machine_kb-standard-preempt-rt-base ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-preempt-rt-rebase ?= "5e69631e37265cb476821bb5da84b32c4a95feb5"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-qemuarm64 ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-qemuppc ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-tiny-base ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-tiny-common-pc ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"
SRCREV_machine_kb-standard-wr-base ?= "1348b764f8ca8803b6b833c69f5cb795fddf24b8"

# yocto-kernel-cache branch entry
SRCREV_meta = "daacede608e07d391229ba0a6d74d6e082bead5f"

LINUX_VERSION = "4.12.14"
