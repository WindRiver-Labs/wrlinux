#!/bin/bash
## Process test lmbench logs to save result for each case in seperate log.

: ${1:?"Uage: `basename $0` original_log_directory [new_dir_to_save_dealt_logs]"}
orig_log_dir=$(readlink -f $1)
[ ! -d "$orig_log_dir" ] && { echo "No such directory: $orig_log_dir"; exit 1; }

dealt_log_dir=${2:-"${orig_log_dir}/dealt_logs"}
rm -rf ${dealt_log_dir} && mkdir -p ${dealt_log_dir} || { echo "Failed to create directory: $dealt_log_dir"; exit 1; }
dealt_log_dir=$(readlink -f $dealt_log_dir)

unknown_test_logs=""

pushd $dealt_log_dir &> /dev/null || { echo "Can't enter dir: $dealt_log_dir"; exit 1; }
#Step 1: get test env info
touch test_env
env_log="$orig_log_dir/machine.sysinfo"
if [ -r "$env_log" ]; then
  machine_info=$(cat $env_log)
  echo "MACHINE_INFO=\"$machine_info\"" >> test_env
fi

env_log="$orig_log_dir/cpu.sysinfo"
if [ -r "$env_log" ]; then
  case "$machine_info" in
  i*86|x86_64)
    cpu_name=$(cat $env_log | grep "model name" | awk -F ":" '{print $2}' | sed 's/[ \t]//g' | uniq)
    cpu_amount=$(cat $env_log | grep "processor" | wc -l)
    ;;
  mips*)
    cpu_name=$(cat $env_log | grep "cpu model" | awk -F ":" '{print $2}' | sed 's/[ \t]//g' | uniq)
    cpu_amount=$(cat $env_log | grep "processor" | wc -l)
    ;;
  ppc*)
    cpu_name=$(cat $env_log | awk -F":" '{if($1~/^cpu[ \t]*$/) print $2}' | sed 's/[ \t]//g')
    cpu_amount=$(cat $env_log | grep "processor" | wc -l)
    ;;
  arm*)
    cpu_name=$(cat $env_log | grep "Processor" | awk -F ":" '{print $2}' | sed 's/[ \t]//g' | uniq)
    cpu_amount=$(cat $env_log | grep "Processor" | wc -l)
    ;;
  esac

  [ -z "$cpu_name" ] && cpu_name="unknown"
  [ -z "$cpu_amount" ] && cpu_amount=0
  if [ $cpu_amount -le 1 ]; then
    suffix="core"
  else
    suffix="cores"
  fi
  echo "CPU_INFO=\"$cpu_name ($cpu_amount $suffix)\"" >> test_env
fi

env_log="$orig_log_dir/mem.sysinfo"
if [ -r "$env_log" ]; then
  memory_KB=$(cat $env_log | grep "MemTotal" | awk '{print $2}')
  memory_MB=$((memory_KB / 1024))
  echo "MEM_INFO=\"$memory_MB MB\"" >> test_env
fi

env_log="$orig_log_dir/os.sysinfo"
if [ -r "$env_log" ]; then
  os_issue=$(cat $env_log | grep -v ^$ | head -n 1)
  echo "OS_INFO=\"$os_issue\"" >> test_env
fi

env_log="$orig_log_dir/kernel.sysinfo"
if [ -r "$env_log" ]; then
  kernel_info=$(cat $env_log)
  echo "KERNEL_INFO=\"$kernel_info\"" >> test_env
fi

env_log="$orig_log_dir/libc.sysinfo"
if [ -r "$env_log" ]; then
  libc_info=$(cat $env_log | awk '{$1=""; print $0}' | sed 's/[ \t]//g')
  echo "GLIBC_INFO=\"$libc_info\"" >> test_env
fi

env_log="$orig_log_dir/gcc.sysinfo"
if [ -r "$env_log" ]; then
  compiler_info=$(cat $env_log | head -n 1)
  echo "COMPILER_INFO=\"$compiler_info\"" >> test_env
elif [ -r $orig_log_dir/version.sysinfo ]; then
  gcc_ver=$(cat $orig_log_dir/version.sysinfo | awk '{for(i=i;i<NF;i++) {if($i~/gcc/ && $(i+1)~/version/) {print $(i+2)} } }')
  echo "COMPILER_INFO=\"gcc version $gcc_ver\"" >> test_env
fi

env_log="$orig_log_dir/eth.sysinfo"
if [ -r "$env_log" ]; then
  eth_info=$(cat $env_log | sed 's/.*Ethernet controller:/|/g')
  [ -n "$eth_info" ] && eth_info=$(echo $eth_info | sed 's/|[ \t]*/|/g' | sed 's/[\n\r]//g' | sed 's/$/|/g')
  echo "NET_INFO=\"$eth_info\"" >> test_env
