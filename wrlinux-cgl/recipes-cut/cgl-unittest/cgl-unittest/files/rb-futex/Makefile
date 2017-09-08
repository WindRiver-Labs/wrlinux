SUBDIRS = `ls */Makefile | sed "s/Makefile//g" ` 

all:
	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
clean:
	@set -e; for i in $(SUBDIRS) ; do $(MAKE) -C $$i clean ; done
install:
#	@set -e; for i in $(SUBDIRS) ; do $(MAKE) -C $$i install ; done

	
