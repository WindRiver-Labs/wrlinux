inherit packagegroup

SRCNAME = "packagegroup-monitoring"

PROVIDES = "virtual/monitoring"

PACKAGES = "\
	${SRCNAME}-core \
	${SRCNAME}-agent \
	${SRCNAME}-proxy \
"

RDEPENDS_${SRCNAME}-core = ""
RDEPENDS_${SRCNAME}-agent = ""
RDEPENDS_${SRCNAME}-proxy = ""
