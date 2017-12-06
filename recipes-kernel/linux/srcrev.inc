#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

MACHINEOVERRIDES =. "kb-${@d.getVar('KBRANCH', True).replace("/", "-")}:"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "9f857972035c7e3ae237d25a581eb695ffe78249"
SRCREV_machine_kb-standard-base ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-beaglebone ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-edgerouter ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "6f09510df55e760809f47e3315204437419a23e4"
SRCREV_machine_kb-standard-intel-x86 ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-mti-malta32 ?= "6527cf00278f043ba8f874ac7262261dd57e9a79"
SRCREV_machine_kb-standard-mti-malta64 ?= "ad347d33914f66c4b2aa6fca0c9f0a92773885cc"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-base ?= "01c33a38244f12f38db6081c9b76760ce503302c"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "01c33a38244f12f38db6081c9b76760ce503302c"
SRCREV_machine_kb-standard-nxp-ls-base ?= "df775016bae69dad1ab6120ceae1197db4f8d2d1"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1709-base ?= "df775016bae69dad1ab6120ceae1197db4f8d2d1"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1709-nxp-ls20xx ?= "df775016bae69dad1ab6120ceae1197db4f8d2d1"
SRCREV_machine_kb-standard-preempt-rt-base ?= "82dfc739621af193e6b5cb8f27f55c66db8e631b"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "8f6dd48eeac56ea2052ffdc356aa38b0c51abaad"
SRCREV_machine_kb-standard-preempt-rt-intel-x86 ?= "82dfc739621af193e6b5cb8f27f55c66db8e631b"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-base ?= "d62801ba9ef3ab072e39a5175bf0a39c6677b353"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "d62801ba9ef3ab072e39a5175bf0a39c6677b353"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-base ?= "13713e26fe3375ff165abc9dc7b7cbf885f032c8"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1709-base ?= "13713e26fe3375ff165abc9dc7b7cbf885f032c8"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1709-nxp-ls20xx ?= "13713e26fe3375ff165abc9dc7b7cbf885f032c8"
SRCREV_machine_kb-standard-preempt-rt-rebase ?= "5e69631e37265cb476821bb5da84b32c4a95feb5"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "82dfc739621af193e6b5cb8f27f55c66db8e631b"
SRCREV_machine_kb-standard-qemuarm64 ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-qemuppc ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-tiny-base ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-tiny-common-pc ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-tiny-intel-x86 ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-tiny-wr-base ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"
SRCREV_machine_kb-standard-wr-base ?= "1d685baca196583254d75f5cc7bc0ffedb8753ad"

# yocto-kernel-cache branch entry
KERNEL_CACHE_BRANCH = "yocto-4.12-wr"
SRCREV_meta = "7b0fbe5d1dcb33f377eaf3a3323bd56dbc8e1c1f"

LINUX_VERSION = "4.12.16"
