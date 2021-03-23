HOMEPAGE = "https://umo.ci/"
SUMMARY = "The umoci modifies Open Container images."
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

inherit go

SRC_URI = " \
    git://${GO_IMPORT}; \
"

SRCREV = "5efa06acfb3bb4e65d2711cf5255970948e047cf"
GO_IMPORT = "github.com/opencontainers/umoci"

S = "${WORKDIR}/git"

inherit goarch
inherit pkgconfig

export GO111MODULE="off"

BBCLASSEXTEND = "native nativesdk"

INSANE_SKIP_${PN} += "already-stripped"
INSANE_SKIP_${PN}-dev = "file-rdeps"

inherit features_check
REQUIRED_DISTRO_FEATURES = "lat"
