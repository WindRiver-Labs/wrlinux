#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

MACHINEOVERRIDES =. "kb-${@d.getVar('KBRANCH', True).replace("/", "-")}:"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "03489013c6844bf3f911e51c5b8cd3bd5c1dc6e9"
SRCREV_machine_kb-standard-base ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-beaglebone ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-edgerouter ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "2371bc95e9e809719cc7c535a50c930b281ea277"
SRCREV_machine_kb-standard-intel-x86 ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-mti-malta32 ?= "c22264e2e3340eb8affa9a9fc0b86decb2be26c6"
SRCREV_machine_kb-standard-mti-malta64 ?= "ead3f1c16e85d1b1074acdd13084b5cdf1104e23"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-base ?= "174bc425ad95db9b46d33dda4ea2134d2e7a0cd2"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "174bc425ad95db9b46d33dda4ea2134d2e7a0cd2"
SRCREV_machine_kb-standard-preempt-rt-base ?= "2143b758ad622a73c7c0b3fc8890b81000187635"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "264c8c49483adaec93e0e4d55e467ef94bf44570"
SRCREV_machine_kb-standard-preempt-rt-intel-x86 ?= "2143b758ad622a73c7c0b3fc8890b81000187635"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-base ?= "8a311a9fc98b7fbfd963f17085a19def75ca71dc"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "8a311a9fc98b7fbfd963f17085a19def75ca71dc"
SRCREV_machine_kb-standard-preempt-rt-rebase ?= "5e69631e37265cb476821bb5da84b32c4a95feb5"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "2143b758ad622a73c7c0b3fc8890b81000187635"
SRCREV_machine_kb-standard-qemuarm64 ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-qemuppc ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-tiny-base ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-tiny-common-pc ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-tiny-intel-x86 ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-tiny-wr-base ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"
SRCREV_machine_kb-standard-wr-base ?= "9cc6b0ae1aad7312e85ac4134398f81c0140de33"

# yocto-kernel-cache branch entry
KERNEL_CACHE_BRANCH = "yocto-4.12-wr"
SRCREV_meta = "7934f1219634d1e83aade622d3e98451511e5d03"

LINUX_VERSION = "4.12.14"