fi

#Step 2: process test result for each case
log_amount=0
for i in `ls ${orig_log_dir} | grep -v sysinfo`; do
  log="${orig_log_dir}/${i}"
  [ -d "$log" ] && continue
  ((log_amount++))

  case $i in 
	bw_memory_bcopy|memory_bcopy_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > memory_bcopy_bandwidth.log
		;;
	bw_pipe|pipe_bandwidth)
		cat $log | awk '{print $3 "   " $4}'  > pipe_bandwidth.log
 		;;
	bw_tcp|tcp_bandwidth)
		cat $log | awk '{print $2 "   " $3}' > tcp_bandwidth.log
		;;
	bw_unix|unix_bandwidth)
		cat $log | awk '{print $5 "   " $6}' > unix_bandwidth.log
		;;
	ctx_latency)
		cat $log | sed -n '/^8/p' | awk '{print $2 "   us"}' > ctx_latency.log
		;;
	file_open2close_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > file_open2close_bandwidth.log
		;;
	file_read_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > file_read_bandwidth.log
		;;
	10k_file_cd)
		cat $log | awk '{print $1 "   us"}' > 10K_file_create_latency.log
		cat $log | awk '{print $2 "   us"}' > 10K_file_delete_latency.log
		;;
	100k_file_cd)
		cat $log | awk '{print $1 "   us"}' > 100K_file_create_latency.log
		cat $log | awk '{print $2 "   us"}' > 100K_file_delete_latency.log
		;;
	memory_load_latency)
		cat $log | sed -n '/^512/p' | awk '{print $2 "   us"}' > memory_load_latency.log
		;;
	memory_read_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > memory_read_bandwidth.log
		;;
	memory_write_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > memory_write_bandwidth.log
		;; 
	mmap_latency)
		cat $log | awk '{print $2 "   us"}' > mmap_latency.log
		;;	
		
	mmap_open2close_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > mmap_open2close_bandwidth.log
		;;
	mmap_read_bandwidth)
		cat $log | awk '{print $2 "   MB/sec"}' > mmap_read_bandwidth.log
		;;
	ops_latency)
		cat $log | sed -n '/^integer add/p' | awk '{print $3 "   ns"}'  > integer_add.log
		cat $log | sed -n '/^integer bit/p' | awk '{print $3 "   ns"}' > integer_bit.log	
		cat $log | sed -n '/^integer mul/p' | awk '{print $3 "   ns"}' > integer_mul.log
		cat $log | sed -n '/^integer div/p' | awk '{print $3 "   ns"}' > integer_div.log
		cat $log | sed -n '/^integer mod/p' | awk '{print $3 "   ns"}' > integer_mod.log
		cat $log | sed -n '/^int64 bit/p' | awk '{print $3 "   ns"}' > int64_bit.log
		cat $log | sed -n '/^uint64 add/p' | awk '{print $3 "   ns"}' > uint64_add.log
		cat $log | sed -n '/^int64 mul/p' | awk '{print $3 "   ns"}' > int64_mul.log
		cat $log | sed -n '/^int64 div/p' | awk '{print $3 "   ns"}' > int64_div.log
		cat $log | sed -n '/^int64 mod/p' | awk '{print $3 "   ns"}' > int64_mod.log
		cat $log | sed -n '/^float add/p' | awk '{print $3 "   ns"}' > float_add.log
                cat $log | sed -n '/^float mul/p' | awk '{print $3 "   ns"}' > float_mul.log
                cat $log | sed -n '/^float div/p' | awk '{print $3 "   ns"}' > float_div.log
		cat $log | sed -n '/^double add/p'| awk '{print $3 "   ns"}' > double_add.log
                cat $log | sed -n '/^double mul/p'| awk '{print $3 "   ns"}' > double_mul.log
                cat $log | sed -n '/^double div/p'| awk '{print $3 "   ns"}' > double_div.log
		cat $log | sed -n '/^double bogomflops/p'| awk '{print $3 "   ns"}' > double_bogomflops.log
		cat $log | sed -n '/^float bogomflops/p'| awk '{print $3 "   ns"}' > float_bogomflops.log
		;;
	pagefaults_latency)
		cat $log | awk '{print $4 "   us"}' > pagefaults_latency.log
		;;
	par_ops_latency)
		cat $log | sed -n '/^integer add/p' | awk '{print $4 "   ns"}'  > integer_add_par.log
		cat $log | sed -n '/^integer bit/p' | awk '{print $4 "   ns"}'  > integer_bit_par.log
		cat $log | sed -n '/^integer div/p' | awk '{print $4 "   ns"}'  > integer_div_par.log
		cat $log | sed -n '/^integer mul/p' | awk '{print $4 "   ns"}'  > integer_mul_par.log
		cat $log | sed -n '/^integer mod/p' | awk '{print $4 "   ns"}'  > integer_mod_par.log

		cat $log | sed -n '/^int64 add/p' | awk '{print $4 "   ns"}'  > int64_add_par.log
                cat $log | sed -n '/^int64 bit/p' | awk '{print $4 "   ns"}'  > int64_bit_par.log
                cat $log | sed -n '/^int64 div/p' | awk '{print $4 "   ns"}'  > int64_div_par.log
                cat $log | sed -n '/^int64 mul/p' | awk '{print $4 "   ns"}'  > int64_mul_par.log
                cat $log | sed -n '/^int64 mod/p' | awk '{print $4 "   ns"}'  > int64_mod_par.log
		    	
		cat $log | sed -n '/^float add/p' | awk '{print $4 "   ns"}'  > float_add_par.log
		cat $log | sed -n '/^float div/p' | awk '{print $4 "   ns"}'  > float_div_par.log
                cat $log | sed -n '/^float mul/p' | awk '{print $4 "   ns"}'  > float_mul_par.log

		cat $log | sed -n '/^double add/p' | awk '{print $4 "   ns"}'  > double_add_par.log
                cat $log | sed -n '/^double div/p' | awk '{print $4 "   ns"}'  > double_div_par.log
                cat $log | sed -n '/^double mul/p' | awk '{print $4 "   ns"}'  > double_mul_par.log
		;;

	pipe_latency)
		cat $log | awk '{print $3 "   us"}' > pipe_latency.log
		;;
	proc_exec_latency)
		cat $log | awk '{print $3 "   us"}' > proc_exec_latency.log
		;;
	proc_fork_latency)
		cat $log | awk '{print $3 "   us"}' > proc_fork_latency.log
		;;
	proc_shell_latency)
		cat $log | awk '{print $4 "   us"}' > proc_shell_latency.log
		;;
	rpc_latency)
		cat $log | sed -n '/tcp/p' | awk '{print $5 "   us"}' > rpc_latency_tcp.log
		cat $log | sed -n '/udp/p' | awk '{print $5 "   us"}' > rpc_latency_udp.log
		;;
	select_file_latency)
		cat $log | awk '{print $5 "   us"}' > select_file_latency.log
		;;
	select_tcp_latency)
		cat $log | awk '{print $6 "   us"}' > select_tcp_latency.log
		;;
	sig_hand_latency)
		cat $log | sed -n '/installation/p' | awk '{print $4 "   us"}' > sig_installation.log
		cat $log | sed -n '/overhead/p' | awk '{print $4 "   us"}' > sig_catch.log
		cat $log | sed -n '/Protection/p' | awk '{print $3 "   us"}' > sig_protection_fault.log
		;;
	syscall_overhead)
		cat $log | sed -n '/syscall/p' | awk '{print $3 "   us"}' > syscall_overhead_null.log
		cat $log | sed -n '/read/p' | awk '{print $3 "   us"}' > syscall_overhead_read.log
		cat $log | sed -n '/write/p' | awk '{print $3 "   us"}' > syscall_overhead_write.log
		cat $log | sed -n '/Simple stat:/p' | awk '{print $3 "   us"}' > syscall_overhead_stat.log
		cat $log | sed -n '/fstat:/p' | awk '{print $3 "   us"}' > syscall_overhead_fstat.log 
		cat $log | sed -n '/open/p' | awk '{print $3 "   us"}' > syscall_overhead_open_close.log
		;;
	tcp_connect_latency)
		cat $log | sed -n '/connection/p' |awk '{print $6 "   us"}' > tcp_connect_latency.log
		;;
	tcp_latency)
		cat $log | awk '{print $5 "   us"}' > tcp_latency.log
		;;
	udp_latency)
		cat $log | awk '{print $5 "   us"}' > udp_latency.log
		;;
	unix_sock_latency)
		cat $log | awk '{print $5 "   us"}' > unix_sock_latency.log
		;;	
        *) unknown_test_logs="$unknown_test_logs $i"
                ;;
  esac
done

if [ X"$unknown_test_logs" != X ]; then
  echo "Unknown test results, please check ..." 
  echo "  $unknown_test_logs"
elif [ "$log_amount" -lt 1 ]; then
  echo "No test log is found."
else
  touch DEALT
  echo "Test results can be uploaded: "
  echo "$dealt_log_dir"
fi
popd &> /dev/null #exit from $dealt_log_dir

exit 0
