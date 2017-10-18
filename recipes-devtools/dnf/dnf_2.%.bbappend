FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${BPN}"

# Tell dnf to only pull validation keys from the local key directory
# /etc/rpm/keys/
# (this only works for 'rpm' repositories)
PACKAGECONFIG[keyringpath] = ",,,"
OVERRIDES .= "${@['', ':RPM-KEYRING-PATH']['keyringpath' in d.getVar('PACKAGECONFIG', True).split()]}"
SRC_URI_append_RPM-KEYRING-PATH = " \
    file://0001-load-gpgkey-from-rpm-keyring-by-default.patch \
"

do_install_append_rpm-keyring-path () {
        mkdir -p ${D}${sysconfdir}/yum.repos.d
}
