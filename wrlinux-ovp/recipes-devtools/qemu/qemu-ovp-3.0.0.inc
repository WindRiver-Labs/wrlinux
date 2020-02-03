#
# Copyright (C) 2018 Wind River Systems, Inc.
#

# qemu-native should not depend on these packages
DEPENDS_qemu_append = " dtc pixman util-linux"
EXTRA_OECONF_append += "--disable-sdl --enable-fdt --disable-smartcard --cross-prefix=${TARGET_PREFIX}"

FILESEXTRAPATHS_append := "${THISDIR}/files"

CFLAGS_append += "-I${STAGING_INCDIR}/glib-2.0 -I${STAGING_LIBDIR}/glib-2.0/include "

# carry over cpu affinity patches from 1.3.0
SRC_URI += " \
        file://qemu-kvm-drop-cross-from-pkg-config.patch \
        file://0001-qemu-kvm-Add-options-to-pin-and-prioritize-vcpus.patch \
"

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
                  virtfs fdt glusterfs \
                  vhost pie alsa kvm \
                 " 

# This is making sure qemu-native independs on spice-native
# as spice-native is not provided
PACKAGECONFIG_append_x86-64_class-target = " spice rbd"

RDEPENDS_${PN}_class-nativesdk += "nativesdk-python-core"

# needed for libvirt
do_install_append () {
    cd ${D}${bindir}
    arch=`echo ${TARGET_ARCH} | sed 's/i[456]86/i386/' | sed 's/powerpc/ppc/'`
    ln -sf qemu-system-${arch} kvm
}
