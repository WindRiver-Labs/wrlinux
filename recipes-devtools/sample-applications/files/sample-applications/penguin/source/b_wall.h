#include "b_hard.h"

/****************************************************************
    A wall in the X direction is a vertical wall that deflects
    balls by changing the X component of their change vector.
****************************************************************/
class WALLX : public HARD
{
public:
    WALLX(int);
    POINT Bounce( POINT & );     
    char Show();
};

/****************************************************************
    A wall in the Y direction is a horizontal wall that deflects
    balls by changing the Y component of their change vector.
****************************************************************/
class WALLY : public HARD
{
public:
    WALLY(int);
    POINT Bounce( POINT & );
    char Show();
};
