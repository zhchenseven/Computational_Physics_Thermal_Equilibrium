# include <iostream>
# include <armadillo>
# include "IBC.h"

using namespace std;
using namespace arma;

Ini_Bnd::Ini_Bnd(string IB_typee)
{
	IB_type = IB_typee;
	cout << "A class of Ini_Bnd is constructed." << endl << endl;
}

void Ini_Bnd::set_IB_type(string IB_typee)
{
	IB_type = IB_typee;
}

void Ini_Bnd::IBV_cetr(void)
{
	if (IB_type == "canonic")
	{
		IBV_canonic Ic;
		Para * pP = (Para*)this;
		Ic.eva_IBV(pP);
	}
	else
	{
		cout << "Your specified IB_type " << IB_type << " is not available yet." << endl;
		exit(1);
	}
}


IBV_canonic::IBV_canonic()
{
	cout << "A class of IBV_canonic is constructed." << endl << endl;
}

void IBV_canonic::eva_IBV(Para*pP)
{
	double pi = datum::pi;
	int N_all = pP->N + 2;
	rowvec row_ini = rowvec(N_all, fill::zeros);
	pP->To.row(N_all - 1) = row_ini;
	row_ini = sin(pi*pP->x);
	pP->To.row(0) = row_ini;
	colvec col_ini = colvec(N_all, fill::zeros);
	pP->To.col(0) = col_ini;
	col_ini = colvec(mat(sin(pi*pP->x)).t());
	pP->To.col(N_all - 1) = col_ini;
	pP->T_i = pP->To;
}