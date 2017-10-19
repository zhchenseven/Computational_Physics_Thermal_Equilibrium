# include <iostream>
# include <armadillo>
# include "Evo_dynam.h"

using namespace std;
using namespace arma;

typedef double(Evo_dynam::*p_norm)(mat&, mat&);

enum norm_type_code
{
	inf,
	norm_2,
	norm_1,

};

norm_type_code hash_norm_type(string const & s)
{
	if (s == "inf")
		return inf;
	if (s == "1")
		return norm_1;
	if (s == "2")
		return norm_2;
	else
	{
		cout << "Your specified norm type " << s << " is not available yet." << endl;
		exit(1);
	}

}

Evo_dynam::Evo_dynam(double err_ii , double err_ff, cube T_trackk, uvec ind_trackk )
{
	err_i = err_ii;
	err_f = err_ff;
	T_track = T_trackk;
	ind_track = ind_trackk;
	cout << "A class of Evo_dynam is constructed." << endl << endl;
}


p_norm Evo_dynam::retn_norm_func(void)
{
	switch (hash_norm_type(norm_type))
	{
	case inf:
	{	
		p_norm p = & Evo_dynam::norm_inf;
		return p;
	}

	default:
	{
		cout << "Your specified norm type " << norm_type << " is not available yet." << endl;
		exit(1);
		break;
		break;
	}
	}
}


void Evo_dynam::dmcr_evo(void)
{
	int n,i, j;
	double t_elasped;
	N_itr = 0;
	double evo_dif_norm;
	p_norm p = retn_norm_func();
	T = To;
	wall_clock timer;
	timer.tic();
	for (n = 0; n < N_max; n++)
	{
		cout << "complete the " << n+1 << " iteration." << endl;
		for (i = 1; i <= N; i++)
		{
			for (j = 1; j <= N; j++)
			{
				T(i, j) = (To(i - 1, j) + To(i + 1, j) + To(i, j - 1) + To(i, j + 1)) / 4;
			}
		}
		
		N_itr++;
		evo_dif_norm = (this->*p)(T, To);
		if (n == 0)
			err_i = evo_dif_norm;
		To = T;
		itr_dif(n) = evo_dif_norm;
		if (evo_dif_norm < err_bnd)
		{
			err_f = evo_dif_norm;
			break;
		}
	}
	t_elasped = timer.toc();
	cout << "The Laplace equation takes " << t_elasped << " s in C++." << endl;

	if (track_ctrl == 1)
	{
		get_track_point();
		cout << "track_index" << endl << ind_track << endl;
		To = T_i;
		T = To;
		T_track.slice(0) = T_i;
		int n_flag=1;
		N_itr = 0;
		for (n = 0; n < N_max; n++)
		{
			cout << "complete the " << n + 1 << " iteration." << endl;
			for (i = 1; i <= N; i++)
			{
				for (j = 1; j <= N; j++)
				{
					T(i, j) = (To(i - 1, j) + To(i + 1, j) + To(i, j - 1) + To(i, j + 1)) / 4;
				}
			}
			if (n == ind_track(n_flag))
			{
				T_track.slice(n_flag) = T;
				n_flag++;
			}
			N_itr++;
			evo_dif_norm = (this->*p)(T, To);
			if (n == 0)
				err_i = evo_dif_norm;
			To = T;
			itr_dif(n) = evo_dif_norm;
			if (evo_dif_norm < err_bnd)
			{
				err_f = evo_dif_norm;
				break;
			}
		}
	}

}


void Evo_dynam::get_track_point(void)
{
	if (N_itr <= M-1)
	{
		M_fac = N_itr;
		ind_track = regspace<uvec>(1, M_fac-1);
	}
	else
	{
		M_fac = M;
		int q = (N_itr-1 )/ (M-2);
		int r = N_itr%(M-1);
		int K =  N_itr-1 + (2 - M)*q;
		int L = M - 2 - K;
		cout << "q= " << q << ",r= " << r << ",K=" << K << ",L=" << L << endl;
		ind_track = uvec(M_fac,fill::zeros);
		int i;
		for (i = 1; i <= M_fac-1; i++)
		{
			if (i == 1)
				ind_track(i ) = 1;
			else if (i <= 1 + K)
				{
					ind_track(i ) = ind_track(i - 1) + q + 1;
				}
			else
					ind_track(i ) = ind_track(i - 1) + q;
		
		}
	}
	ind_track -=1;
	ind_track(0) = 0;
	T_track = cube(N + 2, N + 2, M_fac,fill::zeros);
}