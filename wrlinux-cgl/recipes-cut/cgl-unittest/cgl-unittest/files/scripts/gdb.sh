#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :  SFA.2.3 SFA.2.4 GDB basic test
#
#developer : Yongli He  <yongli.he@windriver.com>
#
# changelog
# *
# -

TOPDIR=${CUTDIR-/opt/cut/}
LOGFILE=${CUT_LOGFILE-/opt/cut/testlog}

. $TOPDIR/function.sh

clean()
{
   echo "exit SFA.2.3 SFA.2.4 GDB basic test "
}

#check if gdb is installed 
msg=$(whereis gdb | grep "/usr/bin/gdb")
if [ ! "$msg" ]
then 
   echo "****************************************"
   echo "The required utility /usr/bin/gdb is"
   echo "not installed.  Please locate and install"
   echo "it manually and restart test."
   echo "****************************************"
   cutfail
fi


# ensure the gen-coredump package is loaded
rpm -q gen-coredump
if [ ! $? = 0 ]
then
   echo "****************************************"
   echo "The required package gen-coredump is"
   echo "not installed."
   echo "****************************************"
   cutfail
fi


# ensure the mthread binary isn't stripped
msg=$(file `find /opt/ -name mthread` | grep "not stripped")
if [ ! "$msg" ]
then
   cuterr "*******please rebuild the gen-coredump pakages like this:make gen-coredump_BUILD_TYPE = DEBUG gen-coredump "
fi


gdb_thread_test()
{
expect <<- END

set timeout 7
set pid 0

spawn gdb $1
set pid $spawn_id

# set break point
expect {
	eof		{exit 1}
	"(gdb)"		{send "break alone\r" }
	timeout		{send_tty "##GDB## failed to start gdb\r\n" ; exit 2}
	}

expect {
	eof	{exit 1}
	"Breakpoint 1 at "	{ }
	"Make breakpoint pending on future "	{ send "y\r" }
	timeout		{ send_tty "##GDB## failed to set breakpoint in gdb\r\n" ; exit 3 }
	}


# start program
expect {
	eof		{exit 1}
	"(gdb)"		{ send "run\r" }
	timeout  { send_tty "##GDB## set breakpoint timed out\r\n" ; exit 4 }
	}

expect	{
	eof  {exit 1}
	"*alone (* at *mthread.c"	 {}
	"*Unable to find libthread_db matching*"  { send_tty " glibc-debuginfo not installed, please install it.\r\n" ; exit 11 }
	timeout { send_tty "##GDB## timeout waiting for breakpoint\r\n"; exit 5 }
	}


#check info thread
expect	{
	eof  { exit 1 } 
	"(gdb)" 	{ send "info thread\r" }
	timeout {  send_tty "##GDB## timeout waiting for gdb after breakpoint\r\n" ; exit 6 }
	}

expect	{
	eof  { exit 1 }
	"Thread*mthread*alone" 	{ }
	timeout { send_tty "##GDB## timeout waiting for thread info\r\n" ; exit 6 }
	}


# switch to thread 1
expect  {
	eof  { exit 1 }
	"(gdb)" 	{  send "thread 1\r"}
	timeout { send_tty "##GDB## timeout waiting for gdb after info thread\r\n" ; exit 7 }
	}

expect  {
	eof  { exit 1 }
	"Switching to thread 1 (" 	{}
	timeout { send_tty "##GDB## failed to switch thread\r\n" ; exit 7 }
	}


#quit gdb
expect  {
	eof  { exit 1 }
	"(gdb)" 	{  send "q\r"}
	timeout { send_tty "##GDB## timeout waiting for gdb after thread switch\r\n" ; exit 7 }
	}

expect	{
	eof  {exit 1}
	"The program is running." 	{ send "y\r" }
	"Quit anyway?"		{ send "y\r" }
	timeout { exit 0 }
	}

expect eof
exit 0


END
}

gdb_thread_test $TOPDIR/bin/mthread
ret=$?
echo "error code:$ret"
case $ret in
   0 )
   cutpass
   ;;
   1 )
   cuterr "test unexpectedly failed"
   ;;
   * )
   echo "****************************************"
   echo "Failure occured in gdb test"
   echo "----------------------------------------"
   grep "##GDB##" $LOGFILE
   echo "****************************************"
   cutfail
esac
