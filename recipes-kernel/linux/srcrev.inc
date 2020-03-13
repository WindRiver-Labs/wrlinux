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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "feaa815088202cfe729fe6835a30c35ba7cff8eb"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-base ?= "ae7696dc5847e3bc4220c0e37e7f8a7b7d341011"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "defc5c85f77d07330c5d9f779c3e78e5efcc298e"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "c64fbb34a01c95ec0dfd3194c3c3b8fce3790704"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "94d078fdbbed7b14be956724d3b4ec45a089c919"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "00c9da59b226875330cce6d50b557ed9c0a4b2e4"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "815a1b6597bdcaa23f02f746cc4309913340bb64"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "45b31e57fd5ccd13c5d0ecbe042acfefa87ad55f"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "934766ce30ed3f554cdf92f53d43ad28abde5397"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "5f746a80796844550f3eb324bc04dc3a0b92a364"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "c8a002fcafd5b869a94e11963b7eba8496df7980"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "22a0cebe090fb6ff8884d9c593d99b231991c988"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "b5cb6038ad619cedae5cbb3cd69a3aeb7a742cb8"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "8d7748afd9023f16bb8bfbc4635a77821d84dcca"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "d06ed6f789f1e245dd1016e15f0a9973cbc195e0"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "b33fd1bbbfd98156f1f838e3a8e05c1c13c20d3a"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "52ea952c64ce0a9ccb3ca664d8c706b0210d3127"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "1126c48e5dfb57d0a907a6f5835204e9f06ee678"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "67f0fcebbff1e93a91938543512197aa5e47d7ea"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "a7354a65ad0e714bd6a222a991d63b631c2fe2b7"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "c85c931e47188c8128101e655c063f25002fdb71"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "6bbcf21ec8de573f55546e2674e1427b9ef36a61"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.33"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "6abec0fabe6095b7fd8f5c6c05685bd3092d1578"
LINUX_VERSION_5.2 = "5.2.33"
