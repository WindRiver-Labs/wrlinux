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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "e658772b9197fde6d4272af5b7cec7dd0bde3d17"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-base ?= "170704c4143875104dfd9380f717d6a208e8020a"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "154c36d3da0318e45dd85a8e21b4f7d40198e5a4"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "63f3ef7f994009d70efa216de8fc76049132f6cd"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "660e376a57ef1bec7bd13717928564aeeaa1095b"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "fa1a81fdc4d47a23a385396d3b59f68146610c48"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "6af25c54424102d890cbd88f2ab564dbd1d9e79e"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "0e9ffff6daa83acf5f4d00185bcdd33bf58769c2"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "7399d88fe649e42708dd7bab25d33ba639efbc41"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "3f173e7465334b7efcc817e6372b7cb7bcc280f7"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "8478dac3545759f040fb59101968c86eee967d5b"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "943d725eb5989a09915c87c7e3f8d11bb18b8f0a"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "afd6473971fced6e5bbe733f11af5e4af6ef3999"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "d4b87d9bb89823148a4f47f1a4ba3cdba49f2351"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "e656344ce05214ce7f926cc08d8322787a321be5"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "05b69db3f7420ba77f0eb82477ee5bafaba60039"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "251ff7bf8d042ddfd9e82da074fad4af832f06f0"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "7d7b179bec1f1f54e7cbd44dab3bfa2b5442c9bf"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "6f6f9f6f796b9346185e65f28cdac85c646053f0"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "4e869d67c05246debc9de7e97eb5ec51f1881821"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "53f3fea733b1e4b5a41000edc7450a7ab356ece7"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "c40503bb7ebfca885e525ded5aa8ec57aebc4bd2"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "6e3f3b0c55aa1ed121dd5454ab812331ee27cfa5"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "afed65c9e794e420699f1eaacaf889254f0722fd"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "aaf1314b4acddf1da6d675100292965775e0a4bb"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.37"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "35ed7b6be3526c5481f6e94f612c11456ab729c2"
LINUX_VERSION_5.2 = "5.2.36"
