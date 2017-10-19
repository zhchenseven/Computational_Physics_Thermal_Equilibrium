# ifndef _DATA_PROCESS
# define _DATA_PROCESS

# include <iostream>
# include <armadillo>
# include "Evo_dynam.h"
# include <iomanip>



using namespace std;
using namespace arma;

typedef field<std::string> fds;

class Data_process :public Evo_dynam
{
public:
	string vis_name;
	int index;
	string fd_name;
	string data_type;
	string size_sufx;



	Data_process(string vis_namee = "", int indexx = 0, string fd_namee = "", string data_typee = "", string size_sufxx = "");

	void set_process_ctrl(string vis_namee, int indexx, string data_typee = "dat", string size_sufxx = "size");
	string get_save_path(string name) const;

	void evo_exe_cetr();
	void process();
	void write_log();

	void create_folder(void) const;

	void save_data_univ(rowvec &, string name);
	void save_data_univ(mat &, string name);
	void save_data_univ(cube &, string name);

	void save_data_univ(uvec &, string name);

	string get_save_name_univ(string name);
	string get_save_name(string name, string data_typee);

	void save_data_and_size(rowvec &, string name);
	void save_data_and_size(mat &, string name);
	void save_data_and_size(cube &, string name);
	void save_data_and_size(uvec &, string name);
	void save_data_size(string name, string sufx, rowvec size);

	void save_info(void);
	void trun_itr_diff(void);


	void rec_info(ofstream & out);
	string get_str_from_tp(rowvec &, fds &);

	void save_track_info(void);

	template <typename T>
	std::string num2str(const T a_value, const int n = 10)
	{
		ostringstream out;
		out << std::setprecision(n) << a_value;
		return out.str();
	}

};



#endif
