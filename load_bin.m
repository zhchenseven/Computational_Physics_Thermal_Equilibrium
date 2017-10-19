function [ fx ] = load_bin(name_string,data_type, dim, ind_cpx, size_sufx)
%% load binary data including four cases, double array, double matrix, complex array, complex matrix
%% data_type='dat', dim='1d','2d', ind_cpx=1, if complex number, =0 if double, 
%% size_sufx= the string of suffix to show the size, name_string is the string of the name

name_size=[str_mod_size_info(name_string) '_' size_sufx '.' data_type];

fileID = fopen(name_size);
if strcmp(dim,'2d')
    size = fread(fileID,[1 2],'double');
else
    size = fread(fileID,[1 1],'double');
end   
fclose(fileID);
name=[name_string '.' data_type];
if strcmp(dim,'1d')
        n=size(1);
        if ind_cpx==0
            fileID = fopen(name);
            fx = fread(fileID,[1 n],'double');
            fclose(fileID);
        else
            fileID = fopen(name);
            fx = fread(fileID,[1 2*n],'double');
            fclose(fileID);
            fx=complex(fx(1:2:2*n-1),fx(2:2:2*n));
        end
else
    m=size(1);
    n=size(2);
    if ind_cpx==0
        fileID = fopen(name);
        fx = fread(fileID,[m n],'double');
        fclose(fileID);
    else
        fileID = fopen(name); 
        N=m*n;
        f = fread(fileID,[1 2*N],'double');
        fclose(fileID);
        fx=complex(f(1:2:2*N-1),f(2:2:2*N));
        fx=reshape(fx,[m,n]);
    end
end
    
        
    
end

