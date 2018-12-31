# Version format is 10.YY.WW.RCPL
# Where 10 is the major product version
# Where YY is the 2-digit year (such as 17)
# Where WW is the work-week (such as 5, 42, 42a) [a = second release of week]
# Where RCPL is the RCPL (0 means initial or CI version).

WRLINUX_MAJOR_VERSION  = "10"
WRLINUX_YEAR_VERSION   = "19"
WRLINUX_WW_VERSION     = "01"
WRLINUX_UPDATE_VERSION = "0"

WRLINUX_VERSION = "${WRLINUX_MAJOR_VERSION}.${WRLINUX_YEAR_VERSION}.${WRLINUX_WW_VERSION}.${WRLINUX_UPDATE_VERSION}"

WRLINUX_BRANDING       = "Wind River Linux"
WRLINUX_VARIANT        = ""
WRLINUX_BRANCH       ??= "${@'development' if d.getVar('WRLINUX_UPDATE_VERSION') == '0' else 'Base'}"

# Make sure that WRLINUX_VERSION and WRLINUX_BRANCH are printed to logs
BUILDCFG_VARS_prepend = "WRLINUX_VERSION WRLINUX_BRANCH "
