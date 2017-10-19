# include <iostream>
# include <armadillo>
# include "Para.h"

using namespace std;
using namespace arma;


Para::Para(int NN, int N_maxx , int N_itrr , double err_bndd, double hh , rowvec xx , rowvec itr_diff , mat TT , mat Too,
	double x_loww , double x_supp, string norm_typee, mat T_ii, int track_ctrll , int MM, int M_facc )
{
	N = NN;
	N_max = N_maxx;
	N_itr = N_itrr;
	err_bnd = err_bndd;
	h = hh;
	x = xx;
	itr_dif = N_itr;
	T = TT;
	To = Too;
	x_low = x_loww;
	x_sup = x_supp;
	norm_type = norm_typee;
	track_ctrl = track_ctrll;
	M = MM;
	M_fac = M_facc;


	T_i = T_ii;
	cout << "A class of Para is constructed." << endl << endl;
}


void Para::set_para(int NN, double err_bndd, int N_maxx, double x_loww, double x_supp, string norm_typee)
{
	N = NN;
	err_bnd = err_bndd;
	N_max = N_maxx;
	x_low = x_loww;
	x_sup = x_supp;
	norm_type = norm_typee;

}


double Para::norm_inf(mat &A, mat &B)
{
	mat C = abs(A - B);
	return C.max();
}

void Para::set_ini_cond(void)
{
	x = linspace<rowvec>(x_low, x_sup, N + 2);
	h = x(1) - x(0);
	itr_dif = rowvec(N_max, fill::zeros);
	T = mat(N + 2, N + 2, fill::zeros);
	To = T;
	T_i = T;
}


void Para::set_track_para(int track_ctrll, int MM)
{
	track_ctrl = track_ctrll;
	M = MM;
	M_fac = M;
}