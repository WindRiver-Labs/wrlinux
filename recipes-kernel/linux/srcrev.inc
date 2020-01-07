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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "08e63a1cc01aaec43e451e20c88ed9002fee1b60"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-base ?= "8cbd83ecafb9c55698c21c9f5e147e132116eeee"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "c0752ace44897a32520380d943a89a00283915ca"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "b7d011a6c6f04d405b1a905a5dbe8219aec55bab"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "f5d9bf3eea6b5d9ab2a54b710d93fb7c1ef378f1"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "6b016024c12ff8e67d7dfc8acd67b60d9deaa16e"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "694f6c92824dcac4893ba5d0f73dc63cbba7d8f5"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "e93b33f7fbc821ec70a2354837d8384f0e0bd0cf"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "53c64e2d6cfffad0df9bbf673db2a53d2524c15e"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "3621f6128d1573043d31c85b81e06663acdfc80b"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "714bb59d9821b790e56529ca94b188ff4047c6ed"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "3c49106bfa2541dc2413dbf8671dd024672085d1"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "c57b1ad10c92b998f3c42973f1ad5c350d21abab"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "f423b93221003e8e396bd006d3e382d80393e497"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "b42f37581f9a4daea35c4b89bd61ce89bb4b151d"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "7af1efee7e37ffdabd01396cdc4d9701b9a50a36"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "7674f663793d47ccf4d1a021b4942fc24f8a5f2d"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "bf38f18be94cbe3db4569e1034a73df8b173417b"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "2a3a31d4f9e66bc926fd9b9dddcfd9a636741f80"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "52f1983b55ad3ca906777b2de3b06c9784fd7979"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "a50900c8655f36b81b088241646ef543b9dccaed"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "5212dc962e508e7c9e4f0d09b42df81b8d0c1e12"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.27"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "b8fe729e286acc8398bf82480fc9f046f805cdf8"
LINUX_VERSION_5.2 = "5.2.27"
