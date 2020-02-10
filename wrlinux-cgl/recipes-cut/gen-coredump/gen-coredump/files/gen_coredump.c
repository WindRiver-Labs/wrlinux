/* SPDX-License-Identifier:  GPL-2.0 */

/* gen_coredump.c - Sample Program to cause a core dump */

/* Copyright 2020 Wind River Systems, Inc. */

int main(void)
{
	int *p = (int *)0;
	*p=0;
	return 0;
}
