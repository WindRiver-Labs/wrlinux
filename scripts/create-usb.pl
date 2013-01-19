#!/usr/bin/perl

#  Copyright (c) 2011 Wind River Systems, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

use strict;
use Cwd;
my $progroot = $0;
my $orig_progroot = $0;
compute_top_build_dir();
$ENV{'PATH'} = "$progroot/host-cross/bin:$progroot/host-cross/usr/bin:$progroot/host-cross/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin";

chdir($progroot) || die "Could not change directory $progroot";
# Question answer globals
my $use_img = -1; # -1 = ask, 0 = write usb, 1 = write image
my $size_of_fat16 = 64;  # Default fat 16 size
my $size_of_ext2 = "all"; # Use rest of usb stick for ext2
my $readonly_ask = "y"; # Should mounted root file system be readonly?
my $extra_mb = -1; # Default of 100 extra megabytes to the image
my $useloop = 0;
my $format = -1;
my $ask_force = 1;
my $instdev = "";
my $rootfs_file = `ls -tr $progroot/export/*-dist.tar.bz2 2> /dev/null |head`; 
my $bzImage_file = `ls -tr $progroot/export/*bzImage* 2> /dev/null |head -1`;
chop($rootfs_file);
chop($bzImage_file);
my $do_unlink = 1;
my $LOOP_DEV = "";  # If someone bails with control-c, reset the loopdevice
my $USE_LOOP_SIZELIMIT = 1;

# Ask defaults
my $format_ask = "y";  # Format the usb stick?

# Internal processing globals
my @prtsz;  # Paritition map and byte offsets
my $ask_fat16 = 1;
my $ask_ext2 = 1;
my $convert_ext = 0;
my $ask_rootfs = 1;
my $ask_bzImage = 1;
my $use_tarfiles = 0;
my $iso_cfg_file = "syslinux-usb-initrd.cfg";
my $iso_initrd_file = "busybox-initrd-static";
my $iso_cfg_dir = "";
my $readonly = 1;
my $syslinux_usr_dir = "$progroot/host-cross/share/syslinux";
if (-e "$progroot/host-cross/usr/share/syslinux/mbr.bin") {
    $syslinux_usr_dir = "$progroot/host-cross/usr/share/syslinux";
}
my $mbr_file = "$syslinux_usr_dir/mbr.bin";
my $do_system = 1;  # Internal debug variable for execing commands
my @mounts; # List of what devices are mounted locally
my @execARG = @ARGV;
my $l_uid = (stat("$progroot/host-cross"))[4];

while (@ARGV) {
    if ($ARGV[0] eq "--usbimg") {
	$use_img = 0;
    } elsif ($ARGV[0] eq "--fileimg") {
	$use_img = 1;
    } elsif ($ARGV[0] eq "--force") {
	$ask_force = 0;
    } elsif ($ARGV[0] =~  /--rootfs=(.*)/) {
	$rootfs_file = $1;
	$ask_rootfs = 0;
    } elsif ($ARGV[0] =~  /--bzImage=(.*)/) {
	$ask_bzImage = 0;
	$bzImage_file = $1;
    } elsif ($ARGV[0] =~  /--extra-mb=(.*)/) {
	$extra_mb = $1;
    } elsif ($ARGV[0] =~  /--convert-extX=(.*)/) {
	$convert_ext = $1;
    } elsif ($ARGV[0] =~  /--ext2-mb=(.*)/) {
	$size_of_ext2 = $1;
	$ask_ext2 = 0;
    } elsif ($ARGV[0] =~  /--fat16-mb=(.*)/) {
	$size_of_fat16 = $1;
	$ask_fat16 = 0;
    } elsif ($ARGV[0] =~  /--extra-mb=(.*)/) {
	$extra_mb = $1;
    } elsif ($ARGV[0] =~  /--format=(.*)/) {
	if ($1 eq "n") {
	    $format = 0;
	} elsif ($1 eq "y") {
	    $format = 1;
	}
    } elsif ($ARGV[0] =~  /--instdev=(.*)/) {
	$instdev = $1;
    } elsif ($ARGV[0] eq "--rw") {
	$readonly_ask = "";
	$readonly = 0;
    } elsif ($ARGV[0] eq "--ro") {
	$readonly_ask = "";
	$readonly = 1;
    } elsif ($ARGV[0] eq "--no-rm") {
	$do_unlink = 0;
    } elsif ($ARGV[0] eq "--tarfiles") {
	$use_tarfiles = 1;
    } elsif ($ARGV[0] eq "--loop") {
	$instdev = "loop";
	$use_img = 0;
	$ask_force = 0;
	$format = 1;
	$useloop = 1;
    } else {
	if (!($ARGV[0] eq "--help" || $ARGV[0] eq "-h")) {
	    print "ERROR: invalid arg: $ARGV[0]\n";
	}
	usage();
    }
    shift @ARGV;
}

