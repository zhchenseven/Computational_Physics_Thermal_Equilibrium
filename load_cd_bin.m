%% This script helps to load complex number
%%

%% test of binary double array
fileID = fopen('demo/a_bin.dat');
a = fread(fileID,[1 3],'double');
fclose(fileID);

%% test of binary double matrix
fileID = fopen('demo/e_bin.dat');
e = fread(fileID,[2 2],'double');
fclose(fileID);

%% test of binary complex array

fileID = fopen('demo/b_bin.dat');
b = fread(fileID,[1 6],'double');
fclose(fileID);

n=3;
C_b=complex(b(1:2:2*n-1),b(2:2:2*n));


%% test of binary complex matrix

fileID = fopen('demo/f_bin.dat');
f = fread(fileID,[1 12],'double');
fclose(fileID);
m=3;
n=2;
N=m*n;
C_f=complex(f(1:2:2*N-1),f(2:2:2*N));
C_f=reshape(C_f,[m,n]);
