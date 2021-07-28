# Wind River Linux target images

The images are built from Wind River Linux, which support ostree, docker, kubernetes, xfce openvino and other features in the packages feeds. The images can be highly customized, they can be customized by package manager dnf, or use the script gen-image to rebuild them from source.

## Features
Arch: x86_64 (corei7_64)
Package Manager: dnf
glibc: 2.31
Features: ostree docker kubernetes xfce openvino

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

NOTE: On target, run ostree_upgrade.sh to update the image rather than
'ostree pull'. Use "ostree remote add wrlinux xxx" to add remote repo
if not present.

## Supported BSPs
- Intel NUC Platform: KabyLake-U Processor, Sunrise Point-LP PCH, (NUC7i5DNK1E)
- Intel Tiger Lake UP3: 11th Gen Intel(R) Core(TM) processors
- Intel Ice Lake-SP: 3rd Gen Intel(R) Xeon(R) Scalable processor
- Intel Snow Ridge: Intel Atom(R) P5362 processor
- qemux86-64

## How to install/boot binary image

### On Board
Under Linux, insert a USB flash drive.  Assuming the USB flash drive
takes device /dev/sdX, use dd to copy the image to it.  Before the image
can be burned onto a USB drive, it should be un-mounted. Some Linux distros
may automatically mount a USB drive when it is plugged in. Using USB device
/dev/sdX as an example, find all mounted partitions:

    $ mount | grep sdX

and un-mount those that are mounted, for example:

    $ sudo umount /dev/sdX*

Now burn the image onto the USB drive:
    For full image
    $ zcat image-full-intel-x86-64.ustart.img.gz | sudo dd of=/dev/sdX bs=1M status=progress

    Or minimal image
    $ zcat wrlinux-image-minimal-intel-x86-64.ustart.img.gz | sudo dd of=/dev/sdX bs=1M status=progress

    $ sync
    $ eject /dev/sdX

This should give you a bootable USB flash device.  Insert the device
into a bootable USB socket on the target, and power on.  This should
result in a system booted to the Grub boot menuo.

### On Qemu
Create a 8G disk image
    $ qemu-img create -f raw boot-image-qemu.hddimg 8G

Burn the image onto 8G disk image:
    For full image
    $ zcat wrlinux-image-full-intel-x86-64.ustart.img.gz | dd of=boot-image-qemu.hddimg conv=notrunc

    For minimal image
    $ zcat wrlinux-image-minimal-intel-x86-64.ustart.img.gz | dd of=boot-image-qemu.hddimg conv=notrunc

For qemu x86_64 with KVM:

    $ qemu-system-x86_64 -net nic -net user -m 512 \
        -drive if=none,id=hd,file=boot-image-qemu.hddimg,format=raw \
        -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=hd \
        -cpu kvm64 -enable-kvm \
        -drive if=pflash,format=qcow2,file=ovmf.qcow2

For qemu x86_64 without KVM:

    $ qemu-system-x86_64 -net nic -net user -m 512 \
        -drive if=none,id=hd,file=boot-image-qemu.hddimg,format=raw \
        -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=hd \
        -cpu Nehalem \
        -drive if=pflash,format=qcow2,file=ovmf.qcow2

#### Qemu Simulator (require 2.11 or higher)
qemu-system-x86_64

#### Qemu Networking
Create a SLiRP user network
`-net nic -net user`

#### Qemu Memory
Set guest startup RAM size, 512MB
`-m 512`

#### Qemu Image
Use virtio-scsi-pci to load image
`-drive if=none,id=hd,file=boot-image-qemu.hddimg,format=raw -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=hd`

#### Qemu CPU
- KVM
KVM has better performance based on virtualization as most of guest
instruction can be executed directly on the host processor.
`-cpu kvm64 -enable-kvm`
If kvm failed, please refer:
https://wiki.yoctoproject.org/wiki/How_to_enable_KVM_for_Poky_qemu

If above refer does not work (such as you do not have root right to enable kvm)

- For qemu x86_64, please simulate Intel Core i7 9xx (Nehalem Class Core i7)
`-cpu Nehalem`

#### Qemu Bootloader
Enable UEFI support for Virtual Machines
`-drive if=pflash,format=qcow2,file=ovmf.qcow2`

#### Qemu No Graphic
Disable graphical output and redirect serial I/Os to console
`-nographic`

## Install a package
Because dnf can't upgrade kernel on the ostree image, so run the following
command to ensure kernel is up to date and reboot, this action is only needed
when kernel is upgraded in the repo.
    $ ostree_upgrade.sh -b

Note, the previous action is only needed when kernel is upgraded in the repo,
otherwise it is not needed.

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

### Install telemetry agent
Here are the steps to setup a telemetry agent, use paho-mqtt
as a python MQTT client.

    $ ostree admin unlock --hotfix
    $ dnf install python3-paho-mqtt
    $ dnf install python3-paho-mqtt-examples
    $ cd /usr/share/python3-paho-mqtt/examples
    $ python3 client_sub_opts.py -H broker.emqx.io -t testtopic

Open another termimal:
    $ cd /usr/share/python3-paho-mqtt/examples
    $ python3 client_pub_opts.py -H broker.emqx.io -t testtopic  -N 3

Result:
Subscriber side:
    $ python3 client_sub_opts.py -H broker.emqx.io -t testtopic
    Connecting to broker.emqx.io port: 1883
    rc: 0
    Subscribed: 1 (0,)
    testtopic 0 b'{"msgnum": "0"}'
    testtopic 0 b'{"msgnum": "1"}'
    testtopic 0 b'{"msgnum": "2"}'

Publisher side:
    $ python3 client_pub_opts.py -H broker.emqx.io -t testtopic  -N 3
    Connecting to broker.emqx.io port: 1883
    Publishing: {"msgnum": "0"}
    mid: 1
    connect rc: 0
    Publishing: {"msgnum": "1"}
    mid: 2
    Publishing: {"msgnum": "2"}
    mid: 3

## Sources
Source code required to build the image is provided here:
https://distro.windriver.com/dist/wrlinux/lts-21/sources

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
