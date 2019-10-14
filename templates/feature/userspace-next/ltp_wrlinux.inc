# This patch backport form ltp upstream, that patch merged by ltp upstream
# on 20190521, but the latest ltp package version was 20190517. So when
# the ltp package upgrade to the next release to 20190517, we should remove
# this patch
FILESEXTRAPATHS_append := "${THISDIR}/ltp"
SRC_URI += " file://0040-overcommit_memory-update-for-mm-fix-false-positive-O.patch \
"