$SIG{INT} = \&shutdown_clean;
if ($useloop) {
    if (system("/sbin/losetup -h 2>&1 |grep sizelimit > /dev/null") != 0) {
	$USE_LOOP_SIZELIMIT = 0;
    }
}

#Ask if this is the usb
if ($use_img == -1) {
    $use_img = ask_yn("Build a disk image? y = file, n = direct write to usb", "y");
}

if (!$use_img) {
    # For writing to a USB device we need root
    if ($< != 0) {
	print "!!!!!!!WARNING This program must run as root!!!!!!!\n";
        print "The program writes to raw devices.\n";
	print "Please become root and run the program\n";
	print "Attempting to run: sudo $0 @execARG\n";
	exec "sudo BUILDDIR=\"$ENV{'BUILDDIR'}\" $0 @execARG --usbimg";
	exit_error();
    }

    print "================================================================\n";
    print "Welcome to the usb disk creation helper\n";
    print "!!WARNING!! Use this program with care as it has the possibility\n";
    print "to DESTROY data on any attached storage on your host system.\n";
    print "================================================================\n";
    
    while ($ask_force) {
	print "Continue [y/n]: ";
	$_ = <STDIN>;
	chop;
	last if ($_ eq "y" || $_ eq "Y");
	exit if ($_ eq "n" || $_ eq "N");
    }
    ask_usb_device();
} else {
    # set output file unless already set
    if ($instdev eq "") {
	$instdev = "$progroot/export/usb.img";
    }
    $instdev = ask_general("Location to write image file", $instdev);
}

if ($use_img) {
    if (! (-e "$progroot/export/dist/.")) {
	print "ERROR: No export/dist directory exists, stopping\n";
	exit_error();
    }
    $size_of_fat16 = ask_general("Size of FAT16 boot <#MEGS>", $size_of_fat16) if $ask_fat16;
    ask_ext2_size();
    ask_convert();
} else {
    # Ask about formatting the device
    if ($format == -1) {
	$format = ask_yn("Format device?", $format_ask);
    }
    # Ask about partition sizes for USB
    if ($format) {
	$size_of_fat16 = ask_general("Size of FAT16 boot <#MEGS>", $size_of_fat16) if $ask_fat16;
	if ($useloop) {
	    ask_ext2_size();
	} else {
	    $size_of_ext2 = ask_general("Size of ext2 fs <#MEGS OR all>", $size_of_ext2) if $ask_ext2;
	    if ($size_of_ext2 eq "all") {
		$size_of_ext2 = "";
	    } else {
		$size_of_ext2 = "+" . $size_of_ext2 . "M";
	    }
	}
	ask_convert();
    }
}
if (!$use_img) {
    # For usb write we ask for a bz2
    $rootfs_file = ask_general("Location of file system tar.bz2", $rootfs_file, 1) if ($ask_rootfs && $use_tarfiles);
}
$bzImage_file = ask_general("Location of bzImage", $bzImage_file, 1) if $ask_bzImage;
if ($readonly_ask ne "") {
    $readonly = ask_yn("Make root file system readonly?", $readonly_ask);
}

