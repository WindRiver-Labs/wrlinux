##public variable
XML_FILE=""
THE_BIGGER_THE_BETTER=1
THE_SMALLER_THE_BETTER=0

##usage
usage()
{
cat <<-EOF
Usage: `basename $0` <-c TEST_RUN_CONFIG> <-d TEST_LOG_DIR> [OPTION]...
  Process test logs and upload test results to database server

Options:
  -c TEST_RUN_CONFIG      test run config file
  -d TEST_LOG_DIR	  test logs directory
  -p project_name	  project name, such as "WRLinux Robin"/"WRLinux Penguin"
  -s BENCHMARK_DB_SERVER  benchark database server, default is 128.224.163.19/benchmark/upload.php
  -h                      print help
EOF
}

##check test env
check_test_env()
{
  unknown_info=0
  CPU_INFO=${CPU_INFO:-unknown}
  [ "$CPU_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "CPU_INFO: $CPU_INFO"

  MEM_INFO=${MEM_INFO:-unknown}
  [ "$MEM_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "MEM_INFO: $MEM_INFO"

  OS_INFO=${OS_INFO:-unknown}
  [ "$OS_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "OS_INFO: $OS_INFO"

  KERNEL_INFO=${KERNEL_INFO:-unknown}
  [ "$KERNEL_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "KERNEL_INFO: $KERNEL_INFO"

  GLIBC_INFO=${GLIBC_INFO:-unknown}
  [ "$GLIBC_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "GLIBC_INFO: $GLIBC_INFO"

  NET_INFO=${NET_INFO:-unknown}
  [ "$NET_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "NET_INFO: $NET_INFO"

  MACHINE_INFO=${MACHINE_INFO:-unknown}
  [ "$MACHINE_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "MACHINE_INFO: $MACHINE_INFO"

  COMPILER_INFO=${COMPILER_INFO:-unknown}
  [ "$COMPILER_INFO" = unknown ] && unknown_info=$((unknown_info + 1))
  echo "COMPILER_INFO: $COMPILER_INFO"

  if [ $unknown_info -gt 3 ]; then
    return 1
  else
    return 0
  fi
}

##Create xml file for each test case
#f_create_xml "$item" "$item_id" "$group" "$group_id" "$UNIT" "$better" "$data"
#
f_create_xml()
{
	echo '<?xml version="1.0" encoding="UTF-8"?>' >$XML_FILE
	echo '<benchmark>' >>$XML_FILE
	echo  "\t<case_name>$case_name</case_name>" >>$XML_FILE
	echo  "\t<board>$board</board>" >>$XML_FILE
	echo  "\t<os>$test_id</os>" >>$XML_FILE
	echo  "\t<cpu_info>$CPU_INFO</cpu_info>" >>$XML_FILE
	echo  "\t<mem_info>$MEM_INFO</mem_info>" >>$XML_FILE
	echo  "\t<os_info>$OS_INFO</os_info>" >>$XML_FILE
	echo  "\t<kernel_info>$KERNEL_INFO</kernel_info>" >>$XML_FILE
	echo  "\t<glibc_info>$GLIBC_INFO</glibc_info>" >>$XML_FILE
	echo  "\t<net_info>$NET_INFO</net_info>" >>$XML_FILE
	echo  "\t<arch>$MACHINE_INFO</arch>" >>$XML_FILE
	echo  "\t<compiler>$COMPILER_INFO</compiler>" >>$XML_FILE
	echo  "\t<item>$1</item>" >>$XML_FILE
	echo  "\t<item_id>$2</item_id>" >>$XML_FILE
	echo  "\t<group>$3</group>" >>$XML_FILE
	echo  "\t<group_id>$4</group_id>" >>$XML_FILE
	echo  "\t<unit>$5</unit>" >>$XML_FILE
	echo  "\t<better>$6</better>" >>$XML_FILE
	echo  "\t<data>$7</data>" >>$XML_FILE
	
	echo "</benchmark>" >>$XML_FILE

}
