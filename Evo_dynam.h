#ifndef _EVO_DYNAM
# define _EVO_DYNAM

# include <iostream>
# include <armadillo>
# include "IBC.h"

using namespace std;
using namespace arma;

class Evo_dynam:public Ini_Bnd
{
public:
	double err_i;
	double err_f;
	cube T_track;
	uvec ind_track;

	Evo_dynam(double err_ii = 0, double err_ff = 0, cube T_trackk=cube(),uvec ind_trackk=uvec());
	void dmcr_evo(void);
	typedef double(Evo_dynam::*p_norm)(mat&, mat&);
	p_norm retn_norm_func(void);

	void get_track_point(void);

};


# endif