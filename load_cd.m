%% This script helps to load complex number
%%
clear
load('a.dat');
load('e.dat');

% id2=fopen('b.dat');
% C=textscan(id2,'(%f,%f)');
% C=complex(C{1,1},C{1,2});
% fclose(id2);


id2=fopen('f.dat');
C1=textscan(id2,'(%f,%f)');
D1=textscan(id2,'%*[^%f)]');
C1=complex(C1{1,1},C1{1,2});
fclose(id2);


id3=fopen('g.dat');
C2=textscan(id3,'(%f,%f)');
D2=textscan(id3,'%s %*[^\r]');
C2=complex(C2{1,1},C2{1,2});
fclose(id3);

str=fileread('f.dat');
str2=fileread('g.dat');
