# This patch need to be remove to use spice with smartcard enabled.
FILESEXTRAPATHS_append := "${THISDIR}/files:"
SRC_URI += "\
	file://hook_support.py \
"

inherit useradd
USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "-r qemu; -r kvm"
USERADD_PARAM_${PN} = "-r -g qemu -G kvm qemu"

# configure needs some help
#
EXTRA_OECONF += "--with-qemu-user=qemu \
                 --with-qemu-group=qemu \
                "

# Use this if we want to configure like 1.0.0.
# We have added yajl because without it libvmi will not initialize.
#
PACKAGECONFIG = "qemu lxc test remote macvtap libvirtd udev yajl \
		 python ebtables fuse iproute2 \
		 firewalld gnutls libpcap \
		 ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)} \
		 ${@bb.utils.contains('KARCH', 'arm', '', 'numactl', d)} \
		"

PACKAGECONFIG[apparmor-profiles] = "--with-apparmor-profiles, --without-apparmor-profiles,"
PACKAGECONFIG[firewalld] = "--with-firewalld, --without-firewalld,"
PACKAGECONFIG[gnutls] = "--with-gnutls, --without-gnutls,gnutls,gnutls"
PACKAGECONFIG[libpcap] = "--with-libpcap, --without-libpcap,libpcap,libpcap"
PACKAGECONFIG[numad] = "--with-numad, --without-numad,"

# We get a QA error without this.
#
FILES_${PN}-dbg += "${libdir}/libvirt/lock-driver/.debug"

# libvirt unix sockets default to group root with umask 0777.  Change
# that to group kvm and umask 0776.
#

do_install_append() {
	echo "unix_sock_group=\"kvm\"" >> ${D}/etc/libvirt/libvirtd.conf
	echo "unix_sock_rw_perms=\"0776\"" >> ${D}/etc/libvirt/libvirtd.conf

	chown -R qemu:qemu ${D}/${localstatedir}/lib/libvirt/qemu
	echo "d qemu qemu 0755 ${localstatedir}/cache/libvirt/qemu none" \
	     >> ${D}${sysconfdir}/default/volatiles/99_libvirt

	# Enable hook support
	for hook in "daemon" "lxc" "network" "qemu"
	do
		install -m 0755 ${WORKDIR}/hook_support.py ${D}/etc/libvirt/hooks/${hook}
	done
}

pkg_postinst_libvirt_append() {
	mkdir -m 711 -p /data/images
}
