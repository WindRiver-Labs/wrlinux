SUMMARY = "Build Result Compare Script"
DESCRIPTION = "This package contains scripts to find out if the build result\
differs to a former build."
HOMEPAGE = "https://github.com/openSUSE/build-compare"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = "git://github.com/openSUSE/build-compare.git \
           file://0001-functions.sh-Fix-Process-Substitution-error.patch \
           file://0001-functions.sh-Don-t-compare-PAYLOADFLAGS.patch \
"

# Date matches entry in build-compare.changes and date of SRCREV.
#
SRCREV = "102d844ce052c6dec6c56ee1d471bde72a1b4633"
PE = "1"
PV = "2020.05.29+git${SRCPV}"
UPSTREAM_CHECK_COMMITS = "1"

S = "${WORKDIR}/git"

BBCLASSEXTEND = "native nativesdk"

do_install() {
    install -d ${D}/${bindir}
    install -m 755 functions.sh ${D}/${bindir}
    install -m 755 pkg-diff.sh ${D}/${bindir}
    install -m 755 same-build-result.sh ${D}/${bindir}
    install -m 755 srpm-check.sh ${D}/${bindir}
}

RDEPENDS_${PN} += "bash"
