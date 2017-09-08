/*
 * death-notify-test.c: to test function of dist/linux/features/cgl/death-notify.patch.
 *
 * Test commands:
 * 1.cross-compile "death-notify-test.c" and copy it to target rootfs.
 * 2.boot the patched system(e.g. fsl_8555cds)
 * 3.run death-notify-test program on the target
 * #./death-notify-test
 * child2 registers it to monitor child1's exit.
 * child1 is sleeping for 5 seconds ..... OK, child1 exit.
 * child1 notify child2 of child1's exit.
 * child2 exit.
 * parent exit.
 *
 * Expected testing results:
 * death-notify-test exits normally and message are the same with above. 
 * otherwise death-notify-test will hang and press Ctrl+C should kill it.
 *
 * limig.wang@windriver.com
 *
 */

#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/prctl.h>
#include <signal.h>

#define PR_DO_NOTIFY_TASK_STATE 17

struct notify_info {
       int pid;
       int sig;
       unsigned int events;
}info;

void sig_handler(int sig)
{
	printf("child1 notify child2 of child1's exit.\n");
	printf("child2 exit.\n");
	printf("death-notify test PASS\n");
	exit(0);
}

int main()
{
	pid_t pid1, pid2;
	int status;
	int i = 0;
	
	if ((pid1 = fork()) == 0) {
		while(i++ < 5) {
			sleep(1);
			if (i == 1)
				fprintf(stdout, "child1 is sleeping for 5 seconds ");
			fprintf(stdout, ".");
		}
		printf(" OK, child1 exit.\n");
		exit(0);
	} else {
		info.pid = pid1;
		info.sig = SIGUSR1;
		/* if child1 exits, to notify child2. CLD_EXITED==1*/
		info.events = 1<<1; 
		if ((pid2 = fork()) == 0) {
			signal(SIGUSR1, sig_handler);
			printf("child2 registers it to monitor child1's exit.\n");
			prctl(PR_DO_NOTIFY_TASK_STATE, &info, 0, 0, 0);
			while(1);
		} else {
			waitpid(pid2, &status, 0);
			printf("parent exit.\n");
			exit(0);
		}
	}
}
