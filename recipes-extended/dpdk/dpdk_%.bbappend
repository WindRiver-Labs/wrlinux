COMPATIBLE_HOST_wrlinux-ovp = "(x86_64.*|i.86.*)-linux"
COMPATIBLE_MACHINE_qemux86 = "${MACHINE}"
COMPATIBLE_MACHINE_qemux86-64 = "${MACHINE}"

PACKAGECONFIG_wrlinux-ovp ?= "libvirt"

DPDK_TARGET_MACHINE_qemux86 = "native"
DPDK_TARGET_MACHINE_qemux86-64 = "native"