# Search for the installer/dist/syslinux/syslinux.cfg file
my $dirspec = "";
my $f = "";
my $layers = "";
foreach $f ("layer_paths", "layers") {
    if (-f "$progroot/$f") {
	open(F, "$progroot/$f");
	$layers = $f;
	last;
    } elsif (-f "export/$f") {
	$dirspec = "export/";
	$layers = $f;
	open(F, "export/$f");
	last;
    }
}
while(<F>) {
    chop();
    if (-e "$dirspec$_/dist/syslinux/$iso_cfg_file") {
	$iso_cfg_dir = `readlink -f $dirspec$_/dist/syslinux`;
	chop($iso_cfg_dir);
	last;
    }
    if (-e "$dirspec$_/data/syslinux/$iso_cfg_file") {
	$iso_cfg_dir = `readlink -f $dirspec$_/data/syslinux`;
	chop($iso_cfg_dir);
	last;
    }
}
close(F);
if ($iso_cfg_dir eq "") {
    # check if this is an SDK
    if (-e "export/wr-layer/data/syslinux/$iso_cfg_file") {
        $iso_cfg_dir = `readlink -f export/wr-layer/data/syslinux`;
        chop($iso_cfg_dir);
    }
}
if ($iso_cfg_dir eq "") {
    print "ERROR: Could not locate the $iso_cfg_file\n";
    exit_error();
}
if (!(-e $iso_initrd_file)) {
    $iso_initrd_file = "$iso_cfg_dir/$iso_initrd_file";
} 
if (!(-e $iso_initrd_file)) {
    print "ERROR: Could not locate the $iso_cfg_dir/busybox-initrd-static\n";
    exit_error();
}

print "\n#############  Begin scripted Execution ##################\n";

if ($use_img) {
    create_img();
    write_helper_mount();
    exit 0;
}

### All checks have passed now time for the dangerous part
# the rest of this focuses on writing to the USB device
# Start with formatting the device
format_usb_and_copy();

exit 0;

#-------------------------------------------------------------------#

sub ask_convert {
    if ($convert_ext == 0) {
	$convert_ext = ask_general("Use ext 2,3,4", 2);
    }
}

sub ask_ext2_size {
    my $sz = `du -sk --apparent-size $progroot/export/dist/.`;
    my $sz2 = `du -sk $progroot/export/dist/.`;
    chop($sz);
    ($sz) = split(/\s+/,$sz);
    $sz = int($sz);
    chop($sz2);
    ($sz2) = split(/\s+/,$sz2);
    $sz2 = int($sz2);
    if ($sz2 > $sz) {
	$sz = $sz2;
    }
    if ($extra_mb < 0) {
	$extra_mb = int(($sz/10000) + 0.5);
	$extra_mb = 100 if $extra_mb < 100;
    }
    if ($size_of_ext2 eq "all") {
	$size_of_ext2 = int(($sz / 1024) + 0.5);
	print "\n";
	print "   The size of export dist is: $size_of_ext2".  "MB\n";
	print "   The creation program automatically adds $extra_mb"."MB\n";
	print "       NOTE: You can make size of the ext2fs partition as large as you like \n";
	print "             so long as it does not exceed the size of the target device.\n";
	$size_of_ext2 += $extra_mb;
	$size_of_ext2 = ask_general("Size of ext2 fs <#MEGS>", $size_of_ext2) if $ask_ext2;
    }

}

