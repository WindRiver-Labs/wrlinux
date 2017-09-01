#!/bin/bash
##Rum LMBench test suite
TEST_ROOT=$(readlink -f `dirname $0`)
source ${TEST_ROOT}/scripts/utility.sh

#getopts
while getopts hbc: arg
do
  case $arg in
	b) LMBENCH_BIN_PATH=$OPTARG;;
	c) full_percent=$OPTARG;;
	h) usage; exit;;
	*) echo "Invalid option: $arg"; usage; exit;;
  esac  
done

#verify the count number
invalid_char=`echo $full_percent | sed 's/[0-9]//g'`
if test X"$invalid_char" != "X"; then
	usage;exit
fi

#if not set the full_percent in the command line, use the default 5
if test X"$full_percent" == "X"; then
	full_percent=5
fi

## root privilege is required to drop memory caches for some cases.
[ "$UID" -ne 0 ] && { echo "Root privilege is required."; exit 1; }

#### ENV setup ####
#Where is lmbench binaries? Default path is /usr/bin
LMBENCH_BIN_PATH=${LMBENCH_BIN_PATH:-/usr/bin}
[ -d "$LMBENCH_BIN_PATH" ] || { echo "No such directory: ${LMBENCH_BIN_PATH}"; usage; exit 1; }
export PATH=${LMBENCH_BIN_PATH}:${PATH}

#Specify directory to save test logs, default is ${TEST_ROOT}/logs/xxx
LOGDIR="${TEST_ROOT}/logs/lmbench-$(date +%Y-%m-%d-%H-%M-%S)"
mkdir -p $LOGDIR || { echo "Error! Can't create log dir: $LOGDIR"; exit 1; }

DATE=$(which date)
## Figure out memory size (in MB size) will be used for testing
#+ Several benchmarks operate on a range of memory.
#+ The bigger the range, the more accurate the results, but larger sizes
#+ take somewhat longer to run the benchmark.
#+ It should be no more than 80% of your physical memory.
#+ prepare_test function will set it to half of the available memory 
#+ (but no more than 512MB) if it is kept empty
MB=""

## We need a place to store a ${MB}m Mbyte file as well as create and delete a
#+ large number of small files.  We default to /usr/tmp.  If /usr/tmp is a
#+ memory resident file system (i.e., tmpfs), pick a different place.
#+ Please specify a directory that has enough space and is a local file
#+ system.
FSDIR=""

##Get system info
get_sysinfo

##Prepare temp files
prepare_test

#############
##Run tests ...
#############

##==fs test cases==
echo "get fs create/delete latency"

echo "10k file size"
done_percent=0
current_percent=0
log_file="$LOGDIR/10k_file_cd"
while :
do
  echo_process
  lat_fs -s 10k 2>&1 | awk '{print 1000000/$3 " " 1000000/$4}' >> $log_file 2>&1
done

echo "100k file size"
done_percent=0
current_percent=0
log_file="$LOGDIR/100k_file_cd"

while :
do
  echo_process
  lat_fs -s 100k 2>&1 | awk '{print 1000000/$3 " " 1000000/$4}' >> $log_file 2>&1;
done

#==Process creation===
echo "Process creation (us)"

echo "Process fork+exit"
done_percent=0
current_percent=0
log_file="$LOGDIR/proc_fork_latency"

while :
do
  echo_process
  lat_proc fork >> $log_file 2>&1
done

echo "fork+execve"
done_percent=0
current_percent=0
log_file="$LOGDIR/proc_exec_latency"


while :
do
  echo_process
  lat_proc exec >> $log_file 2>&1
done

echo "fork+/bin/sh" 
done_percent=0
current_percent=0
log_file="$LOGDIR/proc_shell_latency"


while :
do
  echo_process
  lat_proc shell >> $log_file 2>&1
done


##==pipe/unix latency/bandwidth==

## Pipe latency
echo "Pipe latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/pipe_latency"

while :
do
  echo_process
  lat_pipe >> $log_file 2>&1
done

## AF_UNIX latency
echo "AF_UNIX sock stream latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/unix_sock_latency"

