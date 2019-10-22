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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "fcbe51dfa0a763a07e4cd66204d6c0ba054663ce"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-base ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "dc9368f9684d34e778f1670cce60c519f7886bc4"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "b48d4d0ad984f3b377c6573927672b71011c05f1"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "52a86c505fccb140b9bfebff5d3ddf10434dd21b"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "9cad7bb8bcd3686f580a3363847ee9c9e86928b1"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "dc2be1a546e937374590ce3858b717489ded2c21"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "49e2fc02b5a00ab9fc64d01b57609d06aff977a1"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "9a10f5761c01ab1553d6dcbc276d4f41e7c21da6"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "72e67aa2570880e386d049609aa99997d8c71c55"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "501d680535903acc00808c36f2cc07f2dc725adc"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "dd25a04fc5e2e4549fc9b86157a01e0c72b53b03"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.20"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "b21ee3e7a87782b4015247c7bb5bcf03df83e94b"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.20"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "bd0762cd138f1624b5a5f8669cfa3ac2b71cb87b"
LINUX_VERSION_5.2 = "5.2.20"
