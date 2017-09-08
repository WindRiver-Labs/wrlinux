
#CC=g++
SRCS=$(wildcard *.c)
TARGETS=$(patsubst %.c,%,$(SRCS))
LDFLAGS+=-lpthread

all:$(TARGETS)

clean:
	rm -rf $(TARGETS)
