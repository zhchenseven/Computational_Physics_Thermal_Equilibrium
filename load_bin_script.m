%% This script invokes the load_bin file to load binary files saved from cpp results.
clear
%% load double array
name_string='demo/a_bin';
data_type='dat';
dim='1d';
ind_cpx=0;
size_sufx='size';

[ a ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx);
%% load double matrix
name_string='demo/b_bin';
data_type='dat';
dim='1d';
ind_cpx=1;
size_sufx='size';

[ b ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx);
%% load complex array
name_string='demo/e_bin';
data_type='dat';
dim='2d';
ind_cpx=0;
size_sufx='size';

[ e ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx);
%% load double matrix
name_string='demo/f_bin';
data_type='dat';
dim='2d';
ind_cpx=1;
size_sufx='size';

[ f ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx);