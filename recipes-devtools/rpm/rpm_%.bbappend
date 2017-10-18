FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${BPN}"

# Add in the macros.krp file to point to the keyring directory
# to put keys...
PACKAGECONFIG[keyringpath] = ",,,"
OVERRIDES .= "${@['', ':RPM-KEYRING-PATH']['keyringpath' in d.getVar('PACKAGECONFIG', True).split()]}"
SRC_URI_append_RPM-KEYRING-PATH = " \
    file://macros.krp \
    file://0001-do-not-limit-the-format-of-key-file.patch \
"

# Enforce signature checking and validation
PACKAGECONFIG[enforcesig] = ",,,"
OVERRIDES .= "${@['', ':RPM-ENFORCE']['enforcesig' in d.getVar('PACKAGECONFIG', True).split()]}"
CFLAGS_append_RPM-ENFORCE = " -DMANDATORY_KNOWN_SIG"
SRC_URI_append_RPM-ENFORCE = " file://0002-check-signature-with-error.patch"

do_install_append_RPM-KEYRING-PATH () {
	mkdir -p ${D}${sysconfdir}/rpm/
	install -m 0644 ${WORKDIR}/macros.krp ${D}${sysconfdir}/rpm/
}
