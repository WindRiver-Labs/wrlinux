/****************************************************************
    Grid and List functionality for the ball program.
****************************************************************/
#include <string.h>
#include "b_ball.h"
#include "b_wall.h"

GRID grid;

/****************************************************************
    Grid constructor: Initialize data area, balls, and walls.
****************************************************************/
GRID::GRID()
{  
    int r, c;
    
    for( r = 0; r < HEIGHT; r++ )
    {
        for( c = 0; c < WIDTH; c++ )
        {
            data[ r ][ c ] =  ' ';
            balls[ r ][ c ].Init();
        }
    }                              
    for( r = 0; r < HEIGHT; r++ )
    {
        Add( new WALLX(0), POINT(0, r) );
        Add( new WALLX(0), POINT(WIDTH - 1, r) );
    }                              
    for( c = 0; c < WIDTH; c++ )
    {
        Add( new WALLY(0), POINT( c, 0 ) );
        Add( new WALLY(0), POINT( c, HEIGHT - 1 ) );
    }
} 

 
/****************************************************************
    Add ball to the grid at specified point.
****************************************************************/
void GRID::Add( BALL *bp, const POINT &pt )
{
    balls[pt.y][pt.x].Add( bp );
    data[ pt.y ][ pt.x ] = bp -> Show();
}


/****************************************************************
    Delete ball from the grid at specified point.
****************************************************************/
void GRID::Delete( BALL *bp, POINT &pt )
{
    balls[pt.y][pt.x].Remove( bp );
    if( balls[pt.y][pt.x].First() == 0 )
        data[ pt.y ][ pt.x ] = ' ';
    else
        data[ pt.y ][ pt.x ] = balls[ pt.y][pt.x].First() -> Show();
}      


/****************************************************************
    Get the first ball from the grid at specified point.
****************************************************************/
BALL *GRID::Ball( POINT &pt )
{
    return balls[pt.y][pt.x].First();
} 


/****************************************************************
    Return nonzero if balls exist in grid at specified point.
****************************************************************/
int GRID::Check( POINT &pt )
{
    return balls[pt.y][pt.x].First() != 0;
}

static char buf[ WIDTH + 2 ];
char * GRID::GetRow( int row )
{
	memcpy(buf, &grid.data[ row ], WIDTH );
	strcpy(&buf[ WIDTH ], "\n");
	return buf;
}

/****************************************************************
    List functionality.
****************************************************************/
void LIST::Init()
{
    head = last = 0;
}

LIST::LIST()
{
    Init();
}

BALL *LIST::First()
{
    return head;
}               

BALL *LIST::Last()
{
    return last;
}

void LIST::Add( BALL *bp )
{
    bp -> Next( 0 );
    bp -> Previous( last );
    if( last )             
        last = bp;
    else
    {
        head = last = bp;
    }
}

void LIST::Remove( BALL *bp )
{
    if( bp -> Next() )
        bp -> Next() -> Previous( bp -> Previous() );
    else
        last = bp -> Previous();
    if( bp -> Previous() )
        bp -> Previous() -> Next( bp -> Next() );
    else
        head = bp -> Next();
}


/****************************************************************
    Wall functionality.
****************************************************************/
POINT WALLX::Bounce( POINT &pt )
{
    return POINT( -pt.x, pt.y );
}

char WALLX::Show()
{
    return '|';
}

WALLX::WALLX( int x ) : HARD(x) {}

POINT WALLY::Bounce( POINT &pt )
{
    return POINT( pt.x, -pt.y );
}

char WALLY::Show()
{
    return '^';
}

WALLY::WALLY( int x ) : HARD(x) {}

