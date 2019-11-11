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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "93335e3d0acb7454c83bce7953ee9d03a35efc9a"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-base ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "2a34517a97f06b18213fc7c771c3c1c82bf8582c"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "3476dd7bcb47f86e450f9f0545cdd364170bf89c"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "a14a045789d4beadfe067dbb12ad312197420364"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "c15c4223db6b18e006c290312a6172547a14b841"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "e232ed9ae26f63b388ae0f3fb9d543a4d369db35"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "5bc76928dd614b75cfa6c1606362c03f69293f7e"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "64ea323b90275e7f14d89377c792bbfbb18c44a8"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "325b5d2e199daf17b78db9552298d8aad5ab14ae"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "07a00dcb99edfd265603f60c3e279056006ef528"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "8e35cd4c39258d1164e06351da55a21913664cae"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "d17d6745a19dddda645a6e934652eef06151806b"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.22"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "201d30e25c4f4b4d9c8910a09c8b326bff9ac2d9"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.22"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "69daf427fb16aa2f4dfbe598198aa0d36387e909"
LINUX_VERSION_5.2 = "5.2.21"
