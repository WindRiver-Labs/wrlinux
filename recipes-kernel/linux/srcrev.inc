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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "9c67c0a16c97d94abe45f266f957a07dc596152a"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-base ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "955304a32e5a5b489ecba4be48c8ecd293c0fd3f"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "c1bdac6ebb973486183b1bb775ef0d5f26dde42d"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "bd0a6806a6def270a50a2c534493fb2b43272466"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "0d27529d5aeba1b417414a4aee58bcf41d0e0b15"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "1d8c78cf039759b0b08fd39cceef7a19de5cbf23"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "2afb323179dfb67a6dc24d37d9690a30d400bfed"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "14d7e259c57b61351047e48bb6935a623fd280e3"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "fa37fd4577236a2034221156324abecfc1ef5010"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "e25a433336ee6c5f3e8a1d141dd88ab0fce9501a"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "c93bf81feabf89b5ee77838d3bb62825d04dab09"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "16cbc504984ff949788fedd5ef94c71e2e32e337"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.21"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "e4b3bf42e616c0deb08345a55022fc3a1f06d84f"
LINUX_VERSION_5.2 = "5.2.21"
