/*
 * mips_bttest.c
 *
 *  Created on: Oct 14, 2004
 *      Author: dlerner
 *  Modified: October 10, 2008
 *      modified to take a numeric parameter that directs the type of 
 *      oprofile test to conduct.
 *  Syntax
 *      bttest [test-num]
 *  without args, prints the test case descriptions
 *  with a numeric arg, runs a profile test
 */

#undef TEST_ALLOCA

#include <stdio.h>
#ifdef TEST_ALLOCA
#include <alloca.h>
#endif
#include <time.h>

volatile int aGlobal = 1;

/*
	leaf
	no args
	no locals

	Test verifes that callstack correct for different cases of ABI. 
	
*/
int leafNoLocalsNoArgs()
{
    aGlobal=1;
	while (aGlobal) aGlobal += aGlobal;

	return ++aGlobal;
}

/*
	leaf
	no args
	locals to stack

*/
int leafStackLocalsNoArgs()
{
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,
		a10, a11, a12, a13, a14, a15;
	 a0 = a1 = a2 = a3 = a4 = a5 = a6 = a7 = a8 = a9 = a10 = a11 = a12 = a13 = a14 = a15 = aGlobal;
	 a1 += a0;
	 a2 += a1;
	 a3 += a2;
	 a4 += a3;
	 a5 += a4;
	 a6 += a5;
	 a7 += a6;
	 a8 += a7;
	 a9 += a8;
	 a10 += a9;
	 a11 += a10;
	 a12 += a11;
	 a13 += a12;
	 a14 += a13;
	 a15 += a14;
	 
    aGlobal=1;
	while (aGlobal) aGlobal += aGlobal;

	return a15+aGlobal;
}

/*
	leaf
	no args
	locals in regs

*/
int leafRegLocalsNoArgs()
{
	register int a0, a1, a2, a3, a4, a5, a6, a7;
	a0 = a1 = a2 = a3 = a4 = a5 = a6 = a7 = aGlobal;
	a1 += a0;
	a2 += a1;
	a3 += a2;
	a4 += a3;
	a5 += a4;
	a6 += a5;
	a7 += a6;
    aGlobal=1;
	while (aGlobal) aGlobal += aGlobal;
	return a7+aGlobal;
}

/*
	leaf
	args in register
	locals to stack

*/
int leafStackLocalsWithRegArgs(int i1, char* aString, float f1)
{
	int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,
		a10, a11, a12, a13, a14, a15;
	 a0 = a1 = a2 = a3 = a4 = a5 = a6 = a7 = a8 = a9 = a10 = a11 = a12 = a13 = a14 = a15 = i1 + f1;
	 a0 = i1 + f1;
	 a1 += a0;
	 a2 += a1;
	 a3 += a2;
	 a4 += a3;
	 a5 += a4;
	 a6 += a5;
	 a7 += a6;
	 a8 += a7;
	 a9 += a8;
	 a10 += a9;
	 a11 += a10;
	 a12 += a11;
	 a13 += a12;
	 a14 += a13;
	 a15 += a14;
    aGlobal=1;
	while (aGlobal) aGlobal += aGlobal;

	return  ( !*aString ? 1 : a15+aGlobal );
}

/*
	leaf:
	args in stack
	locals to stack

*/
int leafStackLocalsWithStackArgs(int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8, 
							  float f1, float f2, float f3, float f4, float f5, float f6, float f7, float f8 )
{


	int iTotal = i1+i2+i3+i4+i5+i6+i7+i8 ;
	int fTotal = f1+f2+f3+f4+f5+f6+f7+f8 ;
    aGlobal=1;
	while (aGlobal) aGlobal += aGlobal;

	return  ( iTotal + fTotal + aGlobal);
}

