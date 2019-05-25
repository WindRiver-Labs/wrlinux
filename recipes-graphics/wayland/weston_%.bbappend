EXTRA_OECONF_append_nxp-imx6 = "\
	WESTON_NATIVE_BACKEND=fbdev-backend.so \
	"
EXTRA_OECONF_append_nxp-imx8 = "\
	WESTON_NATIVE_BACKEND=${@bb.utils.contains('DISTRO_FEATURES', 'imx8-graphic', 'drm-backend.so', 'fbdev-backend.so', d)}"
