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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "d0a10775d1cd3254de5fd7ab0616038e64e883f3"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-base ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "f4817c0b6cda3a2524e11cc3150538689a4b0a8c"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "3ae2f9c80c6e841725a3e2f064bc0d3870106d0c"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "147f60f8587988ffebff782e088e9b68bf2bd78a"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "bf600bf15145aabe827ea2bb4368f20db1a51f0f"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "497185e6a1627c6039dccbb8b7796706abcaf6ad"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "1b7bd87c8debcffbfa35d06756c53ad748bc62fd"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "e47a046e69c9ab1798c0e246b213d3d051af8565"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "525dbcafd8d49f19aa537e4afcda0c5e759587f2"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "b6bca1fab144baefd2a2a771dc211b7a066f8d93"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "90883e86e6348ad4fdad00a5eaf1fbdc4c5b2504"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "c73e075418dfe57dc06da0f0ba9cef4ec8c66771"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.26"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "d28ae212987d76e8a2751ad8e25cb7dbd522039d"
LINUX_VERSION_5.2 = "5.2.26"
