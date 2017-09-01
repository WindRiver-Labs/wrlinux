FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

EXTRA_OECONF += "--with-fifodir=${localstatedir}/run --with-flagdir=${localstatedir}/run"

do_configure_prepend() {
	export piddir=${localstatedir}/run
}

do_install_append() {
	# work around ad43b78551d9e9f82f5e815c34e0ee63ac5153be
	# if ${D}/run doesn't exist, that line results in a failure for do_install
	true
}
