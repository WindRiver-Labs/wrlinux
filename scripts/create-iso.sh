#!/bin/bash

proddir=`readlink -f "${BASH_SOURCE%/*}"`

exec $proddir/create-usb.pl --isoimg "$@"
