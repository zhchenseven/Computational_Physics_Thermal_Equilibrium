# ifndef _IBC
# define _IBC

# include <iostream>
# include <armadillo>
# include "Para.h"

using namespace std;
using namespace arma;

class Ini_Bnd:public Para
{
public:
	// IB_type specifies the type of restrictions to the PDE, i.e., the initial value problem or a boundary problem, which works for the extension study of the PDE
	string IB_type;
	Ini_Bnd(string IB_typee= "canonic");
	void set_IB_type(string IB_typee);
	void IBV_cetr(void);

};

//IBV_canonic specifies the boundary condition as required by the project problem
class IBV_canonic
{
public:
	IBV_canonic();
	void eva_IBV(Para * pP);
};

# endif
