COMPATIBLE_HOST_wrlinux-ovp = "(x86_64.*|i.86.*)-linux"
COMPATIBLE_MACHINE_wrlinux-ovp = "${MACHINE}"

PACKAGECONFIG ?= "libvirt"

# The list of intel Comms platforms and their target machine
# process mapping. The supported target machine is listed under
# dpdk/mk/machine
def get_dpdk_target_mach(bb, d):
    target_arch = d.getVar('MACHINE_ARCH', True)
    multiarch_options = {
        "mohonpeak64":    "atm",
        "mohonpeak32":    "atm",
        "crystalforest":  "ivb",
        "intel_corei7_64": "atm",
    }

    if target_arch in multiarch_options :
            return multiarch_options[target_arch]
    return "default"

