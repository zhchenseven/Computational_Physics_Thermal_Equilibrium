# include <iostream>
# include <armadillo>
# include "Data_process.h"

using namespace std;
using namespace arma;

int r64(int argc, char ** argv)
{
	Data_process Project;
	int N = 64;
	double err_bnd = 1e-6;
	int N_max = 50000;
	double x_low = 0;
	double x_sup = 1;
	string norm_type = "inf";
	
	Project.set_para(N, err_bnd, N_max, x_low, x_sup, norm_type);
	string IB_type = "canonic";
	Project.set_IB_type(IB_type);

	string vis_name = "laplace_N_64";
	int index = 0;
	string data_type = "dat";
	string size_sufx = "size";

	int track_ctrl = 1;
	int M = 50;
	Project.set_track_para(track_ctrl, M);

	Project.set_process_ctrl(vis_name, index, data_type, size_sufx);
	Project.evo_exe_cetr();
	Project.process();
	Project.write_log();

	system("pause");
	return 0;
	
}