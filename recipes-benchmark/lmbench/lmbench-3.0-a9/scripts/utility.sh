##
##usage
usage()
{
cat <<-EOF
USAGE:
  The script used for lmbench performance test, in which 
  each test case will be run for multiple samples.

  Root privilege is required to run the script.

Options:
  -b LMBENCH_BIN_PATH	path to lmbench binaries
  -c LOOP_COUNT 	loop count for each subcases
  -h			print help info

[Extra setup]
+ To change sample amount of each test case,
+ set varable for each test:
 full_percent=samples_for_one_test
+ Notes: 
+ It takes about 1.5 hours to run all tests
+ with default settings on Nehalem target, which
+ has 24 cpu cores(2.53GHz each core) and 6GB memory.
+ Please reset sample amounts according to the cpu 
+ and memory info of the target for testing.

EOF
}

##echo test process
echo_process()
{
  number=`expr $current_percent - $done_percent`
  done_percent=$current_percent
  while [ $number -gt 0 ]
  do
      echo -n "."
      number=`expr $number - 1`
  done
  [ $current_percent -eq 0 ] && { $DATE; }
  [ $done_percent -ge $full_percent ] && { echo; echo "Task is over!"; $DATE; echo; break; }
  let current_percent=$current_percent+1
  msleep 250
}

##Clean up cached data in memory
drop_caches()
{
  sync
  sleep 1
  echo 3 > /proc/sys/vm/drop_caches
  sleep 1
}

##Save system info: cpu, memory, kernel, glibc, gcc
get_sysinfo()
{
  if [ -r /proc/cpuinfo ]; then
    cat /proc/cpuinfo > $LOGDIR/cpu.sysinfo
  fi
  
  if [ -r /proc/meminfo ]; then
    cat /proc/meminfo > $LOGDIR/mem.sysinfo
  fi
 
  if [ -r /etc/issue ]; then
    cat /etc/issue | sed 's/\\.//g'> $LOGDIR/os.sysinfo
  fi

  if which gcc &> /dev/null; then
    gcc --version &> $LOGDIR/gcc.sysinfo
  fi

  if [ -r /proc/version ]; then
    cat /proc/version > $LOGDIR/version.sysinfo
  fi
  
  if which getconf &> /dev/null; then
    getconf -a | grep LIBC_VERSION > $LOGDIR/libc.sysinfo
  fi
  
  if which uname &> /dev/null; then
    uname -r > $LOGDIR/kernel.sysinfo
    uname -m > $LOGDIR/machine.sysinfo
  fi
  
  if which lspci &> /dev/null; then
     lspci | grep -i eth > $LOGDIR/eth.sysinfo
  fi
}

##Prepare files requried in tests
prepare_test()
{
  #Probing system for available memory (within 1024MB range)
  if [ X"$MB" = X ]; then
   TMP=`memsize 1024 2>/dev/null`
   MB=$(expr $TMP / 2)  
  fi

  if [ $MB -lt 8 ]; then
    echo $0 aborted: Not enough memory, only ${MB}MB available. 
    exit 1
  fi

  if [ $MB -lt 16 ]; then
    echo Warning: you have only ${MB}MB available memory. 
    echo Some benchmark results will be less meaningful. 
  fi

  echo "Memory size will be used for testing: $MB MB"

  #create $FILE
  echo "Generate temp file ..."
  if [ X"$FSDIR" = X ]; then
    FSDIR="/usr/tmp/"
    mkdir -p $FSDIR 2>/dev/null || { echo "Failed to create FSDIR"; exit 1; }
  fi

  FILE="$FSDIR/XXX"
  FILE_SIZE="$MB" 
  rm -rf $FILE && touch $FILE
  lmdd label="File $FILE write bandwidth: " of=$FILE move=${FILE_SIZE}m fsync=1 print=3 2>&1

  #copy hello to /tmp
  if [ ! -f "/tmp/hello" ]; then
     cp $LMBENCH_BIN_PATH/hello /tmp
  fi
  echo

  STAT=$FSDIR/lmbench
  rm -f $STAT && touch $STAT
}

##Delete tempfile
clean_up()
{
  rm -rf $FSDIR /tmp/hello
}

