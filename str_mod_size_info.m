function [ name_string ] = str_mod_size_info(name_string)
%% This function searches the information of string to read the first two characters after /
for i=1:length(name_string)
    if strcmp(name_string(i),'/')
        break;
    end
end

name_string(i+1:i+2)='R1';
    

end

