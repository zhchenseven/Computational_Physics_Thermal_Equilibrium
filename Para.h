#ifndef _PARA
#define _PARA

# include <iostream>
# include <armadillo>

using namespace std;
using namespace arma;

class Para
{
public:
	//N is the number of gridding points except two end points
	int N;
	//N_max is the upper limit of iterations
	int N_max;
	//N_itr records the actually iteraction occurences restricted by norm
	int N_itr;
	// err_bnd records the criterion to cease the evolution
	double err_bnd;
	// h is the gridding spacing
	double h;
	// x is the 1D gridding
	rowvec x;
	// itr_dif records the norm of difference between two adjacent iterations
	rowvec itr_dif;
	//T_i denotes the matrix of initial time point
	mat T_i;
	// T denotes the matrix of the current time point
	mat T;
	//To detnoes the matrix of the preceding time point
	mat To;
	//x_low is the lower limit of x
	double x_low;
	// x_sup is the upper limit of x
	double x_sup;
	// norm_type specifies the criterion for norm of difference of adjacent evolution matrix
	string norm_type;
	// track_ctrl controls whether we record the tracking data
	int track_ctrl;
	//M controls the number of tracking time, which includes the initial time and the final time, we demand M>2
	int M;
	// M_fac records the actual recording times of evolutions
	int M_fac;
	Para(int NN = 16, int N_maxx = 500, int N_itrr = 0, double err_bndd = 1e-5, double hh = 0,
		rowvec xx = rowvec(), rowvec itr_diff = rowvec(), mat TT = mat(), mat Too = mat(), double x_loww = 0, double x_supp = 0, string norm_typee = "inf", mat T_ii = mat(), int track_ctrll = 0, int MM = 50, int M_facc = 50);
	void set_para(int NN, double err_bndd, int N_maxx, double x_loww, double x_supp, string norm_typee);

	double norm_inf(mat &A, mat &B);
	void set_ini_cond(void);

	void set_track_para(int track_ctrll, int MM);
	
};


#endif
