#
# Copyright (C) 2014 Wind River Systems, Inc.
#
SUMMARY = "An unified, distributed storage system"
DESCRIPTION = "Ceph uniquely provides object, block, and file storage in \
one unified system. Ceph's features include RADOS Block Device (RBD), \
RADOS Gateway and POSIX-compliant network file system"

LICENSE = " \
           BSD-3-Clause & \
           GPL-2.0 & \
           GPL-2.0-with-autoconf-exception & \
           LGPL-2.1 & \
           MIT & \
           PD & \
           CC-BY-SA-1.0 \
           "
LIC_FILES_CHKSUM = "file://COPYING;md5=6f6c8a16b49dec1921bac9a8ea8b8741"

SRC_URI = "\
	http://download.ceph.com/tarballs/ceph-${PV}.tar.gz \
	file://ceph.conf \
	file://ceph-skip-host-distribution-check.patch \
	file://0001-include-acconfig.h-to-avoid-static_assert-error.patch \
	file://0002-fix-to-build-with-boost-1.68.patch \
"
SRC_URI_append_arm = " file://0001-Explicitly-disable-neon-support-on-arm.patch"

SRC_URI[md5sum] = "5e875e2c3eb16d1876c930121f96f466"
SRC_URI[sha256sum] = "3a3d9cece76b7205afa5ba4943bf183e5063225cf3c901215d9042593b73fc7f"

inherit python-dir autotools-brokensep setuptools systemd

DEPENDS = "boost curl fcgi fuse keyutils leveldb libaio snappy \
           libedit libxml2 nss util-linux udev xfsprogs \
           python-setuptools-native python expat \
"

SYSTEMD_SERVICE_${PN} = "ceph-radosgw@.service \
	ceph-mon@.service \
	ceph-create-keys@.service \
	ceph-mds@.service \
	ceph-disk@.service \
	ceph-osd@.service \
	ceph.target \
"

CFLAGS += "-D_FILE_OFFSET_BITS=64"

PACKAGECONFIG = "nss radosgw"

PACKAGECONFIG[cryptopp] = "--with-cryptopp, --without-cryptopp,"
PACKAGECONFIG[libatomic-ops] = "--with-libatomic-ops, --without-libatomic-ops,"
PACKAGECONFIG[nss] = "--with-nss, --without-nss,nss,nss"
PACKAGECONFIG[ocf] = "--with-ocf, --without-ocf,"
PACKAGECONFIG[radosgw] = "--with-radosgw, --without-radosgw,"
PACKAGECONFIG[rest-bench] = "--with-rest-bench, --without-rest-bench,"
PACKAGECONFIG[tcmalloc] = "--with-tcmalloc, --without-tcmalloc,tcmalloc,tcmalloc"
PACKAGECONFIG[lttng] = "--with-lttng, --without-lttng,"

# uuidgen output on cluster host
CLUSTER_UUID ?= ""
# Public IP (eth0) on cluster host
PUBLIC_IP ?= ""
# Public network domain, i.e, 128.224.0.0/16 where the monitor is connected to
PUBLIC_DOMAIN ?= ""
# Private IP on cluster host used as cluster address connecting the OSDs
PRIVATE_IP ?= ""

export BUILD_SYS
export HOST_SYS

do_configure () {
    ./autogen.sh
    autotools_do_configure
}

do_compile_prepend() {
    cd ./src/ceph-detect-init/
    echo "" >> ${S}/src/acconfig.h
    echo "/* disable static_assert as a workaround for gcc8 */" >> ${S}/src/acconfig.h
    echo "#define static_assert(...)" >> ${S}/src/acconfig.h
}


do_install () {
    oe_runmake DESTDIR=${D} pythondir=${PYTHON_SITEPACKAGES_DIR} install
}

