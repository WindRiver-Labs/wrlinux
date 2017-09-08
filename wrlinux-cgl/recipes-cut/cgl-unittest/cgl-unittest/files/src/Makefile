# Copyright (c) 2011 Wind River Systems, Inc.
all: process get_memory vul file_test

vul: vul.c
	$(CC) -o vul -fstack-protector-all -static vul.c
process: process.c
	$(CC) -o process -static process.c
get_memory: get_memory.c
	$(CC) -o get_memory -static get_memory.c
file_test: file_test.c
	$(CC) -o file_test -static file_test.c

clean:
	rm -rf process get_memory vul file_test

	
