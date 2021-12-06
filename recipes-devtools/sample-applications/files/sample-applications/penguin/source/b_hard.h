#include "b_ball.h"

/****************************************************************
    A hard ball deflects the incoming ball. It has a special
    constructor so that walls made from hard balls can be created
    and not put on the list of balls to move.
****************************************************************/
class HARD : public BALL
{
public:
    HARD();
    HARD(int );
    int Collide();
    virtual char Show();
    virtual POINT Bounce( POINT & );
};
