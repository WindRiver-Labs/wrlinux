#
# This file is generated based on:
#     linux-yocto-5.2
#     yocto-kernel-cache
#
# Any manual changes will be overwritten.
#

# linux-yocto-5.2 entries
# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>
MACHINEOVERRIDES .= ":kb-${@d.getVar('KBRANCH', True).replace("/", "-")}"

# linux-yocto-5.2 branch entries
SRCREV_machine_kb-master ?= "ef283bb23883069e248fca8b4099c7dab9ddc8b6"
LINUX_VERSION_kb-master ?= "5.2.17"
SRCREV_machine_kb-v5.2-upstream ?= "5e408889e4af03a27b77cf4635934fefb9f4afab"
LINUX_VERSION_kb-v5.2-upstream ?= "5.2.17"
SRCREV_machine_kb-v5.2-base ?= "e9b75c60f91a359cb0e1b2d0a9ed1c81485215e2"
LINUX_VERSION_kb-v5.2-base ?= "5.2.2"
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "c823471bf471b472ff36b3c2ca1fed70ca972eda"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-base ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "2dc0e061c8e0857e24be0b92ec80ea00b4e5d0fc"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "d09d842d90ee891def1e0599bd287f9079b714a6"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "f8db08161e9121fb4061bff2f7e97fc6985a80c3"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "53eab83fc198b3ea20f2cbe14c232e104dd9a234"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "e3f9bf8ec923e973dc2c49512cbaf45f8f88e8b5"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "6b57735a83936356279cf553329e72688b4f17f9"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "672a424abb724a7393812cb647785d169ea64d1f"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "f0f8241da160f731fac1d3215991bf74efd3c315"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "6cd2d0dd7ec3e39af7b7450b9549c22a17857f1f"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "d919a90f1f3a8234d8eb60b0a03b07a90d7d3234"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "4642ca5f2e968a24227eec72c363117397358c28"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.23"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "88f566c37ea654be4e60180ecb21261cb7c3a40f"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.23"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "c4326f79cebfecfc7938f45cdcdb549024121519"
LINUX_VERSION_5.2 = "5.2.23"
