function [fx ] = load_bin_main(dir_name,name_string,data_type,size_sufx,ind )
%% This functions invoke the fundamental load_bin to read data including all cases of 1/2 D  double/complex
s=name_string(1:2);
if s(1)=='R'
    ind_cpx=0;
elseif s(1)=='C'
    ind_cpx=1;
else
    fprintf(['the read of data type: ' name_string(1) ' is not included.\n']);
end

if s(2)=='1'
    dim='1d';
elseif s(2)=='2'
    dim='2d';
else
    fprintf(['the read of data dimension: ' name_string(2) ' is not included.\n']);
end
dir_name=[dir_name '_' num2str(ind)];
% name_string=[name_string '_' num2str(ind)];
name_string=add_dir_name(dir_name,name_string);

[ fx ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx);
    

end

