#include "b_ball.h"

/****************************************************************
    A spinnin ball deflects the incoming ball and turns it. 
****************************************************************/
class SPIN : public BALL
{
public:
    int Collide();
    virtual char Show();
    virtual POINT Bounce( POINT & );
};
