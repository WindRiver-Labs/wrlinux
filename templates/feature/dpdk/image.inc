IMAGE_INSTALL += "dpdk dpdk-tools dpdk-module"

# dpdk 19.11 doesn't have dpdk-tools dpdk-module
# In meta-dpdk and meta-freescale layers, there are both dpdk 19.11, but the minor version is different.
# So, process them separately.
IMAGE_INSTALL_remove = "${@bb.utils.contains('PREFERRED_VERSION_dpdk', '19.11.%', 'dpdk-tools dpdk-module', '', d)}"
IMAGE_INSTALL_remove = "${@bb.utils.contains('PREFERRED_VERSION_dpdk', '19.11-20.12', 'dpdk-tools dpdk-module', '', d)}"
