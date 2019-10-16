FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI += " \
	file://init.luks \
	"

do_install_append() {
    install -m 0500 "${WORKDIR}/init.luks" "${D}"

    rm -rf "${D}/init.cryptfs"
}

FILES_${PN}-initramfs += "/init.luks"
FILES_${PN}-initramfs_remove += "/init.cryptfs"

RDEPENDS_${PN} += " \
		rng-tools \
		findutils \
		pv \
		gzip \
		tar \
		parted \
		e2fsprogs-tune2fs \
		e2fsprogs-mke2fs \
		util-linux-blkid \
		util-linux-lsblk \
	"