sub create_img {
    my $tmpinst = $instdev;
    $tmpinst = `dirname $instdev`;
    chop($tmpinst);
    $tmpinst .= "/img_tmp";
    my $tmpinst0 = "$tmpinst.0";
    if ($useloop) {
	$tmpinst0 = $instdev;
    }
    my $heads = 255;
    my $sects = 63;
    my $cyl;

    mbr_check();

    print "== Starting USB Image creation ==\n";
    print "# Creating first sector with partition table and mbr\n";
    print "#    63 sectors * 512 bytes / sector = 32256 bytes\n";
    my $ddcmd = "dd conv=notrunc if=/dev/zero of=$tmpinst0 bs=32256 count=1";
    print "# Computed cylinders for fdisk in bytes\n";
    print "#  ( first 63 sectors * 255 + fat16 size bytes + ext2 size bytes ) / 255 / 63 / 512\n";
    $cyl = ((63 * 512) + ($size_of_fat16 + $size_of_ext2)*1024*1024) / 255 / 63 /512;
    print "# ((63 * 512) + ($size_of_fat16 + $size_of_ext2)*1024*1024) / 255 / 63 /512 = $cyl\n";
    $cyl = int($cyl + 1) if ($cyl != int($cyl));
    if (!$useloop) {
	unlink($tmpinst0);
	my $create_disk = sprintf("qemu-img create -f raw $tmpinst0 %iM", $size_of_fat16 + $size_of_ext2 + 1);	
	scriptcmd($create_disk);
    }
    scriptcmd($ddcmd) if (!$useloop);
    my $fatsz = "+" . $size_of_fat16 . "M";
    scriptcmd("fdisk -b 512 -H $heads -S $sects -C $cyl $tmpinst0 <<EOF
n
p
1

$fatsz
t
e
a
1
n
p
2


w
EOF
");
    scriptcmd("sync");
    scriptcmd("fdisk -H $heads -S $sects -C $cyl -l -u $tmpinst0");

    scriptcmd("partprobe") if ($useloop);
    # Read partition map for internal use
    my $i = 0;
    open(F, "fdisk -b 512 -H $heads -S $sects -C $cyl -l -u $tmpinst0|");
    while (<F>) {
	chop;
	if ($_ =~ /^\/.*?\s.*?(\d+).*?(\d+).*?(\d+)/) {
	    $prtsz[$i][0] = $1 * 512;
	    $prtsz[$i][1] = $2 * 512;
	    $prtsz[$i][2] = $3;
	    $prtsz[$i][3] = $prtsz[$i][1] - $prtsz[$i][0];
	    print "# Parition$i offsets start; $prtsz[$i][0] bytes end: $prtsz[$i][1] bytes $prtsz[$i][2] blocks\n";
	    $i++;
	}
    }
    close(F);
    if (!$useloop) {
	$ddcmd = sprintf("dd if=$tmpinst0 of=$tmpinst0-tmp bs=%i count=1", $prtsz[0][0]);
	scriptcmd($ddcmd);
	scriptcmd("mv $tmpinst0-tmp $tmpinst0");
    }
    print "#======Finalize mbr and partition table======\n";
    print "# Installing master boot record\n";
    call_dd_mbr($mbr_file, $tmpinst0);
    scriptcmd("sync");
    return if ($useloop);
    
    print "#======Create partition 1======\n";
    my $sz = $prtsz[0][3] + 512;
    print "# Create FAT 16 partition - $prtsz[0][1] - $prtsz[0][0] + 512 = $sz\n";
    $ddcmd = "dd if=/dev/zero of=$tmpinst.1 bs=$sz count=1";
    scriptcmd($ddcmd);
    scriptcmd("mkdosfs $tmpinst.1");
    scriptcmd("syslinux $tmpinst.1");
    print "# Copying files\n";
    dos_copy("$tmpinst.1");

    print "#======Create partition 2======\n";
    print "# Modify rootfs\n";
    make_fs_template("export/dist");
    chdir($progroot) || die "Could not change dir to $progroot";
    if (scriptcmd("./scripts/fakestart.sh genext2fs -z -b $prtsz[1][2] -d export/dist $tmpinst.2") != 0) {
	print "ERROR: File system creation failed!\n";
	exit_error();
    }
    if ($convert_ext == 3) {
	if (scriptcmd("./scripts/fakestart.sh tune2fs -j $tmpinst.2") != 0) {
	    print "ERROR: tunefs for ext3!\n";
	    exit_error();
	}
    }
    if ($convert_ext == 4) {
	if (scriptcmd("./scripts/fakestart.sh tune2fs -O extents,uninit_bg,dir_index,has_journal $tmpinst.2") != 0) {
	    print "ERROR: tunefs for ext4 failed!\n";
	    exit_error();
	}
	scriptcmd("./scripts/fakestart.sh e2fsck -yfDC0 $tmpinst.2")
    }
    scriptcmd("e2label $tmpinst.2 wr_usb_boot");

    print "#======Create final image======\n";
    scriptcmd("cat $tmpinst0 $tmpinst.1 $tmpinst.2 > $instdev\n");
    print "# Image created: $instdev\n";
    unlink("$tmpinst0") if $do_unlink;
    unlink("$tmpinst.1") if $do_unlink;
    unlink("$tmpinst.2") if $do_unlink;
}

sub lo_mount {
    my ($partition) = @_;
    my $sz_txt = "--sizelimit $prtsz[$partition][3]";
    $sz_txt = "" if (!$USE_LOOP_SIZELIMIT);
    my $cmd = "/sbin/losetup -o $prtsz[$partition][0] $sz_txt $instdev ./export/usb.img";
    if (scriptcmd($cmd) != 0) {
	die "ERROR: losetup failed to run";
    }
}

sub lo_umount {
    scriptcmd("sync");
    scriptcmd("/sbin/losetup -d $instdev");
}

sub call_dd_mbr {
    my ($mbr_file, $instdev) = @_;
    scriptcmd("dd conv=notrunc bs=440 count=1 if=$mbr_file of=$instdev");
}

sub write_helper_mount {
    my $file = "./export/mount_help.usb.img.txt";
    open(HELPER_OUT, ">$file") || \
	die "could not write ./export/mount_help.usb.img.txt";
    my $szstring = ",sizelimit=$prtsz[0][3]";
    $szstring = "" if (!$USE_LOOP_SIZELIMIT);
    my $cmd = "sudo mount -o loop,offset=$prtsz[0][0]$szstring usb.img /tmp/mnt1";
    $szstring = ",sizelimit=$prtsz[1][3]";
    my $lo_cmd = "# sudo /sbin/losetup -o $prtsz[0][0] --sizelimit $prtsz[0][3] -f --show ./export/usb.img";

    $szstring = "" if (!$USE_LOOP_SIZELIMIT);
    my $cmd2 = "sudo mount -o loop,offset=$prtsz[1][0]$szstring usb.img /tmp/mnt2";
    my $lo_cmd2 = "# sudo /sbin/losetup -o $prtsz[1][0] --sizelimit $prtsz[1][3] -f --show ./export/usb.img";
    print HELPER_OUT<<EOF;
# Example to mount first and second partition from usb image
# First partition - (fat)
mkdir -p /tmp/mnt1
$cmd
# Second partition - (ext2)
mkdir -p /tmp/mnt2
$cmd2

# Alternate use of setting up a device
$lo_cmd
$lo_cmd2
EOF
    close(HELPER_OUT);
    system("chown -R $l_uid $file");
}

sub format_usb_and_copy {
    my $ret = 0;
    return if (!$format);

    mbr_check();
    if ($useloop) {
	my $cmd = sprintf("qemu-img create -f raw ./export/usb.img %iM", $size_of_fat16 + $size_of_ext2 + 1);
	scriptcmd($cmd);
	scriptcmd(sprintf("chown %i ./export/usb.img", $l_uid));
	$instdev = `/sbin/losetup -f 2> /dev/null`;
	if ($? != 0) {
	    # Having no "losetup -f" means your host OS is OLD!
	    my $i;
	    for ($i = 0; $i < 10; $i++) {
		if (system("/sbin/losetup /dev/loop$i > /dev/null 2> /dev/null") != 0) {
		    $instdev = "/dev/loop$i\n";
		    last;
		}
	    }
	    if ($i >= 10) {
		die "ERROR Could not find a free loop device\n";
	    }
	}
	$LOOP_DEV = $instdev;
	chop($instdev);
	scriptcmd("/sbin/losetup $instdev ./export/usb.img");
    }
    format_partitions();
    scriptcmd("partprobe");
    scriptcmd("sync");
    call_dd_mbr($mbr_file, $instdev);
    scriptcmd("fdisk -l $instdev");
    scriptcmd("sync");
    write_helper_mount();
    if ($useloop) {
	lo_umount();
	# Dos partition build for loopback partition 1
	lo_mount(0);
	scriptcmd("mkdosfs $instdev");
	scriptcmd("syslinux $instdev");
	dos_copy($instdev);
	lo_umount();
	# Ext2 partition build for loopback partition 2
	lo_mount(1);
	my $sz = int($prtsz[1][3]/1024);
	if (scriptcmd("mke2fs -t ext$convert_ext -L wr_usb_boot $instdev $sz") != 0) {
	    lo_umount();
	}
	scriptcmd("sync");
	$ret = mount_and_copy($instdev);
	lo_umount();
    } else {
	scriptcmd("mkdosfs $instdev" . "1");
	scriptcmd("syslinux $instdev" . "1");
	dos_copy($instdev . "1");
	scriptcmd("mke2fs -t ext$convert_ext -L wr_usb_boot $instdev" . "2");
	$ret = mount_and_copy($instdev . "2");
    }
    exit_error() if ($ret);
}

sub dos_copy {
    my ($tgt) = @_;
    my $MTOOLSRC = "$progroot/mtools.conf";

    unlink($MTOOLSRC);
    open(F, ">$MTOOLSRC");
    print F "drive m: file=\"$tgt\"\n";
    print F "mtools_skip_check=1\n";
    close(F);

    $ENV{'MTOOLSRC'} = $MTOOLSRC;
    if (! (-e "$progroot/syslinux.cfg")) {
	system("cp $iso_cfg_dir/$iso_cfg_file $progroot/syslinux.cfg");
	chown($l_uid, -1, "$progroot/syslinux.cfg");
    }
    if ($readonly) {
	system("perl -p -i -e 's/(append.* )rw /\$1ro /' $progroot/syslinux.cfg");
    } else {
	system("perl -p -i -e 's/(append.* )ro /\$1rw /' $progroot/syslinux.cfg");
    }
    scriptcmd("mcopy -o $iso_cfg_dir/help.txt $iso_cfg_dir/splash.lss $iso_cfg_dir/splash.txt m:");
    scriptcmd("mcopy -o $syslinux_usr_dir/isolinux.bin $syslinux_usr_dir/vesamenu.c32 $syslinux_usr_dir/menu.c32 $progroot/syslinux.cfg m:");
    scriptcmd("mcopy -o $bzImage_file m:vmlinuz");
    scriptcmd("mcopy -o $iso_initrd_file m:initrd");
    unlink($MTOOLSRC);
}

sub mount_and_copy {
    my ($dev) = @_;
    my $MNTPOINT = `mktemp -d`;
    chop($MNTPOINT);
    # Check for SE Linux
    
    if (scriptcmd("mount -o context=system_u:object_r:removable_t:s0,nouser_xattr $dev $MNTPOINT") != 0) {
	print "# context mount failed, falling back to standard mount\n";
	if (scriptcmd("mount $dev $MNTPOINT") != 0) {
	    print "ERROR: Failed to mount $dev on $MNTPOINT\n";
	    return -1;
	}
    }
    if ($use_tarfiles) {
	print "(cd $MNTPOINT && tar -xSjvf $rootfs_file)\n";
	open(F, "cd $MNTPOINT && tar -xSjvf $rootfs_file|");
    } else {
	if (! (-e "$progroot/export/dist/.")) {
	    scriptcmd("umount $MNTPOINT");
	    print "ERROR: No export/dist directory exists, stopping\n";
	    return -1;
	}
	print "./scripts/fakestart.sh tar -C export/dist -cSpf - . | (cd $MNTPOINT && tar -xSvf -)\n";
	open(F, "./scripts/fakestart.sh tar -C export/dist -cSpf - . | (cd $MNTPOINT && tar -xSvf -) |");
    }
    print "#==Copying files to media, each . == 1000 files copied, this may take a while==\n";
    print "#";
    my $i;
    while(<F>) {
	$i++;
	if ($i % 1000 == 0) {
	    $| = 1;
	    print "."; 
	}
    }
    close(F);
    my $err = $?;
    if (!$use_tarfiles) {
	print "\n";
    }
    if ($err != 0) {
	scriptcmd("umount $MNTPOINT");
	print("ERROR: Root file system failed to copy to device.  Was there enough space?\n");
	return -1;
    }
    make_fs_template($MNTPOINT);
    print "\n#==Unmounting and syncing, may take some time...==\n";
    scriptcmd("umount $MNTPOINT");
    scriptcmd("sync");
    print "\n# Copy complete\n";
    scriptcmd("rmdir $MNTPOINT");
    scriptcmd("chown -R $l_uid host-cross/var/pseudo");
    return 0;
}

sub ask_yn {
    my ($txt,$default) = @_;
    while (1) {
	print "$txt <y/n>";
	if ($default ne "") {
	    print " [$default]: "
	}
	$_ = <STDIN>;
	chop;
	$_ = $default if ($_ eq "");
	return 1 if ($_ eq "y" || $_ eq "Y");
	return 0 if ($_ eq "n" || $_ eq "N");
    }
}

sub ask_general {
    my ($txt,$default,$check_exist) = @_;
    while (1) {
	print "$txt";
	if ($default ne "") {
	    print " [$default]: "
	} else {
	    print ": ";
        }
	$_ = <STDIN>;
	chop;
	$_ = $default if ($_ eq "");
	$_ =~ s/^\s*//;
	$_ =~ s/\s*\$//;
	if ($check_exist == 1) {
	    if (!(-e $_)) {
		print "     ERROR: Could not find file, please select a file that exists\n";
		next;
	    }
	}
	return $_;
    }
}

sub format_partitions {
    ## Create the FAT 16 boot partition.
    if ($useloop) {
	create_img();
	return;
    }
    scriptcmd("parted -s $instdev mklabel msdos");
    scriptcmd("parted -s $instdev print");
    scriptcmd("parted -s $instdev mkpart primary fat16 0 $size_of_fat16");
    scriptcmd("fdisk $instdev <<EOF
n
p
2

$size_of_ext2
w
EOF
");
    scriptcmd("parted $instdev set 1 boot on");
}

sub trycmd {
    my ($cmd) = @_;
    if ($use_img) {
	return scriptcmd($cmd);
    }
    print "RUN: $cmd\n";
    if ($do_system) {
	return system($cmd);
    }
    return 0;
}

sub scriptcmd {
    my ($cmd) = @_;
    print "$cmd\n";
    my $output_redirect = " 2>&1";
    if ($cmd =~ /^.*?<<EOF.*/) {
	$cmd =~ s/^(.*?)<<EOF(.*)/$1<<EOF $output_redirect $2/;
    } else {
	$cmd .= $output_redirect;
    }
    if ($do_system) {
	open(RUN, "$cmd|");
	while (<RUN>) {
	    print "#      OUTPUT: $_";
	}
	close(RUN);
	return $?;
    }
    return 0;
}

# Return 1 if the device is good
sub check_dev_good {
    my ($input) = @_;
    if ($input eq "loop") {
	return 1;
    }
    if ($input !~ /^\/dev\/(sd|hd)/) {
	print "   ERROR: Device must must start with /dev/sd or /dev/hd\n";
	return 0;
    }
    if (! (-e $input)) {
	print "   ERROR: $instdev does not exist\n";
	return 0;
    }
    if (!check_dev_dir($input)) {
	print "   ERROR: $instdev is mounted, in an lvm group, or part of a raid\n";
	return 0;
    }
    return 1;
}

# Return 1 if the device is not mounted
sub check_dev_dir {
    my ($dev) = @_;
    my $i;
    for ($i = 0; $i <= $#mounts; $i++) {
	if ($mounts[$i] =~ /^$dev/) {
	    last;
	}
    }
    if ($i > $#mounts) {
	return 1;
    } else {
	return 0;
    }
}

sub make_fs_template {
    my ($dir) = @_;
    my $fs_final_loc = "";
    my $fs_dir = "";
    # Find the readonly_root feature template
    open(F, "$dirspec$layers");
    while(<F>) {
	chop();
	my $dir = "$dirspec$_/templates/feature/readonly_root";
	if (-e "$dirspec$_/data/syslinux/readonly_root") {
	    $dir = "$dirspec$_/data/syslinux/readonly_root";
	}
	if (-e "$dir/fs_final.sh") {
	    $fs_final_loc = `readlink -f $dir/fs_final.sh`;
	    chop($fs_final_loc);
	    $fs_dir = `readlink -f $dir/fs`;
	    chop($fs_dir);
	    last;
	}
    }
    close(F);
    if ($fs_final_loc eq "") {
        # check to see if this is an SDK
        if (-e "export/wr-layer/data/syslinux/readonly_root") {
            $fs_final_loc = `readlink -f export/wr-layer/data/syslinux/readonly_root/fs_final.sh`;
            chop($fs_final_loc);
            $fs_dir = `readlink -f export/wr-layer/data/syslinux/readonly_root/fs`;
            chop($fs_dir);
        }
    }
    if ($fs_final_loc eq "") {
	die "ERROR: Could not locate the readonly rootfs fs_final.sh script";
    }

    if ($readonly) {
	scriptcmd("mkdir -p $dir/etc/initial_setup");
	scriptcmd("cp -f $fs_dir/etc/initial_setup/00read_only_root.sh $dir/etc/initial_setup");
	scriptcmd("cp -f $fs_dir/initial_setup.sh $dir");
	scriptcmd("chmod 755 $dir/etc/initial_setup/00read_only_root.sh $dir/initial_setup.sh");
	scriptcmd("cd $dir && $progroot/scripts/fakestart.sh sh $fs_final_loc");
    } else {
	scriptcmd("cd $dir && ENV_FORCE_RW_USB=force $progroot/scripts/fakestart.sh sh $fs_final_loc");
    }
}

sub ask_usb_device {
    # Collect a list of devices we do not want to mess with:
    @mounts = `mount;cat /proc/mounts`;
    if ($? != 0) {
	die "Could not open /proc/mounts";
    }
    # Also check lvm data to exclude lvm devices
    open(O, "lvm pvs|");
    while ($_ = <O>) {
	chop();
	$_ =~ s/^\s*//;
	if ($_ =~ /^\/dev\//) {
	    push(@mounts, $_);
	}
    }
    close(O);
    # Also check mdadm for devices
    open(O, "mdadm -D -s -v|");
    while($_ = <O>) {
	chop();
	while ($_ =~ /.*(\/dev\/[\w\d]+)/) {
	    my $dev = $1;
	    $_ =~ s/$dev//;
	    push(@mounts, $dev);
	}
    }
    close(O);

    if ($instdev eq "") {
	# Walk through block devices
	print "Detected devices:\n";
	opendir(d, "/sys/block") || die "Could not open /sys/block directory";
	my @dirs = readdir(d);
	close(d);

	sort @dirs;
	while (@dirs) {
	    if ($dirs[0] !~ /^(hd|sd)/) {
		shift @dirs;
		next;
	    }
	    if (check_dev_dir("/dev/$dirs[0]")) {
		print "   /dev/$dirs[0] - possible install candidate\n";
		$instdev = "/dev/$dirs[0]";
	    } else {
		print "   /dev/$dirs[0] - mounted, not an install candidate\n";
	    }
	    shift @dirs;
	}
	while (1) {
	    print "Device to install wrlinux on to [$instdev]: ";
	    my $input = <STDIN>;
	    chop($input);
	    if ($input eq "") {
		$input = $instdev;
	    }
	    $instdev = $input;
	    next if (!check_dev_good($instdev));
	    last;
	}
    } else {
	if (!check_dev_good($instdev)) {
	    exit_error();
	}
    }
}
sub mbr_check {
    if (!(-e $mbr_file)) {
	print "ERROR: Could not locate the mbr.bin file for syslinux\n";
	exit_error();
    }
}

sub compute_top_build_dir {
    ### Compute TOP_BUILD_DIR ###
    my $cwd;
    # In the bitbake world the progroot is the directory above the bitbake_build
    if ($ENV{'BUILDDIR'} ne "") {
	$orig_progroot = $progroot;
	$progroot = "$ENV{'BUILDDIR'}/.." if ($ENV{'BUILDDIR'} ne "");
    } elsif ($progroot !~ /^\//) {
	$cwd = getcwd();
	$progroot = "$cwd/./$progroot";
    }
    while ($progroot =~ /\/\.\//) {
	$progroot =~ s/\/\.\//\//;
    }
    while ($progroot =~ /\/[^\/]*?\/\.\.\//) {
	$progroot =~ s/(\/[^\/]*?\/\.\.\/)/\//;
    }
    $progroot =~ s/^\/\.\.\//\//;
    # chop off the program name
    $progroot =~ s/^(.*)\/.*/$1/;
    # Compute the top name which is roughly ...
    $progroot .= "/../";
    while ($progroot =~ /\/[^\/]*?\/\.\.\//) {
	$progroot =~ s/(\/[^\/]*?\/\.\.\/)/\//;
    }
    # And finally remove the trailing slash
    $progroot =~ s/\/$//;
    $ENV{'TOP_BUILD_DIR'} = $progroot;
}

sub exit_error {
    exit 1;
}

sub shutdown_clean {
    if ($LOOP_DEV ne "") {
	print "ERROR: $0 interrupted\n";
	print "   Force shuting down $LOOP_DEV\n";
	scriptcmd("umount $LOOP_DEV");
	scriptcmd("sync");
	scriptcmd("/sbin/losetup -d $LOOP_DEV");
	exit 1;
    }
    exit 0;
}

sub usage {
    print<<EOF;
Usage: $0
  --usbimg         Write a usb image
  --fileimg        Write a file image to later copy to usb
  --instdev=<DEV>  Location to write the syslinux and rootfs
  --rootfs=<bz2>   Absolute path to *tar.bz2 to use for root file system
  --bzImage=<img>  Kernel boot image to include in fat16 fs
  --fat16-mb=<#MB> Fixed size of fat16 to hold kernel and static initrd
  --ext2-mb=<#MB>  Fixed size of ext2 partition
  --extra-mb=<#MB> Extra megabytes for the file system creation
                   --ext2-mb overrides this
  --convert-extX=# Specify using ext2, ext3 or ext4 where # = 2, 3, or 4
  --format=<y/n>   Format the device Yes or No
  --rw             Mount target file system Read/Write after boot
  --ro             Mount target file system Read-only after boot
  --no-rm          Do not remove temporary files
  --force          Answer y to the warning about possibility to destroy data
  --loop	   Use the loopback device (requires sudo) to write the usb image
  --tarfiles       Use tar files for the root files system [default is contents of export/dist]
                   *** Only works with --usbimg or --loop
EOF
exit 0;
}
