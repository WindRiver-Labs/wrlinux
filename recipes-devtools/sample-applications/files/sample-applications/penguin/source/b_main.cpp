/****************************************************************
    This is the bouncing ball C++ demo program.
    You can watch "grid.data" to see the bouncing balls as you step.
****************************************************************/
#include <stdlib.h>
#include <iostream>
#include <unistd.h>
#include "b_soft.h"
#include "b_hard.h"
#include "b_spin.h"
#include "b_ball.h"

int finished = 0;
int num_hard = 2;
int num_soft = 2;
int num_spin = 2;

int main()
{
    int i;
    for( i = 0; i < num_soft; i++ )
        new SOFT;
    
    for( i = 0; i < num_hard; i++ )
        new HARD;

    for( i = 0; i < num_spin; i++ )
        new SPIN;

    while( ! finished )
    {
        for( BALL *p = BALL::list; p; p = p -> next )
            p -> Move();
        system("clear");
        for ( int r = 0; r < HEIGHT; r++ )
        {
        	std::cout << grid.GetRow(r);
        }
      	sleep(1);
  
    }

    return 0;
}


/****************************************************************
    Hard ball characteristics.
****************************************************************/
int HARD::Collide()
{
    return 1;
}

POINT HARD::Bounce( POINT &pt )
{
    return POINT( -pt.x, -pt.y );
}

char HARD::Show()
{
    return 'b';
}

HARD::HARD(){}
HARD::HARD( int x ) : BALL(x) {}


/****************************************************************
    Soft ball characteristics.
****************************************************************/
//int SOFT::Collide()
//{
//    return 0;
//}

char SOFT::Show()
{
    return '*';
}


/****************************************************************
    Spinning ball characteristics.
****************************************************************/
int SPIN::Collide()
{
    return 1;
}

POINT SPIN::Bounce( POINT &pt )
{
    return POINT( pt.y, -pt.x );
}

char SPIN::Show()
{
    return '<';
}


/****************************************************************
    General ball functionality.
****************************************************************/
char BALL::Show()
{
    return '.';
}

BALL::BALL( int )
{
    grid_next = grid_prev = 0;
}

BALL::BALL()
{
    next = list; 
    list = this;    
    position.x = ( rand() % ( WIDTH - 2 ) ) + 1;
    position.y = ( rand() % ( HEIGHT - 2 ) ) + 1;
    change.x = ( rand() % 3 ) - 1;
    change.y = ( rand() % 3 ) - 1;
    grid_next = grid_prev = 0;
    grid.Add( this, position );
}

BALL *BALL::list;
int BALL::Collide()
{
    return 0;
}

void BALL::Move()
{
    POINT       new_position;

    new_position = position + change;
    if( grid.Check( new_position ) )
    {
        if( grid.Ball( new_position ) -> Collide() )
        {
            change = grid.Ball( new_position ) -> Bounce( change );
            new_position = new_position + change;
        }
    }
    grid.Delete( this, position );
    position = new_position;
    grid.Add( this, position );
} 

BALL * BALL::Next()
{
    return grid_next;
}                    

void BALL::Next( BALL *bp )
{
    grid_next = bp;
}                    

BALL * BALL::Previous()
{
    return grid_prev;
}

void BALL::Previous( BALL *bp )
{
    grid_prev = bp;
}                    


/****************************************************************
    Point functionality.
****************************************************************/
POINT::POINT( int a, int b )
{
    x = a;
    y = b;
}

POINT::POINT()
{
    x = 0;
    y = 0;
}

POINT POINT::operator+( POINT pt )
{
    POINT retval( pt.x, pt.y );
    retval.x = x + pt.x;
    retval.y = y + pt.y;
    while( retval.x < 0 )
        retval.x += WIDTH;
    while( retval.y < 0 )
        retval.y += HEIGHT;
    retval.x %= WIDTH;
    retval.y %= HEIGHT;
    return retval;
}
