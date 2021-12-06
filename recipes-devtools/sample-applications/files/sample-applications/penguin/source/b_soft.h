#include "b_ball.h"

/****************************************************************
    A soft ball does not affect anything colliding with it.
    i.e. the incoming vector of change is not affected.

    Soft balls can bounce off of walls.
****************************************************************/
class SOFT : public BALL
{
public:
    //int Collide();
    POINT Bounce( POINT & pt ){return pt; }
    char Show();
};
