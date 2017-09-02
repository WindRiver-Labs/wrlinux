# LOCAL REV: WR specific image.
# 
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SPLASH_IMAGES += "file://psplash-windriver-img.h;outsuffix=windriver"

# We need a higher priority than the default one
ALTERNATIVE_PRIORITY_${PN}-windriver = "101"
