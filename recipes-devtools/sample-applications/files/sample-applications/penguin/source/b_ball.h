#if !defined( _BALL_H )
#define _BALL_H

/****************************************************************
    A point or position in the grid.

    A point has coordinates and can be added to another point.
****************************************************************/
class POINT
{ 
public:
    int x;
    int y;
    POINT operator +( POINT );
    POINT( int, int );
    POINT();
};

typedef class POINT POINT;

/****************************************************************
    A generic ball. Each ball has a position and a vector of
    change for the next move.

    Each ball is on two linked lists. The first is the link
    of all ball objects and the second is of all ball objects
    at the same grid position.

    Each ball can Move(), determine collisions of incoming
    balls (Collide()), and affect the change vector of
    incoming balls (Bounce()). Specific ball types can
    override the default functions in order to provide
    unique balls on the grid. (spinning, hard, soft, etc. )
****************************************************************/
class BALL 
{
    BALL        *grid_next;     // link to next ball at same position
    BALL        *grid_prev;     // link to previous ball at same position
    POINT       position;       // position of ball on the grid
    POINT       change;         // change vector of the ball
public:
    BALL        *Next();        // get next ball on the grid list
    BALL        *Previous();    // get previous ball on the grid list
    void        Next( BALL * ); // set pointer to next ball on the grid list
    void        Previous( BALL * );     // set pointer to previous ball on the grid list

static BALL     *list;          // list of all balls on the grid.
    BALL        *next;          // pointer to next ball on the list

    BALL();                     // standard constructor
    BALL(int);                  // constructor for balls not on the list of balls to move
virtual char    Show();         // return character to show for this ball type.
virtual void    Move();         // move the ball
virtual int     Collide();      // answer query for whether collision affects incoming change vector
virtual POINT   Bounce( POINT & ) = 0;  // change the incoming vector
};

/****************************************************************
    Width and height of the grid on which the bouncing balls
    will be shown.
****************************************************************/
#define WIDTH 16
#define HEIGHT 10

/****************************************************************
    A LIST object represents a list of balls. It is used
    at each position of the grid to keep track of the 
    balls at each position.
****************************************************************/
class LIST
{
    BALL *head;
    BALL *last;
public:
    LIST();
    void Add( BALL * );
    void Remove( BALL * );
    void Init();
    BALL *First();
    BALL *Last();
};

/****************************************************************
    The grid represents the collection of all balls which
    are the walls or are moving.
****************************************************************/
class GRID
{
    LIST balls[ HEIGHT ][ WIDTH ];      // lists of balls at each position
    char data [ HEIGHT ][ WIDTH ];      // characters representing the balls
public:
    GRID();
    void Add( BALL *, const POINT & );        // add ball to grid at specified position
    void Delete( BALL *, POINT & );     // delete ball from specified position
    int Check( POINT & );               // is there a ball a specified position?
    BALL *Ball( POINT & );              // return the ball at specified position
    char * GetRow( int ); 
} ;

extern GRID grid;                       // the grid itself

#endif
