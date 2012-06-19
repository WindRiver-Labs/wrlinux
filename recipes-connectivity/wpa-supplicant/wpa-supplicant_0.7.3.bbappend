FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}_${PV}:"

SRC_URI_append += " file://wpa_supplicant-0.7.3-libnl-3-fixes-1.patch;patchdir=.."
