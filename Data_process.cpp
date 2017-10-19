# include <iostream>
# include <armadillo>
# include <direct.h>
# include "Data_process.h"
# include <string>


using namespace std;
using namespace arma;

template <typename T>
string n2s(T Number)
{
	stringstream ss;
	ss << Number;
	return ss.str();
}

Data_process::Data_process(string vis_namee, int indexx,string fd_namee, string data_typee, string size_sufxx )
{
	vis_name = vis_namee;
	index = indexx;
	fd_name = fd_namee;
	data_type = data_typee;
	size_sufx = size_sufxx;
	Evo_dynam();
	cout << "A class of Data_process is constructed." << endl << endl;
}

void Data_process::set_process_ctrl(string vis_namee, int indexx,string data_typee, string size_sufxx )
{
	vis_name = vis_namee;
	index = indexx;
	fd_name = vis_name + "_" + n2s(index);

	data_type = data_typee;
	size_sufx = size_sufxx;
}

void Data_process::evo_exe_cetr()
{
	set_ini_cond();
	IBV_cetr();
	dmcr_evo();
}

void Data_process::create_folder(void) const
{
	const char * s = fd_name.c_str();
	/*windows use _mkdir(s); and linux use int result = mkdir(s, 0777);*/
	_mkdir(s);
	//int result = mkdir(s, 0777);

}


string Data_process::get_save_path(string name) const
{
	string path;
	path = fd_name + "/" + name;

	return path;
}


void Data_process::save_data_univ(rowvec & f, string name)
{
	name = "R1_" + name;
	name = get_save_name_univ(name);
	f.save(name, raw_binary);
}

void Data_process::save_data_univ(mat & f, string name)
{
	name = "R2_" + name;
	name = get_save_name_univ(name);
	f.save(name, raw_binary);
}

void Data_process::save_data_univ(cube & f, string name)
{
	name = "R3_" + name;
	name = get_save_name_univ(name);
	f.save(name, raw_binary);
}

void Data_process::save_data_univ(uvec & f, string name)
{
	rowvec ff(f.n_elem);
	int i;
	for (i = 0; i < f.n_elem; i++)
		ff(i) = f(i);
	save_data_univ(ff, name);
}

string Data_process::get_save_name_univ(string name)
{

	return get_save_path(get_save_name(name, data_type));

}


string Data_process::get_save_name(string name, string data_typee)
{
	name = name + "." + data_typee;

	return name;
}

void Data_process::save_data_and_size(rowvec & f, string name)
{
	save_data_univ(f, name);
	rowvec size(1);
	size(0) = f.n_elem;
	save_data_size(name, size_sufx, size);
}


void Data_process::save_data_and_size(mat & f, string name)
{
	save_data_univ(f, name);
	rowvec size(2);
	size(0) = f.n_rows; size(1) = f.n_cols;
	save_data_size(name, size_sufx, size);
}

void Data_process::save_data_and_size(cube & f, string name)
{
	save_data_univ(f, name);
	rowvec size(3);
	size(0) = f.n_rows; size(1) = f.n_cols; size(2) = f.n_slices;
	save_data_size(name, size_sufx, size);
}

void Data_process::save_data_and_size(uvec & f, string name)
{
	save_data_univ(f, name);
	rowvec size(1);
	size(0) = f.n_elem;
	save_data_size(name, size_sufx, size);
}

void Data_process::save_data_size(string name, string sufx, rowvec size)
{
	name = name + '_' + sufx;
	save_data_univ(size, name);

}


void Data_process::process()
{
	create_folder();
	save_info();
	save_track_info();
}

void Data_process::save_info(void)
{
	save_data_and_size(x, "x");
	save_data_and_size(T_i, "T_i");
	save_data_and_size(T, "T_out");
	trun_itr_diff();
	save_data_and_size(itr_dif, "itr_dif");
}

void Data_process::trun_itr_diff(void)
{
	rowvec itr_diff_tmp(N_itr);
	itr_diff_tmp = itr_dif(span(0, N_itr - 1));
	itr_dif = itr_diff_tmp;
}


void Data_process::rec_info(ofstream & out)
{
	rowvec para(13);
	fds name_para(13);
	string wt_string = "";
	out << "The data are stored in this text." << endl << "This is the " << vis_name << " case." 
		<< endl << "The initial boundary condition option is " << IB_type << endl << "The norm criterion is " << norm_type << endl<<endl;
	wt_string += "The parameters are:\n\n";

	para(0) = N; para(1) = N_max; para(2) = N_itr; para(3) = err_bnd; para(4) = h; para(5) = x_low; para(6) = x_sup; para(7) = index; para(8) = err_i; para(9) = err_f;
	para(10) = M; para(11) = M_fac; para(12) = track_ctrl;
	name_para(0) = "N"; name_para(1) = "N_max"; name_para(2) = "N_itr"; name_para(3) = "err_bnd"; name_para(4) = "h"; name_para(5) = "x_low"; 
	name_para(6) = "x_sup"; name_para(7) = "index"; name_para(8) = "err_i"; name_para(9) = "err_f";
	name_para(10) = "M"; name_para(11) = "M_fac"; name_para(12) = "track_ctrl";
	wt_string += get_str_from_tp(para, name_para);
	out << wt_string;

}


string Data_process::get_str_from_tp(rowvec & v, fds & str)
{
	string s = "";
	int n = str.n_elem, i;
	for (i = 0; i < n; i++)
	{
		s += str(i) + " = " + num2str(v(i)) + "\n";
	}
	s += "\n";
	return s;
}

void Data_process::write_log()
{
	string name = "log", wt_string = "";
	name += "_" + vis_name;
	name = get_save_path(get_save_name(name, "txt"));
	// windows use ofstream out(name); linux use ofstream out(name.c_str());
	ofstream out(name.c_str());
	rec_info(out);
	out.close();
}


void Data_process::save_track_info(void)
{
	if (track_ctrl == 1)
	{
		save_data_and_size(T_track,"T_track");
		save_data_and_size(ind_track,"ind_track");
	}
}