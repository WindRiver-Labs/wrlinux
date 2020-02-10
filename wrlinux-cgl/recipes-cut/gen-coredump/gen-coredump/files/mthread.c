/* SPDX-License-Identifier:  GPL-2.0 */

/* mthread.c - Sample Program for Usermode Multi-threaded debugging */

/* Copyright 2006 Wind River Systems, Inc. */


/* 
 * DESCRIPTION
 * A Pthreads program.  Performs thread creation and termination.
 * 
 * This file must be linked against the pthread library.
 * % gcc -o mthread mthread.c -lpthread
 */

#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define DEFAULT_NUM_THREADS	2

typedef void * (*VOIDFUNCPTR) (void * arg);

void dummy ()
{
}

void   alone (const char *header)
{
   static int toto = 0;

   while (1)
   {
      toto++;
      dummy ();
      printf ("In alone (pid %d) \n",getpid());
      sleep (2); 
   }
}

void   printInfo(const char * header)
{
    /* pthread_self() returns ???
     * getppid() returns the PID of the manager thread
     * getpid() returns the lightweight PID
     */
    
    printf("%s :\tThreadID =%8d ParentID = %8d ID_self = %8d\n",
	   	header, (int) pthread_self(),  getppid(),  getpid());
}

void sharedCode ()
{
   static int counter;

   counter++; 
}

void printThreadInfo(void * i)
{
   char threadStr[16] = "Thread ";
   sprintf (&(threadStr[strlen(threadStr)]), "%ld", (long) i);
   printInfo((const char *) threadStr);

   /* keep thread going forever */
   while (1)
   {
       printf ("Thread %ld is awake (pid %d).\n", (long) i, getpid());
       sleep(2);
       sharedCode(); 
   }

   /* pthread_exit */
   return;
}

int main(int argc, char *argv[])
{
   pthread_t threads[100];
   int retval;
   int numThreads;
   long t;

   if (argc == 2)
        numThreads = atoi(argv[1]);
   else if (argc == 1)
        numThreads = DEFAULT_NUM_THREADS;
   else
        {
        printf ("Error Usage: %s num_threads\n", argv[0]);
        exit (1);
        }

   if (numThreads > 100)
        {
        printf ("Error Usage: %d is greater than 100\n", numThreads);
        exit (1);
        }

   printInfo("Main Process");

   for(t=0;t<numThreads;t++){
      printf("Main thread create one thread (%ld)\n",t);
      
      retval = pthread_create(&threads[t], NULL, (void*)printThreadInfo,
			      (void *) t);
      if (retval){
	    printf("ERROR; return code from pthread_create() is %d\n", retval);
	    exit(-1);
      }
   }
   
   retval = pthread_create(&threads[numThreads], NULL, (VOIDFUNCPTR) alone, 0);
   numThreads++; 


   while (1)
      {
      printf ("In main process...\n"); 
      sleep (2); 
      }
   printf ("JOIN is done \n");
   exit(0);
}
