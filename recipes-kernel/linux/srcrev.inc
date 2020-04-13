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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "4d64f220742927ecaa34ddf9286312188a501981"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-base ?= "faf2427edad09ec18576d4d3c40bd85ae84d649d"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "5b0153215f064fdc902d5b29d2d08493846779e0"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "a3c747cea3352ec9bf85bcc9c5331f168b69827b"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "1ab54d4e4eeeb42af0dafcee5116de82e8ed00b6"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "1c9900686bc68f086f6404ac3870ba65b2ca8d9c"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "00e694db8e270d9fa40fa97dcb159930fce441f2"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "28a7c21e907d921b1591793a27d623f178ba7919"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "e95af587e4a0160cef79ff954e7df838f4d67fc1"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "194d7947a1e9cfa5de1634e22aee1d28fa3c4dec"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "3950b735eb84c267b87325db287b722148353edb"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "6efc7a1fc5f0bbe88aa74da4e68df1e8abede034"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "8de91062ba0d821075640cddcf72c335b8419390"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "78ad898fae4e4a6c31c12f8d4cf4f8584ff35fe5"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "0c13d7657c0f7d9ec49c7fd9258c129a8eeba30c"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "01c8c5702f071a5eb68b8ac39408c42b36f490f1"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "1a5b76c4055cfa4af2393224b90c34d2bd555e35"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "b63ec50c7344dfb0990666578aaea8e9555ed111"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "c04e82aa9f12b2a1415cd7bd451b17e81d53fd10"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "631bf96cc9d9edf6caff0695e90d7fa714ba44ba"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "cb8af39e3eaa7b6b44a112712dbd22c585ac493e"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "847408e216463f7de49cebb8a639dd169eff2e35"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "136934fe18e10125ae1c705fcc0487c0f1814ee2"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "63133f257625bd09a6fed8749372f60beb4ef412"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "21a389215a388bf67122fbefb4e5688cdc06959e"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.36"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "283bf41ecd3fe5d606eac4d9a21c146569525bd7"
LINUX_VERSION_5.2 = "5.2.36"
