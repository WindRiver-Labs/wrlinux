#!/bin/bash
builddir=`mktemp -d ./buildXXXX`
builddir=`realpath $builddir`
OE_SKIP_SDK_CHECK=1
FAKEROOTCMD="$OECORE_NATIVE_SYSROOT/usr/bin/pseudo"

. $OECORE_NATIVE_SYSROOT/usr/share/poky/oe-init-build-env $builddir >/dev/null
cd -

case $1 in
    create)
        shift
        FAKEROOTCMD=${FAKEROOTCMD} wic create -n $OECORE_NATIVE_SYSROOT -s $@
        ;;
    *)
        wic $@
        ;;
esac

rm -rf $builddir
