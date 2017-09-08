#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc,char *argv[])
{
    int i = 1;
    pid_t pid = 0;

    printf("Now,let us begin create process\n");

    if ((atoi(argv[1]) == 0) && (NULL == argv[1]))
    {
        puts("Please input the number what you want! Try again\n");
        exit(1);
    }

    for(i = 1; i < atoi(argv[1]) + 1; i++)
    {
        pid = fork();
        if(pid < 0)
        {
            perror("fork failed\n");
            printf("Total create %d process\n",i-1);
            exit(1);
        }
        else if (pid == 0)
        {
            while(1);
        }
        else
        {
            printf("This is the %dth  process\n",i);
        }
    }

    return 0;
}

