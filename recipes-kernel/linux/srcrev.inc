#
# This file is generated based on the linux-yocto-4.12 and 
# yocto-kernel-cache repos.
#
# Any manual changes will be overwritten.
#

# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>
MACHINEOVERRIDES .= ":kb-${@d.getVar('KBRANCH', True).replace("/", "-")}"

# linux-yocto-4.12 branch entries
SRCREV_machine_kb-master ?= "1ea1c41db9839e56eb0f41dfffc7c6dd80bf7a64"
LINUX_VERSION_kb-master ?= "4.12.7"
SRCREV_machine_kb-standard-arm-versatile-926ejs ?= "1468230b86e557ea0f58165384c61fbeeb7b9c32"
LINUX_VERSION_kb-standard-arm-versatile-926ejs ?= "4.12.29"
SRCREV_machine_kb-standard-axxia-base ?= "406d83e976d8d6aa6c8a697f708bd9f666bdf948"
LINUX_VERSION_kb-standard-axxia-base ?= "4.12.29"
SRCREV_machine_kb-standard-base ?= "41fee946927dff1057707516dc1911d032b2cd3a"
LINUX_VERSION_kb-standard-base ?= "4.12.29"
SRCREV_machine_kb-standard-beaglebone ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-beaglebone ?= "4.12.29"
SRCREV_machine_kb-standard-edgerouter ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-edgerouter ?= "4.12.29"
SRCREV_machine_kb-standard-fsl-mpc8315e-rdb ?= "f9ad3fac9e2761709fdca2c01d2e983f7e2ec873"
LINUX_VERSION_kb-standard-fsl-mpc8315e-rdb ?= "4.12.29"
SRCREV_machine_kb-standard-intel-socfpga ?= "702c8a9fe7b01c2c46178eacc46c5d68941e5312"
LINUX_VERSION_kb-standard-intel-socfpga ?= "4.12.29"
SRCREV_machine_kb-standard-intel-x86 ?= "1bbb20a92534d22b3a66416308cc66c90709fccf"
LINUX_VERSION_kb-standard-intel-x86 ?= "4.12.29"
SRCREV_machine_kb-standard-marvell-base ?= "82c00bbf79695d55c441ef4049d11b2b1e888ae3"
LINUX_VERSION_kb-standard-marvell-base ?= "4.12.29"
SRCREV_machine_kb-standard-marvell-sdk-17.10.6-base ?= "e4be51e5b8523c443c9ea127e2948aa5bb090435"
LINUX_VERSION_kb-standard-marvell-sdk-17.10.6-base ?= "4.12.29"
SRCREV_machine_kb-standard-marvell-sdk-17.10.6-marvell-armada ?= "47013fd827d6e253569b944a8764cbb086ee957f"
LINUX_VERSION_kb-standard-marvell-sdk-17.10.6-marvell-armada ?= "4.12.29"
SRCREV_machine_kb-standard-mti-malta32 ?= "b1c4385fcd83e6bfeefd3efb052d35a970f5e201"
LINUX_VERSION_kb-standard-mti-malta32 ?= "4.12.29"
SRCREV_machine_kb-standard-mti-malta64 ?= "be47250d66f7b9ece0c7355d58d7242b57a267e0"
LINUX_VERSION_kb-standard-mti-malta64 ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-base ?= "416ba31a29a8c534c8e2194e823fd83178ef1339"
LINUX_VERSION_kb-standard-nxp-imx-sdk-4.9.11-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx6 ?= "d51bbfe1dd115f997008364b3b882d3e94f01adf"
LINUX_VERSION_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx6 ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "8605508f2f5152296830024a185ee0a228fb4646"
LINUX_VERSION_kb-standard-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.88-base ?= "448758a589253387dcea5a205b90a017f22a3287"
LINUX_VERSION_kb-standard-nxp-imx-sdk-4.9.88-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-imx-sdk-4.9.88-nxp-imx8 ?= "86ae4f75f080247d81ba63097d26f664eec2373f"
LINUX_VERSION_kb-standard-nxp-imx-sdk-4.9.88-nxp-imx8 ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-base ?= "daef521730d67a4e947e9eefaa9e3e9a7fe797e2"
LINUX_VERSION_kb-standard-nxp-ls-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1709-base ?= "7da216a3df8bfa2827256901c18814bf0851740d"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1709-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1709-nxp-ls10xx ?= "6a127fd33b74e64a0d6f61af0862fddc3f9a21ad"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1709-nxp-ls10xx ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1709-nxp-ls20xx ?= "bc9d1af3e68bb45725174a6ee7d8d417b11595ec"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1709-nxp-ls20xx ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1712-base ?= "cd76cc279817aded6784e13fc747f22c8fb5de41"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1712-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1712-nxp-ls1046 ?= "ad454854e2cc0cbe4cada8f32af0afac64ec4580"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1712-nxp-ls1046 ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-ls-lsdk-1712-nxp-lx2xxx ?= "e410ca46fb2a995aa6f9936d9c0c8d65249d322c"
LINUX_VERSION_kb-standard-nxp-ls-lsdk-1712-nxp-lx2xxx ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-qoriq-sdk-2-0-1703-base ?= "a05f623b82d174610502d90a083e43b4b4f20a57"
LINUX_VERSION_kb-standard-nxp-qoriq-sdk-2-0-1703-base ?= "4.12.29"
SRCREV_machine_kb-standard-nxp-qoriq-sdk-2-0-1703-nxp-t4xxx ?= "0ef34ddda78484c6a03354babfe31ff05f542296"
LINUX_VERSION_kb-standard-nxp-qoriq-sdk-2-0-1703-nxp-t4xxx ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-axxia-base ?= "fbd4dbb1c4bd7b6c475e556a8ddc6e8ca50c708a"
LINUX_VERSION_kb-standard-preempt-rt-axxia-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-base ?= "76f1001e0c23a23145b6a4637144ce115526cc78"
LINUX_VERSION_kb-standard-preempt-rt-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-intel ?= "fab7ddd749c590c1f50e9f72dfe59f69cb9a97bb"
LINUX_VERSION_kb-standard-preempt-rt-intel ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-intel-x86 ?= "2a0d90777c02295b6927c7dc877a37113777a179"
LINUX_VERSION_kb-standard-preempt-rt-intel-x86 ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-base ?= "81bacc52584f1d80a901ca58f11f1d886cd1f492"
LINUX_VERSION_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx6 ?= "4d8afb7b46f1fc53c1018eb425c08dc3f620f4f9"
LINUX_VERSION_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx6 ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "3145485f39a5280cf17735f3753d3e4f8828135f"
LINUX_VERSION_kb-standard-preempt-rt-nxp-imx-sdk-4.9.11-nxp-imx7 ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-base ?= "f5193da04682ea562eba13d8a1f5c0d7b0c7dc6b"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1709-base ?= "86abfe71075537543084e6b64c96d90b5e319d83"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1709-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1709-nxp-ls10xx ?= "a7e2efd7a182b0137a3bded4be0587800d6ad2ca"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1709-nxp-ls10xx ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1709-nxp-ls20xx ?= "a9bfedc6a0b92e81d84c8da1c56ad36185f3f9b6"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1709-nxp-ls20xx ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1712-base ?= "c3f08450bb35204595936e6c3e1234150b9233bc"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1712-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1712-nxp-ls1046 ?= "d766c8f44bf0fd88b8e3c310e3fb1bccf822a414"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1712-nxp-ls1046 ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-ls-lsdk-1712-nxp-lx2xxx ?= "46265fa3017685217d6f0500ed57ccb6801dd19f"
LINUX_VERSION_kb-standard-preempt-rt-nxp-ls-lsdk-1712-nxp-lx2xxx ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-qoriq-sdk-2-0-1703-base ?= "39297dc6ca65315c15eff8211e50ea47d9e5c883"
LINUX_VERSION_kb-standard-preempt-rt-nxp-qoriq-sdk-2-0-1703-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-nxp-qoriq-sdk-2-0-1703-nxp-t4xxx ?= "1b52c18df2f517ccf33b043dd2325744146c69df"
LINUX_VERSION_kb-standard-preempt-rt-nxp-qoriq-sdk-2-0-1703-nxp-t4xxx ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-wr-axxia-base ?= "3c2fb15af86173af52afb8c5bd47b797ef73080b"
LINUX_VERSION_kb-standard-preempt-rt-wr-axxia-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-wr-base ?= "470f1c38e8a6fe0ac674080c01bf53433969f1ac"
LINUX_VERSION_kb-standard-preempt-rt-wr-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-xilinx-sdk2017-04-base ?= "00ca43cc4129e168765eb51143a95bc69ab52862"
LINUX_VERSION_kb-standard-preempt-rt-xilinx-sdk2017-04-base ?= "4.12.29"
SRCREV_machine_kb-standard-preempt-rt-xilinx-sdk2017-04-xilinx-zynqmp ?= "f4ed023eb445317cc3d21f8a47257c0db9893b28"
LINUX_VERSION_kb-standard-preempt-rt-xilinx-sdk2017-04-xilinx-zynqmp ?= "4.12.29"
SRCREV_machine_kb-standard-qemuarm64 ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-qemuarm64 ?= "4.12.29"
SRCREV_machine_kb-standard-qemuppc ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-qemuppc ?= "4.12.29"
SRCREV_machine_kb-standard-ti-am335x ?= "45296b26979922cc4f9e409b4d5170be049a0e18"
LINUX_VERSION_kb-standard-ti-am335x ?= "4.12.29"
SRCREV_machine_kb-standard-tiny-base ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-tiny-base ?= "4.12.29"
SRCREV_machine_kb-standard-tiny-common-pc ?= "b290449bd3283fb698adfae63a082987c393414c"
LINUX_VERSION_kb-standard-tiny-common-pc ?= "4.12.29"
SRCREV_machine_kb-standard-tiny-intel-x86 ?= "12afd4127908495d1529d65b1ea2c81149f59338"
LINUX_VERSION_kb-standard-tiny-intel-x86 ?= "4.12.29"
SRCREV_machine_kb-standard-tiny-wr-base ?= "7bff336ea4f51d5df9bebf6cdecaa7850b17f494"
LINUX_VERSION_kb-standard-tiny-wr-base ?= "4.12.29"
SRCREV_machine_kb-standard-wr-axxia-base ?= "461ed8aeab0d86d29cc3d18c8a093e411577b985"
LINUX_VERSION_kb-standard-wr-axxia-base ?= "4.12.29"
SRCREV_machine_kb-standard-wr-base ?= "bd8033a6b746d39081dd909912a1e2137ae3798f"
LINUX_VERSION_kb-standard-wr-base ?= "4.12.29"
SRCREV_machine_kb-standard-xilinx-base ?= "dc372eaf7c566ea3e57cc5083568fdf2efa6b6db"
LINUX_VERSION_kb-standard-xilinx-base ?= "4.12.29"
SRCREV_machine_kb-standard-xilinx-sdk2017-04-base ?= "24d0355129a388f68161504d07a9e2ae99c48aab"
LINUX_VERSION_kb-standard-xilinx-sdk2017-04-base ?= "4.12.29"
SRCREV_machine_kb-standard-xilinx-sdk2017-04-xilinx-zynq ?= "7d8d3236a27c3735d874d5cc74b9558ad9879cd5"
LINUX_VERSION_kb-standard-xilinx-sdk2017-04-xilinx-zynq ?= "4.12.29"
SRCREV_machine_kb-standard-xilinx-sdk2017-04-xilinx-zynqmp ?= "d4096e42b50e3d37024ea8f1371b9cf1b9cf7d8c"
LINUX_VERSION_kb-standard-xilinx-sdk2017-04-xilinx-zynqmp ?= "4.12.29"

# yocto-kernel-cache branch entry
KERNEL_CACHE_BRANCH = "yocto-4.12-wr"
SRCREV_meta = "61ab4478528c6c1a13904654b35c3ebe0f912047"

LINUX_VERSION = "4.12.29"
