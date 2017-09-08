#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

char buf1[] = "test1234abcdasdfgfhi";
int main( int argc, char* argv[] )
{
    int fd;
    char buf[25];
    printf("pid is %d\n", getpid());
    if((fd = open("/tmp/tempfile", O_WRONLY|O_CREAT|O_TRUNC)) < 0)
    {
        printf("Failed to open the file\n");
        return 1;
    }
    if(write(fd, buf1, 20) != 20)
    {
        printf("Failed to write\n");
        return 1;
    }
    close(fd);
    if((fd = open("/tmp/tempfile", O_RDONLY)) < 0)
    {
        printf("Failed to open the file\n");
        return 1;
    }
    if(read(fd, buf, 20) != 20)
    {
        printf("Failed to read the file\n");
        return 1;
    }
    if(chmod("/tmp/tempfile", S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH) < 0)
    {
        printf("Failed to change file attribute");
        return 1;
    }
    remove("/tmp/tempfile");
    return 0; 
}
