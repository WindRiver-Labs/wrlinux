all : 
	@echo "make: built targets of `pwd`"
	${CC} ${CFLAGS} ${CINCLUDES} -c -o client.o client.c
	${CC} ${LDFLAGS} ${LINCLUDES} -o client client.o 
	${CC} ${CFLAGS} ${CINCLUDES} -c -o server.o server.c
	${CC} ${LDFLAGS} ${LINCLUDES} -o server server.o 

clean :
	@echo "make: removing targets and objects of `pwd`"
	@rm -f *.o
	@rm -f client
	@rm -f server
	@echo Directory Cleaned!

