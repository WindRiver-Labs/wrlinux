HOMEPAGE = "https://github.com/containers/skopeo"
SUMMARY = "Work with remote images registries - retrieving information, images, signing content"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=7e611105d3e369954840a6668c438584"

DEPENDS = " \
    gpgme \
    libdevmapper \
    lvm2 \
    btrfs-tools \
    glib-2.0 \
"

inherit go

RDEPENDS_${PN} = " \
     gpgme \
     libgpg-error \
     libassuan \
     libdevmapper \
"

SRC_URI = " \
    git://${GO_IMPORT};branch=release-1.1 \
    file://storage.conf \
    file://registries.conf \
"

SRCREV = "67abbb3cefbdc876447583d5ea45e76bf441eba7"
GO_IMPORT = "github.com/containers/skopeo"

S = "${WORKDIR}/git"

inherit goarch
inherit pkgconfig

do_compile() {
	cd ${S}/src/${GO_IMPORT}
	oe_runmake binary-local
}

do_install() {
	install -d ${D}/${sbindir}
	install -d ${D}/${sysconfdir}/containers
	install ${S}/src/${GO_IMPORT}/skopeo ${D}/${sbindir}/
	install ${S}/src/${GO_IMPORT}/default-policy.json ${D}/${sysconfdir}/containers/policy.json

	install ${WORKDIR}/storage.conf ${D}/${sysconfdir}/containers/storage.conf
	install ${WORKDIR}/registries.conf ${D}/${sysconfdir}/containers/registries.conf
}

INSANE_SKIP_${PN} += "ldflags"

BBCLASSEXTEND = "native nativesdk"