/*
	parent
	args in register
	locals to stack

*/
int parentLocalsWithRegArgs(int i1, char* aString, float f1)
{
	int i2 = i1+f1;
	float f2 = i1+f1;

    volatile int aLocal=1;
	while (aLocal) {
		i2 = leafStackLocalsWithRegArgs(i2, aString, f2);
		/* aGlobal = aGlobal + (int) f2 + i2 + (int) aString[0]++; */
		aLocal += aLocal;
	}
		
	return aLocal;
}



/*
	parent
	args on stack
	locals to stack

*/
parentLocalsWithStackArgs(int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8, 
							  float f1, float f2, float f3, float f4, float f5, float f6, float f7, float f8)
{
    volatile int aLocal=1;
	while (aLocal) {
		int tot1 = leafStackLocalsWithStackArgs ( i8, i7, i6, i5, i4, i3, i2, i1,
										f8, f7, f6, f5, f4, f3, f2, f1);
		float tot2 = tot1 + f8 + f7 + f6 + f5 + f4 +f3 + f2 + f1;
		/* aGlobal += aGlobal + i8 + i7 + i6 + i5 + i4 + i3 + i2 + i1 + (int)(tot2); */
		aLocal += aLocal;

	}
    return aLocal;
}

/* leaf with frame pointer
 * args
 * locals
   Force compiler to generate frame pointer
*/
int parentUseAlloca( int allocSize, int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8, 
							  float f1, float f2, float f3, float f4, float f5, float f6, float f7, float f8 )
{
	register int j1, j2, j3, j4, j5, j6, j7, j8;
	register int j9, j10, j11, j12, j13, j14, j15, j16;
	register float r1, r2, r3, r4, r5, r6, r7, r8;
	register float r9, r10, r11, r12, r13, r14, r15, r16;
	int sum;

#ifdef TEST_ALLOCA
	int* pTotal   = (int*) alloca ( allocSize * sizeof(int) );
#else
	int   Total   = 0;
	int* pTotal   = &Total;
#endif
	aGlobal = 1;
	while (aGlobal++) {
		*pTotal = i1 + i2;
		j1 = i1;
		j2 = i2; 
		j3 = i3; 
		j4 = i4;
		j5 = i5;
		j6 = i6;
		j7 = i7;
		j8 = i8;
		r1 = f1;
		r2 = f2;
		r3 = f3;
		r4 = f4;
		r5 = f5;
		r6 = f6;
		r7 = f7;
		r8 = f8;
		j9 = i8;
		j10 = i7; 
		j11 = i6; 
		j12 = i5;
		j13 = i4;
		j14 = i3;
		j15 = i2;
		j16 = i1;
		r9 = f8;
		r10 = f7;
		r11 = f6;
		r12 = f5;
		r13 = f4;
		r14 = f3;
		r15 = f2;
		r16 = f1;
	
		sum +=  leafStackLocalsWithStackArgs ( *pTotal+j1, j2+j3, j4+j5, j6+j7, j8+j9, j10+j11, j12+j13, j14+j15+j16,
											r1+r2, r3+r4, r5+r6, r7+r8, r9+r10, r11+r12, r13+r14, r15+r16);
	}
	return sum;
}

typedef struct {
	int num;
	void *addr;
	char* name;
} TestCase;

#define TEST_FUNCTION(num, func) num, func, #func

int main(int, char**);

TestCase test_cases[] = { 
		{ TEST_FUNCTION (0, leafNoLocalsNoArgs)},
		{ TEST_FUNCTION (1, leafStackLocalsNoArgs)},
		{ TEST_FUNCTION (2, leafRegLocalsNoArgs)},
		{ TEST_FUNCTION (3, leafStackLocalsWithRegArgs)},
		{ TEST_FUNCTION (4, leafStackLocalsWithStackArgs)},
		{ TEST_FUNCTION (5, parentLocalsWithRegArgs)},
		{ TEST_FUNCTION (6, parentLocalsWithStackArgs)},
		{ TEST_FUNCTION (7, parentUseAlloca)},
		{ TEST_FUNCTION (-1, main)}
};

