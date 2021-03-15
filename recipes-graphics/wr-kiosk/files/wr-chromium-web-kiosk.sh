#!/bin/sh

# setting default display for chromium
export DISPLAY=:0

chromium @KIOSK-MODE-FLAG@ \
    --load-extension="@EXTENSIONS@" \
    --window-size=@WINDOW-SIZE@ \
    @STARTING-URL@
