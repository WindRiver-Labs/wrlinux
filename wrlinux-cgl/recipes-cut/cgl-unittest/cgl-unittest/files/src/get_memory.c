#include <sys/types.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <signal.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#define BLOCK 1024

void usage();
void init_daemon(void);

int main( int argc, char* argv[] ){
    long long int tolSize=0, tim=0;
    char *endptr=NULL, *ptr=NULL;
	int is_daemon=1;
	
    if( argc==2 ){
		if( strcmp(argv[1],"-i")==0 ){
			is_daemon = 0;
		}else{
            tolSize = strtoll( argv[1], &endptr, 10 );
		}
    }else if( argc==3 ){
		if( strcmp(argv[2],"-i")!=0 ){
			usage();
			exit(1);
		}else{
			is_daemon = 0;
			tolSize = strtoll( argv[1], &endptr, 10 );
		}
	}else if( argc!=1 ){
		usage();
		exit(1);
	}
    printf("toltal size: %lld\n", tolSize);
	if( is_daemon==1 ){
		printf("go into daemon!\n");
		init_daemon();
	}

    while( 1 ){
        if( (ptr=(char*) malloc( BLOCK )) != NULL ){
	    tim++;
	    if( tolSize!=0 ){
	        if( BLOCK*tim >= tolSize ){
		    break;
		}
	    }
	}
    }

    printf("malloc times: %lld\ntoltal size: %lld\n", tim, (BLOCK*tim) );
	printf("sleeping ...\n");
	while(1){
		sleep(1);
	}

    return 0;
}


void usage(){
	printf( "usage: THIS_PROGRAM  [mem_size_to_malloc] [-i]\n"
	        "           -i: not daemon\n"
			"after memory malloced, sleep to wait for being killed\n"
			);

}

void init_daemon(void)
{
	int i; 
	pid_t pid;
	if(pid=fork())	exit(0);			
	if(pid<0)					
		{
			/*printf("creat child process error!\n");*/
			exit(1);
		}
		
	setsid();									
	if(pid=fork())	exit(0);		
	if(pid<0)
		{
			/*printf("creat child process error!\n");*/
			exit(1);
		}
	for(i=0; i<getdtablesize(); i++)		
		close(i);					
	chdir("/");						
	umask(0);						
	signal(SIGCHLD, SIG_IGN);
	return;
}
