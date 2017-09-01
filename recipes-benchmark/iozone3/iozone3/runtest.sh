#!/bin/sh

TC_PATH=`dirname $0`
TC_SCRIPT=`basename $0`

# Step 1: detect the cpu numbers and prepare the only one cpu to be attached the iozone testing,
#         the future results would be not the best performance, but it's enough to compare the 
#         benchmark with other different linux distro in the single task running on the single cpu.
#         That's to isolate the impact from the system load.

cpu_num=`cat /proc/cpuinfo | grep processor | wc -l`
attached_cpu_num=$(($cpu_num-1))
mem_size=`free -m | grep "buffers/cache"| awk '{print $4}'`
max_size=$(($mem_size * 8))
min_size=$(($mem_size / 20))

# get the linux version and distro info
distro_name=`cat /etc/issue | head -n 1|awk '{print $1 "-" $2}' `
distro_version=`uname -r|head -n 1` 
file_append=`echo $distro_name-$distro_version`

[ -e $TC_PATH/diskdata.list ] && rm $TC_PATH/diskdata.list
# Step 2: detect the physical disk to be perform the testing, etc hard disk, USB, SD card etc;
#         if there is not any io devices or the testing execution on the nfs, then skip the testing.

$TC_PATH/diskdetect.sh
if [ -s $TC_PATH/diskdata.list ]; then
	echo "Find the block device, continue to test!"	
else
	echo "Can not find the block device to be tested."
	exit 1
fi

df / -h| grep '^\([1-2]\?[0-9]\{1,2\}\.\)\{3\}' && exit 1
echo "Root fs was mounted through block device."

# Step 3: make sure the file size to be tested larger than the system memory, unless the 
#         result would not reflect the real io performance, since if the file smaller that
#         smaller than the buffesr+cached size, would be cached in the memory, not really 
#         sync to the hardware. The size of memory as buffers+cached could be read via "free -m",
#         and pass the "mem=xxx" into the boot command line, if the memory was larger than the 
#         size of disk, to limit the memory.

# Please mount a partition with filesystem (bigger than the max_size) on /mnt/

mount | grep "/mnt " | awk '{print $1}'| grep '^\([1-2]\?[0-9]\{1,2\}\.\)\{3\}' || exit 1
echo "Found the io device to be tested."

disk_size=`df /mnt/ -m| tail -n 1|awk '{print $2}'`

if [ $max_size -gt $disk_size ]; then
	echo "Disk is too small."
	exit 1
fi

# Step 4: if all the above environment has been setup correctly, then everything was prepared, just
#         perform the testing on the target, and generate the data which to be saved as xls format.
taskset -c $attached_cpu_num iozone -a -g "$max_size"m -n "$min_size"m -f /mnt/iozone.tmp -Rb ~/iozone_$file_append.xls | tee ~/run-$file_append.log
