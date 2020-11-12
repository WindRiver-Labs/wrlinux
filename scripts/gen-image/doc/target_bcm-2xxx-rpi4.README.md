# Wind River Linux target images

The images are built from Wind River Linux CD release, which support ostree, docker, kubernetes, xfce and other features in the packages feeds. The images can be highly customized, they can be customized by package manager dnf, or use the script gen-image to rebuild them from source.

## Features
Arch: aarch64 (cortexa72)
Package Manager: dnf
glibc: 2.31
Features: ostree docker kubernetes xfce

### ostree
OSTree is a system for versioning updates of Linux-based operating
systems. It can be considered as "Git for operating system binaries".
It operates in userspace, and will work on top of any Linux file system.
At its core is a Git-like content-addressed object store with branches
(or "refs") to track meaningful file system trees within the store.
Similarly, one can check out or commit to these branches.

#### Ostree Upgrade

  $ ostree_upgrade.sh

This command wraps the ostree admin commands and handles the upgrade
using a single or multi-partition device in order to obtain the
specified branch configured in /sysroot/ostree/repo/config.

  Optional commands:

  -b   reboot after completion
  -e   Erase the /var volume on the next reboot
  -E   FORMAT the /var volume when on a separate partition on the next reboot
  -f   Force /etc to be entirely reset to the initial deploy state
  -r   Redeploy the current branch without doing a network pull
  -s   Skip the fsck integrity checks

  -F   Local Factory reset, uses -b -e -f -r -s
  -U   Factory upgrade reset, uses -b -e -f -s

## Supported BSPs
- bcm-2xxx-rpi4
- qemuarm64

## How to install/boot binary image

WARNING: The default password for root is root, change password is highly
recommended after login to the image.

### On Board
Under Linux, insert a micro SD card to a USB SD Card Reader.
Assuming the USB SD Card Reader takes device /dev/sdX, use dd
to copy the image to it. Before the image can be burned onto
a micro SD card, it should be un-mounted. Some Linux distros
may automatically mount when it is plugged in. Using device
/dev/sdX as an example, find all mounted partitions:

    $ mount | grep sdf

and un-mount those that are mounted, for example:

    $ umount /dev/sdX1
    $ umount /dev/sdX2

Now burn the image onto the micro SD card:
    For full image
    $ zcat wrlinux-image-full-bcm-2xxx-rpi4.ustart.img.gz | sudo dd of=/dev/sdX bs=1M status=progress

    Or minimal image
    $ zcat wrlinux-image-minimal-bcm-2xxx-rpi4.ustart.img.gz | sudo dd of=/dev/sdX bs=1M status=progress

    $ sync
    $ eject /dev/sdX

This should give you a bootable micro SD card device. Insert the
SD card into SD slot on Raspberrypi 4b board, and then power on.
This should result in a system booted to the u-boot menu.


### On Qemu
Create a 8G disk image
    $ qemu-img create -f raw boot-image-qemu.hddimg 8G

Burn the image onto 8G disk image:
    For full image
    $ zcat wrlinux-image-full-bcm-2xxx-rpi4.ustart.img.gz | dd of=boot-image-qemu.hddimg conv=notrunc

    For minimal image
    $ zcat wrlinux-image-minimal-bcm-2xxx-rpi4.ustart.img.gz | dd of=boot-image-qemu.hddimg conv=notrunc

For Qemu No Graphic:

    $ /usr/bin/qemu-system-aarch64 -machine virt -cpu cortex-a57 \
        -device virtio-net-device,netdev=net0 -netdev user,id=net0 \
        -m 512 \
        -bios qemu-u-boot-bcm-2xxx-rpi4.bin \
        -nographic \
        -drive id=disk0,file=boot-image-qemu.hddimg,if=none,format=raw -device virtio-blk-device,drive=disk0

Or Qemu Graphic (XFCE desktop):

    $ /usr/bin/qemu-system-aarch64 -machine virt -cpu cortex-a57 \
        -device virtio-net-device,netdev=net0 -netdev user,id=net0 \
        -m 512 \
        -bios qemu-u-boot-bcm-2xxx-rpi4.bin \
        -device virtio-gpu-pci -serial stdio \
        -device qemu-xhci -device usb-tablet -device usb-kbd \
        -drive id=disk0,file=boot-image-qemu.hddimg,if=none,format=raw -device virtio-blk-device,drive=disk0

#### Qemu Simulator
/usr/bin/qemu-system-aarch64

#### Qemu Networking
Create a SLiRP user network
`-device virtio-net-device,netdev=net0 -netdev user,id=net0`

#### Qemu Memory
Set guest startup RAM size, 512MB
`-m 512`

#### Qemu Image
Use virtio-blk-device to load image
`-drive id=disk0,file=boot-image-qemu.hddimg,if=none,format=raw -device virtio-blk-device,drive=disk0`

#### Qemu CPU
Use QEMU 2.11 ARM Virtual Machine with CPU cortex-a57
`-machine virt -cpu cortex-a57`

#### Qemu Bootloader
Add pre-built qemu bootloader qemu-u-boot-bcm-2xxx-rpi4.bin
`-bios qemu-u-boot-bcm-2xxx-rpi4.bin`

#### Qemu No Graphic
Disable graphical output and redirect serial I/Os to console
`-nographic`

#### Qemu Graphic (XFCE desktop)
Enable graphical and redirect serial I/Os to console
`-device virtio-gpu-pci -serial stdio`

Add Mouse and Keyboard
`-device qemu-xhci -device usb-tablet -device usb-kbd`

## Install a package
Because dnf can't upgrade kernel on the ostree image, so run the following
command to ensure kernel is up to date and reboot, this action is only needed
when kernel is upgraded in the repo.
    $ ostree_upgrade.sh -b

The images are locked by default, so need unlock firstly:
    $ ostree admin unlock --hotfix

To install a package
    $ dnf install <package>

To remove a package
    $ dnf remove <package>

### Install Graphical Desktop (XFCE) to minimal image
Here are the steps to install XFCE on minimal image:
    $ ostree admin unlock --hotfix
    $ dnf install -y packagegroup-xfce-base \
                     packagegroup-core-x11-base \
                     gsettings-desktop-schemas \
                     wr-themes
    $ systemctl set-default graphical.target
    $ reboot

## Sources
Source code required to build the image is provided here:
https://distro.windriver.com/release/wrlinux/linux-cd/base/WRLinux-CD-Images/sources

## License
The image is provided under the GPL-2.0 license.

Copyright (c) 2020 Wind River Systems Inc.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License version 2 as published by the Free
Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307 USA

The images include third party software which might be available under
additional open source licenses, including the base Wind River Linux CD
distribution along with third party dependencies.

## Legal Notices
All product names, logos, and brands are property of their respective owners.
All company, product and service names used in this software are for
identification purposes only. Wind River is a registered trademark of Wind River
Systems, Inc. Linux is a registered trademark owned by Linus Torvalds.

Disclaimer of Warranty / No Support: Wind River does not provide support and
maintenance services for this software, under Wind River’s standard Software
Support and Maintenance Agreement or otherwise. Unless required by applicable
law, Wind River provides the software (and each contributor provides its
contribution) on an “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, either
express or implied, including, without limitation, any warranties of TITLE,
NONINFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are
solely responsible for determining the appropriateness of using or
redistributing the software and assume any risks associated with your exercise
of permissions under the license.
