# Makefile for "penguin" 

PROJ_DIR=$(shell pwd)
CFLAGS?=-c

AINCLUDES= 

CINCLUDES= 

CPINCLUDES= 

LINCLUDES= 

LDINCLUDES= 

SOURCES=source/b_main.cpp source/b_grid.cpp 

OBJECTS=$(SOURCES:.c=.o)

penguin=penguin

all : 
	@echo "make: build targets of `pwd`"
	$(CXX) $(CFLAGS) $(CPINCLUDES) -c -o source/b_main.o   source/b_main.cpp
	$(CXX) $(CFLAGS) $(CPINCLUDES) -c -o source/b_grid.o   source/b_grid.cpp
	$(CXX) $(LDFLAGS) $(LDINCLUDES) -o $(penguin) source/b_main.o   source/b_grid.o   

.PHONY: clean
clean : 
	@echo "make: clean targets of `pwd`"
	@rm -f source/*.o
	@rm -f $(penguin)
	@echo Directory Cleaned!

