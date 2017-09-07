#
# Copyright (C) 2012-2014,2016 Wind River Systems, Inc.
#

# qemu-native should not depend on these packages
DEPENDS_qemu_append = " dtc pixman util-linux vmipc"
EXTRA_OECONF_append += "--disable-sdl --enable-fdt --with-system-pixman --disable-smartcard"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}-${PV}"

CFLAGS_append += "-I${STAGING_INCDIR}/glib-2.0 -I${STAGING_LIBDIR}/glib-2.0/include "

# carry over patches from 1.3.0
SRC_URI += "\
           file://qemu-kvm-drop-cross-from-pkg-config.patch \
           file://apic-fixup-fallthrough-to-PIC.patch \
          "

# carry over cpu affinity patches from 1.3.0
SRC_URI += " \
        file://qemu-kvm-Add-options-to-pin-and-prioritize-vcpus.patch \
        file://cpus-Store-VCPUs-tid-in-var-run-file.patch \
        file://pci-assign-Make-host-irq-to-vcpu-affinity.patch \
        file://Fix-vcpuaffine-feature-test-mask.patch \
"

# add Intel migration timing calculation patches
SRC_URI += "\
	file://0001-qemu-migration-compute-with-pages.patch \
	file://0002-migration-compression-cache-free.patch \
	file://0003-migration-thread-affinity-and-priority-qmp.patch \
"

# add fixes from qemu mailing list
# https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg01978.html
SRC_URI += "\
        file://0001-virtio-stop-virtqueue-processing-if-device-is-broken.patch \
        file://0002-virtio-handle-virtqueue_get_avail_bytes-errors.patch \
        file://0003-virtio-handle-virtqueue_num_heads-errors.patch \
        file://0004-virtio-handle-virtqueue_get_head-errors.patch \
"

# WRL toolchain defines OE_TOOLCHAIN_MACHINE, e.g. intel-xeon-core.
# Previously, that var was used for referencing the path to DPDK
# in sysroot.  But external toolchains do not define
# OE_TOOLCHAIN_MACHINE.  Extract the machine type from
# PKG_CONFIG_SYSROOT_DIR path, pull out the last word in the path.
MACHINE_TYPE := "`echo ${PKG_CONFIG_SYSROOT_DIR} | sed 's/^.*\/\(.[^\/]*$\)/\1/'`"
EXTRA_OECONF_append = " --cross-prefix=${TARGET_PREFIX} "
EXTRA_OECONF_append = " --disable-sdl --enable-fdt --with-system-pixman --disable-smartcard "
EXTRA_OECONF_append = " --disable-vmipc "

PACKAGECONFIG[spice] = "--enable-spice,--disable-spice,spice,"
PACKAGECONFIG[cap-ng] = "--enable-cap-ng,--disable-cap-ng,libcap-ng,"
PACKAGECONFIG[linux-aio] = "--enable-linux-aio,--disable-linux-aio,libaio,"
PACKAGECONFIG[xfsctl] = "--enable-xfsctl,--disable-xfsctl,xfsprogs,"
PACKAGECONFIG[glusterfs] = "--enable-glusterfs,--disable-glusterfs,glusterfs,"
PACKAGECONFIG[bluez] = "--enable-bluez,--disable-bluez,bluez4,"
PACKAGECONFIG[attr] = "--enable-attr,--disable-attr,attr,"
PACKAGECONFIG[virtfs] = "--enable-virtfs --enable-attr,--disable-virtfs,attr libcap,"
PACKAGECONFIG[rbd] = "--enable-rbd,--disable-rbd,ceph,ceph"
PACKAGECONFIG[vhost] = "--enable-vhost-net,--disable-vhost-net,,"
PACKAGECONFIG[ust] = "--enable-trace-backend=ust,--enable-trace-backend=nop,lttng-ust,"
PACKAGECONFIG[pie] = "--enable-pie,--disable-pie,,"
PACKAGECONFIG[snappy] = "--enable-snappy,--disable-snappy,snappy,"

# disable gl support for kvm
PACKAGECONFIG[gl] = ",,,"

PACKAGECONFIG ?= "cap-ng linux-aio xfsctl attr \
                  virtfs fdt rbd glusterfs\
                  vhost pie \
                 " 

# This is making sure qemu-native independs on spice-native
# as spice-native is not provided
PACKAGECONFIG_append_x86-64_class-target = " spice"

SRC_URI += "\
    file://qemu-add-trace-events-for-do_device_add.patch \
    file://migration-add-notification-via-vmipc.patch \
    file://qemu-inject-NMI-in-i6300esb-watchdog-timer.patch \
    file://qemu-update-msi-affinity-in-pci-assign-passthrough-d.patch \
    "

RDEPENDS_${PN}_class-nativesdk += "nativesdk-python-core"

# needed for libvirt
do_install_append () {
    cd ${D}${bindir}
    arch=`echo ${TARGET_ARCH} | sed 's/i[456]86/i386/' | sed 's/powerpc/ppc/'`
    ln -sf qemu-system-${arch} kvm
}
