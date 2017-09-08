/* vul.c
 *
 * Very simple test case to check for stack smashing protection support in
 * your kernel and libc.
 *
 * Based very loosely on the much more complicated work done here:
 *    http://collusion.org/Article.cfm?ID=176
 *    http://ebook.security-portal.cz/book/basic_overflows/overflows.txt
 *
 * Compile with something like:
 *
 * ${CROSS_COMPILE}-gcc -fstack-protector-all vul.c -o vul
 *
 * Run like this:
 *
 * $ ./vul 1234567890
 * buffer: 1234567890
 * $ ./vul 12345678901
 * buffer: 12345678901
 * *** stack smashing detected ***: ./vul terminated
 * Aborted
 * $
 */
#include <stdio.h>
#include <string.h>

int vul_func(char *argv)
{
   char buffer[10];
   strcpy(buffer, argv);
   printf("buffer: %s\n",buffer);
   return 0;
}

int main (int argc, char *argv[])
{
   if (argc >= 2)
      vul_func(argv[1]);
   return 0;
}

/* vim: set et nowrap tw=78 ts=3 sw=3 ft=c: */
