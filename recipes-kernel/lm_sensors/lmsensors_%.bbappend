# To includes most of the sensors and tools,
# so the following ensure that we can keep the same
# way to includes same stuff.
ALLOW_EMPTY_${PN} = "1"
RDEPENDS_${PN} += "lmsensors-fancontrol \
                   ${@bb.utils.contains_any('TARGET_ARCH', [ 'x86_64', 'i586', 'i686' ], 'lmsensors-isatools', '', d)} \
                   lmsensors-pwmconfig \
                   lmsensors-sensord \
                   lmsensors-sensorsconfconvert \
                   lmsensors-sensorsdetect \
"
