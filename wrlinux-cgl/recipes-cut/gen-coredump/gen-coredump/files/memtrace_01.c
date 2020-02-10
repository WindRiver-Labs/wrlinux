/* SPDX-License-Identifier:  GPL-2.0 */

/*
 * memtrace_01.c
 *
 *  Created on: Oct 11, 2008
 *      Author: dreyna
 *  Syntax
 *      memtrace_01
 *  
 *  This leaves a unmatched malloc at different levels of
 *  a five-level recursive call stack
 */

/* Copyright 2020 Wind River Systems, Inc. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


void mem_depth5 (int depth)
{
    char *t;

	depth--;

	t = malloc(50);

	/* NOTE: missing free if this is leaf node */
	printf("*");
}

void mem_depth4 (int depth)
{
    char *t;

	depth--;

	t = malloc(40);

	if (depth>0) {
		mem_depth5(depth);
		free(t);
		return;
	}

	/* NOTE: missing free if this is leaf node */
	printf("*");
}

void mem_depth3 (int depth)
{
    char *t;

	depth--;

	t = malloc(30);

	if (depth>0) {
		mem_depth4(depth);
		free(t);
		return;
	}

	/* NOTE: missing free if this is leaf node */
	printf("*");
}

void mem_depth2 (int depth)
{
    char *t;

	depth--;

	t = malloc(20);

	if (depth>0) {
		mem_depth3(depth);
		free(t);
		return;
	}

	/* NOTE: missing free if this is leaf node */
	printf("*");
}

void mem_depth1 (int depth)
{
    char *t;

	depth--;

	t = malloc(10);

	if (depth>0) {
		mem_depth2(depth);
		free(t);
		return;
	}

	/* NOTE: missing free if this is leaf node */
	printf("*");
}


int main(void)
{
	printf("memtrace_01:");

	mem_depth1(1);
 	mem_depth1(2);
	mem_depth1(3);
	mem_depth1(4);
	mem_depth1(5);
   
	printf("\n");
	return EXIT_SUCCESS;
}
