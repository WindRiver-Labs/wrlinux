# Copyright (c) 2011 Wind River Systems, Inc.
SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`

all: 
	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done

clean:
	rm -rf process get_memory vul
	@set -e; for i in $(SUBDIRS) ; do $(MAKE) -C $$i clean ; done
	
#install:
#	chmod +x vul get_memory process


