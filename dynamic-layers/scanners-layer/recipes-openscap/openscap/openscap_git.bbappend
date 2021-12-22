SRCREV = "e7db4f84e487c533fe5756ecd85ce96ec1e11cec"
SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https \
          "
PV = "1.3.5"

# Fix build failure with gcc-10
CFLAGS_append = " -fcommon"

DEPENDS_append = " xmlsec1"
DEPENDS_append_class-native = " xmlsec1-native"