do_install_append () {
    install -m 644 src/upstart/* ${D}/${sysconfdir}/
    install -m 644 src/rbdmap ${D}/${sysconfdir}/ceph/
    install -m 644 ${WORKDIR}/ceph.conf ${D}/${sysconfdir}/ceph/
    install -d ${D}/${sysconfdir}/logrotate.d
    install -m 644 src/logrotate.conf ${D}/${sysconfdir}/logrotate.d/ceph

    if [ -z "${CEPH_DISABLE_CONF_SUBSTITUTIONS}" ]; then
        if [ -n "${CLUSTER_UUID}" ]; then
             sed -i -e 's|%CLUSTER_UUID%|${CLUSTER_UUID}|g' ${D}/${sysconfdir}/ceph/ceph.conf
        fi
        if [ -n "${PUBLIC_IP}" ]; then
             sed -i -e 's|%PUBLIC_IP%|${PUBLIC_IP}|g' ${D}/${sysconfdir}/ceph/ceph.conf
        fi
        if [ -n "${PUBLIC_DOMAIN}" ]; then
             sed -i -e 's|%PUBLIC_DOMAIN%|${PUBLIC_DOMAIN}|g' ${D}/${sysconfdir}/ceph/ceph.conf
        fi
        if [ -n "${PRIVATE_IP}" ]; then
             sed -i -e 's|%PRIVATE_IP%|${PRIVATE_IP}|g' ${D}/${sysconfdir}/ceph/ceph.conf
        fi
    fi
}

FILES_${PN} = "\
		${bindir}/ceph-run \
		${bindir}/monmaptool \
		${bindir}/osdmaptool \
		${bindir}/ceph-mon \
		${bindir}/ceph-debugpack \
		${bindir}/ceph-osd \
		${bindir}/crushtool \
		${bindir}/ceph-clsinfo \
		${bindir}/ceph_mon_store_converter \
		${bindir}/rbd-replay \
		${bindir}/cephfs-journal-tool \
		${bindir}/ceph_objectstore_tool \
		${bindir}/ceph-brag \
		${bindir}/rbd-replay-many \
		${bindir}/rbd-replay-prep \
		${bindir}/ceph-objectstore-tool \
		${bindir}/cephfs-table-tool \
		${bindir}/cephfs-data-scan \
		${sbindir}/ceph-create-keys \
		${sbindir}/ceph-disk* \
		${libdir}/ceph/ceph_common.sh \
		${libdir}/ceph/ceph-monstore-update-crush.sh \
		${libdir}/ceph/erasure-code/*.so.* \
		${libdir}/ceph/erasure-code/*.so \
		${libdir}/rados-classes/*.so* \
		${libdir}/libradosstriper.so.1.0.0 \
		${libdir}/libradosstriper.so.1 \
		${libexecdir}/ceph/ceph-osd-prestart.sh \
		${sysconfdir}/bash_completion.d/ceph \
		${sysconfdir}/ceph/rbdmap \
		${sysconfdir}/init.d/ceph \
		${sysconfdir}/init.d/rbdmap \
		${sysconfdir}/logrotate.d/ceph \
		${sysconfdir}/ceph-all.conf \
		${sysconfdir}/ceph-create-keys.conf \
		${sysconfdir}/ceph-mon*.conf \
		${sysconfdir}/ceph-osd*.conf \
		${sysconfdir}/rbdmap.conf \
		${sysconfdir}/ceph/ceph.conf \
		${sysconfdir}/ceph-disk.conf \
		${localstatedir} \
		"

FILES_${PN}-dev += "\
		${libdir}/ceph/erasure-code/*.la \
		${libdir}/rados-classes/libcls_user.so \
		${libdir}/rados-classes/*.la \
		"

FILES_${PN}-dbg += "\
		${libdir}/rados-classes/.debug/* \
		${libdir}/ceph/erasure-code/.debug/* \
		"

FILES_${PN}-staticdev += "\
		${libdir}/ceph/erasure-code/*.a \
		${libdir}/rados-classes/*.a \
		"

FILES_${PN}-common = "\
		${bindir}/ceph \
		${bindir}/ceph-authtool \
		${bindir}/ceph-conf \
		${bindir}/ceph-crush-location \
		${bindir}/ceph-dencoder \
		${bindir}/ceph-post-file \
		${bindir}/ceph-rest-api \
		${bindir}/ceph-syn \
		${bindir}/rados \
		${bindir}/rbd \
		${datadir}/ceph/* \
		${sysconfdir}/bash_completion.d/rados \
		${sysconfdir}/bash_completion.d/rbd \
		"

FILES_${PN}-fs-common = "\
		${bindir}/cephfs \
		${base_sbindir}/mount.ceph \
		"

FILES_${PN}-fuse = "\
		${bindir}/ceph-fuse \
		${base_sbindir}/mount.fuse.ceph \
		"

FILES_${PN}-mds = "\
		${bindir}/ceph-mds \
		${sysconfdir}/ceph-mds*.conf \
		"

FILES_${PN}-libcephfs1 = "\
		${libdir}/libcephfs.so.* \
"

FILES_${PN}-libcephfs1-dev = "\
		${libdir}/libcephfs.so \
		${libdir}/libcephfs.la \
		${includedir}/cephfs/libcephfs.h \
		"

FILES_${PN}-librados2 = "\
		${libdir}/librados.so.* \
"

FILES_${PN}-librados2-dev = "\
		${bindir}/librados-config \
		${libdir}/librados.so \
		${libdir}/librados.la \
		${includedir}/rados/* \
		"

FILES_${PN}-librbd1 = "\
		${bindir}/ceph-rbdnamer \
		${libdir}/librbd.so.1* \
		${base_libdir}/udev/rules.d/50-rbd.rules \
		"

FILES_${PN}-librbd1-dev = "\
		${libdir}/librbd.so \
		${libdir}/librbd.la \
		${includedir}/rbd/* \
		"

FILES_${PN}-python = "\
		${PYTHON_SITEPACKAGES_DIR}/* \
		"

FILES_${PN}-radosgw = "\
		${bindir}/radosgw* \
		${sysconfdir}/init.d/radosgw \
		${sysconfdir}/radosgw*.conf \
		${sysconfdir}/bash_completion.d/radosgw-admin \
		"

FILES_${PN}-rbd-fuse = "\
		${bindir}/rbd-fuse \
		"

FILES_${PN}-test = "\
		${bindir}/ceph-coverage \
		"

#Have to add .so into ceph package.
INSANE_SKIP_${PN} = "dev-so"

PACKAGES += "\
	${PN}-common \
	${PN}-fs-common \
	${PN}-fuse \
	${PN}-mds \
	${PN}-libcephfs1 \
	${PN}-libcephfs1-dev \
	${PN}-librados2 \
	${PN}-librados2-dev \
	${PN}-librbd1 \
	${PN}-librbd1-dev \
	${PN}-python \
	${PN}-radosgw \
	${PN}-rbd-fuse \
	${PN}-test \
"

RDEPENDS_${PN} += "\
		${PN}-common \
		${PN}-fs-common \
		${PN}-fuse \
		${PN}-mds \
		bash \
		babeltrace \
		util-linux-getopt \
"

RDEPENDS_${PN}-common += "\
		${PN}-libcephfs1 \
		${PN}-librados2 \
		${PN}-librbd1 \
		${PN}-python \
		bash \
"

RDEPENDS_${PN}-radosgw += "\
	${PN}-common \
"

RDEPENDS_${PN}-test += "\
	${PN}-common \
"
