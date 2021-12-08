all : 
	@echo "make: built targets of `pwd`"
	${CC} ${CFLAGS} ${CINCLUDES} -c -o hello.o hello.c
	${CC} ${LDFLAGS} ${LINCLUDES} -o hello hello.o 

clean :
	@echo "make: removing targets and objects of `pwd`"
	@rm -f *.o
	@rm -f hello
	@echo Directory Cleaned!