while :
do
  echo_process
  lat_unix >> $log_file 2>&1
done


## Pipe Bandwidth
echo "Bandwidth pipe -P 1 -M 100m"
done_percent=0
current_percent=0
log_file="$LOGDIR/pipe_bandwidth"

while :
do
  echo_process
  bw_pipe -P 1 -M 100m >> $log_file 2>&1
done

echo "Bandwidth unix -P 1 -M 100m"
done_percent=0
current_percent=0
log_file="$LOGDIR/unix_bandwidth"

while :
do
  echo_process
  bw_unix -P 1 -M 100m >> $log_file 2>&1
done

#==context switch test==
echo "ctx latency -P 1 -s 64k 8"
done_percent=0
current_percent=0
log_file="$LOGDIR/ctx_latency"

while :
do
  echo_process
  lat_ctx -P 1 -s 64k 8 >> $log_file 2>&1
done

#==signal tests==
echo "singnal handler "
SYNC_MAX=1
log_file="$LOGDIR/sig_hand_latency"

#case 1 of 3
echo "signal install"
done_percent=0
current_percent=0

while :
do
  echo_process
  lat_sig -P $SYNC_MAX install >> $log_file  2>&1
done

#case 2 of 3
echo "signal catch"
done_percent=0
current_percent=0

while :
do
  echo_process
  lat_sig  -P $SYNC_MAX catch >> $log_file 2>&1
done

#case 3 of 3
echo "protection fault"
done_percent=0
current_percent=0

while :
do
  echo_process
  lat_sig -P $SYNC_MAX prot ${LMBENCH_BIN_PATH}/lat_sig >> $log_file 2>&1
done

#==syscall tests==
echo "System call overhead"
SYNC_MAX=1
log_file="$LOGDIR/syscall_overhead"

#case 1 of 6
echo "syscall: null"
done_percent=0
current_percent=0

while :
do
  echo_process
  lat_syscall -P $SYNC_MAX null >> $log_file 2>&1
done

#case 2 of 6
echo "syscall: read"
done_percent=0
current_percent=0
while :
do
  echo_process
  lat_syscall -P $SYNC_MAX read >> $log_file 2>&1
done


#case 3 of 6
echo "syscall: write"
done_percent=0
current_percent=0
while :
do
  echo_process
  lat_syscall -P $SYNC_MAX write >> $log_file 2>&1
done

#case 4 of 6
echo "syscall: stat"
done_percent=0
current_percent=0
while :
do
  echo_process
  lat_syscall -P $SYNC_MAX stat $STAT >> $log_file 2>&1
done

#case 5 of 6
echo "syscall: fstat"
done_percent=0
current_percent=0
while :
do
  echo_process
  lat_syscall -P $SYNC_MAX fstat $STAT >> $log_file 2>&1
done

#case 6 of 6
echo "syscall: open/close"
done_percent=0
current_percent=0
while :
do
  echo_process
  lat_syscall -P $SYNC_MAX open $STAT >> $log_file 2>&1
done

##==select latency
echo "select latency"
SYNC_MAX=1
FDS=100

#case 1 of 2
echo "select: file"
done_percent=0
current_percent=0
log_file="$LOGDIR/select_file_latency"
while :
do
  echo_process
  lat_select -n $FDS -P $SYNC_MAX file >> $log_file 2>&1
done

#case 2 of 2
echo "select: tcp"
done_percent=0
current_percent=0
log_file="$LOGDIR/select_tcp_latency"
while :
do
  echo_process
  lat_select -n $FDS -P $SYNC_MAX tcp >> $log_file 2>&1
done


##==tcp/udp tests==
echo "tcp bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/tcp_bandwidth"

bw_tcp -s
while :
do
  echo_process
  bw_tcp -m 10m localhost >> $log_file 2>&1
done
bw_tcp -S localhost

echo "tcp latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/tcp_latency"

lat_tcp -s
while :
do
  echo_process
  lat_tcp -m 10k localhost >> $log_file 2>&1
done
lat_tcp -S localhost

echo "udp latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/udp_latency"