void printFunctionAddresses() {
	int i;
	TestCase *tc = test_cases;
	for (i=0; i <= 8; i++, tc++) {
    	printf("%d: %s: %p\n", tc->num, tc->name, tc->addr); 
	}
}

/*
 * Description:
 * Test app for validation of stack frame analysis
 * both with and without symbols.
 * Syntax: 
 *    mips_bttest.out  <no args>
 * 			prints list of test cases
 *    mips_bttest.out <test-case from above>
 *			Spins in the test case long enough to consume most cycles on that processor.
 *			Performance Profiler should report 90%+ cycles in the name of the 
 *				corresponding function.
 *			Known defect in parentUseAlloca	
 */
int main(int argc, char** argv)
{
	char buffer[20];
	float aFloat=1.0;
	int testCase;
	int testTime;
	int anInt=2;
	int doAll  = 0;
	int doTime = 0;
	time_t timeStart,timeNow,timeMark;  /* C run-time time (defined in <time.h>) */

	if ( argc < 2 ) {
    	printFunctionAddresses();
    	return 0;
	}

	/* check to see if this is a bounded Unit Test run */
	if (0 == strcmp("unittest",argv[1])) {
		
		doTime   = 1;
		testCase = 0;
		doAll    = 1;
		testTime = 10;	/* Default to 10 second test run */
		time( &timeStart) ; 
		timeMark = timeStart;
		if ( argc > 2 ) {
			sscanf(argv[2], "%d", &testTime);
		}		
		printf("Unit test for %d seconds\n",testTime);
	} else {
		sscanf(argv[1], "%d", &testCase);
		if ( testCase < 0) {
			testCase = 0;
			doAll    = 1;
		}
	}
	while (1)
	{
	    switch (testCase){
		case 0: 
			aGlobal += leafNoLocalsNoArgs();
			break;
		case 1: 
			aGlobal += leafStackLocalsNoArgs();
			break;
		case 2:
			aGlobal += leafRegLocalsNoArgs();
			break;
	    case 3:
	        aGlobal += leafStackLocalsWithRegArgs(anInt, buffer, aFloat);
	        break;
	    case 4:
	        aGlobal += leafStackLocalsWithStackArgs( 
	                    anInt, anInt*2, anInt*3, anInt*4, anInt*5, anInt*6, anInt*7, anInt*8,
	                    aFloat, aFloat*2, aFloat*3, aFloat*4, aFloat*5, aFloat*6, aFloat*7, aFloat*8);
	        break;
	    case 5:
	        aGlobal += parentLocalsWithRegArgs(anInt, buffer, aFloat);
	        break;
	    case 6:
	        aGlobal += parentLocalsWithStackArgs( 
	                    anInt, anInt*2, anInt*3, anInt*4, anInt*5, anInt*6, anInt*7, anInt*8,
	                    aFloat, aFloat*2, aFloat*3, aFloat*4, aFloat*5, aFloat*6, aFloat*7, aFloat*8);
	        break;
	    case 7:
	    {
#ifdef TEST_ALLOCA
	    	int alloc_size = 100;
	    	aGlobal += parentUseAlloca( alloc_size, 
	    			anInt*1, anInt*2, anInt*3, anInt*4, anInt*5, anInt*6, anInt*7, anInt*8, 
	    			aFloat*1, aFloat*2, aFloat*3, aFloat*4, aFloat*5, aFloat*6, aFloat*7, aFloat*8 );
#endif
	    	break;
	    }
	    default:
	        printf("unknown parameter\n");
	    }

	    if (doAll) {
	    	testCase = (++testCase % 8);
	    }

		if (doTime) {
			time( &timeNow) ;

			if (timeMark < timeNow) {
				timeMark = timeNow;
				printf("*");
			}
			
			if ((timeNow - timeStart) >= testTime) {
				printf("\n");
				return 0;
			}
		}

	}
	return 0;
}

