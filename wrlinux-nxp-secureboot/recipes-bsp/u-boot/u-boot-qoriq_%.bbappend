FILESEXTRAPATHS_prepend_nxp-ls1043 := "${THISDIR}/files:"
SRC_URI_append_nxp-ls1043 = " \
    file://0001-u-boot-qoriq-add-CONFIG_FAT_WRITE-config.patch \
"
