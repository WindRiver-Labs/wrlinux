FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = " file://wr-init"

do_install_append() {
    rm -rf "${D}/init"
    install -m 0755 "${WORKDIR}/wr-init" "${D}/init"
}