lat_udp -s
while :
do
  echo_process
  lat_udp -m 10k localhost >> $log_file 2>&1
done
lat_udp -S localhost

echo "tcp connection latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/tcp_connect_latency"

while :
do
  echo_process
  lat_connect -s
  lat_connect localhost >> $log_file 2>&1
  lat_connect -S localhost
  [ $? -ne 0 ] && {
    sleep 60
    current_percent=$(($current_percent - 1))
    lat_connect -S localhost
  }
done

echo "rpc latency"
SYNC_MAX=1
done_percent=0
current_percent=0
log_file="$LOGDIR/rpc_latency"

lat_rpc -s
while :
do
  echo_process
  lat_rpc -P $SYNC_MAX -p udp localhost >> $log_file 2>&1
  lat_rpc -P $SYNC_MAX -p tcp localhost >> $log_file 2>&1
done
lat_rpc -S localhost

##== Arithmetic latency ==
##i.e. bit add mul div mod ...
echo "Arithmetic operations latency"
#case 1 of 2
echo "ops latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/ops_latency"

while :
do
  echo_process
  lat_ops >> $log_file 2>&1
done

#case 2 of 2
#echo "parallel ops latency"
#full_percent=20
#done_percent=0
#current_percent=0
#log_file="$LOGDIR/par_ops_latency"

#while :
#do
#  echo_process
#  par_ops >> $log_file 2>&1
#done

##== Pagefaults latency ==
echo "Pagefaults latency"
SYNC_MAX=1
done_percent=0
current_percent=0
log_file="$LOGDIR/pagefaults_latency"

while :
do
  echo_process
  lat_pagefault -P $SYNC_MAX $FILE >> $log_file 2>&1
  drop_caches
done

##==Memory related test cases==
echo "bcopy libc"
SYNC_MAX=1
HALF=`expr $MB / 2`
done_percent=0
current_percent=0
log_file="$LOGDIR/memory_bcopy_bandwidth"

while :
do
  echo_process
  bw_mem -P $SYNC_MAX ${HALF}m bcopy >> $log_file 2>&1
done

echo "Mmap latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/mmap_latency"

while :
do
  echo_process
  lat_mmap -P $SYNC_MAX ${MB}m $FILE >> $log_file 2>&1
  drop_caches
done

echo "Mmap read bandwidth" 
done_percent=0
current_percent=0
log_file="$LOGDIR/mmap_read_bandwidth"

while :
do
  echo_process
  bw_mmap_rd -P $SYNC_MAX ${FILE_SIZE}m mmap_only $FILE >> $log_file 2>&1
  drop_caches
done

echo "Mmap read open2close bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/mmap_open2close_bandwidth"

while :
do
  echo_process
  bw_mmap_rd -P $SYNC_MAX ${FILE_SIZE}m open2close $FILE >> $log_file 2>&1
  drop_caches
done

echo "Memory read bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/memory_read_bandwidth"

while :
do
  echo_process
  bw_mem -P $SYNC_MAX ${MB}m frd >> $log_file 2>&1
done

echo "Memory write bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/memory_write_bandwidth"

while :
do
  echo_process
  bw_mem -P $SYNC_MAX ${MB}m fwr >> $log_file 2>&1
done

echo "Memory load latency"
done_percent=0
current_percent=0
log_file="$LOGDIR/memory_load_latency"


while :
do
  echo_process
  lat_mem_rd -P $SYNC_MAX ${MB}m 128 >> $log_file 2>&1
done

##== File bandwidth==
echo "File read bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/file_read_bandwidth"

while :
do
  echo_process
  bw_file_rd -P $SYNC_MAX ${FILE_SIZE}m io_only $FILE >> $log_file 2>&1
  drop_caches
done

echo "File read open2close bandwidth"
done_percent=0
current_percent=0
log_file="$LOGDIR/file_open2close_bandwidth"

while :
do
  echo_process
  bw_file_rd -P $SYNC_MAX ${FILE_SIZE}m open2close $FILE >> $log_file 2>&1
  drop_caches
done

##Test end
##Clean up
clean_up

