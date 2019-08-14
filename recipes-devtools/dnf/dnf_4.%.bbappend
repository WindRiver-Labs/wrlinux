FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${BPN}"

# Tell dnf to only pull validation keys from the local key directory
# /etc/rpm/keys/
# (this only works for 'rpm' repositories)
PACKAGECONFIG[keyringpath] = ",,,"
OVERRIDES .= "${@['', ':rpm-keyring-path']['keyringpath' in (d.getVar('PACKAGECONFIG', True) or "").split()]}"
SRC_URI_append_rpm-keyring-path = " \
    file://0001-force-to-disable-gpgcheck-of-base-config.patch \
"

do_install_append_rpm-keyring-path () {
        mkdir -p ${D}${sysconfdir}/yum.repos.d
}
