LIBX_DEV ?= ""
LIBX_DEV_x86-64 = "liblsan-dev libtsan-dev"

IMAGE_INSTALL += " \
    gcc-sanitizers \
    libasan-dev \
    libubsan-dev \
    ${@'' if d.getVar('MLPREFIX') else d.getVar('LIBX_DEV')} \
"
