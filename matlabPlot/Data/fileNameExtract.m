%file name test

str = 'Data_Kp_1_Ki_3';
% str = 'ABCD_01 36_00 3 .txt';
% t = str2double( regexp(str,'.* (\d+)_.* (\d+)','tokens','once') )
t =  str2double(regexp(str,'Data_Kp_') )

C = strsplit(str,'_')
str2double(C(3))