all : 
	@echo "make: built targets of `pwd`"
	${CC} ${CFLAGS} ${CINCLUDES} -c -o mthread.o mthread.c
	${CC} ${LDFLAGS} ${LINCLUDES} -lpthread -o mthread mthread.o 

clean :
	@echo "make: removing targets and objects of `pwd`"
	@rm -f *.o
	@rm -f mthread
	@echo Directory Cleaned!

