function [fx] = load_dat(name_string,data_type,ind_cpx,dim)
%% This function helps load the data from dat, data_type='dat', ind_cpx=1 if complex number, =0 if double,dim='1d' or '2d'
name=[name_string '.' data_type];
if (ind_cpx==0)
    %% the case of the vec or the mat is real
    load(name);
    eval(['fx=' name_string ';' ]);
elseif strcmp(dim,'1d') & (ind_cpx==1)
    %% the case of the vec is complex
    id=fopen(name);
    C=textscan(id,'(%f,%f)');
    C=complex(C{1,1},C{1,2});
    fclose(id);
    fx=C;
else
    %% the case of the mat is complex, we need also the _size file to indicate the size(array=[n_row,n_col])
    id=fopen(name);
    C=textscan(id,'(%f,%f)');
    C=complex(C{1,1},C{1,2});
    fclose(id);
    eval(['fx=' name_string ';']);
    name_size=[name_string '_size.' data_type];  
    load(name_size);
    name_size=[name_string '_size'];
    eval(['arr_size=' name_size ';']);
    % the data is supposed to be m*n
    n=arr_size(2);
    N=length(C);
    m=N/n;
    fx=reshape(C,[m,n])';
    
end

end

