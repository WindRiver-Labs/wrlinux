# Copyright (c) 2011 Wind River Systems, Inc.
all: gen_coredump mthread backtrace memtrace

gen_coredump: gen_coredump.c
	$(CC) -o gen_coredump -static gen_coredump.c

mthread: mthread.c
	$(CC) $(CFLAGS) $(LDFLAGS) -g -o  mthread  mthread.c -lpthread

backtrace: backtrace_01.c
	$(CC) $(CFLAGS) $(LDFLAGS) -g -o  backtrace  backtrace_01.c

memtrace: memtrace_01.c
	$(CC) $(CFLAGS) $(LDFLAGS) -g -o  memtrace  memtrace_01.c

clean:
	rm -f gen_coredump mthread memtrace backtrace


