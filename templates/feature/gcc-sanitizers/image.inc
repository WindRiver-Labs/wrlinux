LIBX_DEV ?= ""
LIBX_DEV_x86-64 = "liblsan-dev libtsan-dev"

IMAGE_INSTALL += " \
    gcc-sanitizers \
    libasan-dev \
    libubsan-dev \
    ${LIBX_DEV} \
"
