
# We want dconf because it is a storage backend for gsettings,
# but we can't use it if x11 is not a feature.
#

def lcl_x11_check(d):
    distro_features = (d.getVar('DISTRO_FEATURES', True) or "").split()
    if "x11" in distro_features and "opengl" in distro_features:
        return "dconf-editor"
    return ""



RRECOMMENDS_${PN}_class-target += "${@lcl_x11_check(d)}"
