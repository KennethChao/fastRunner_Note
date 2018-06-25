clc
syms a zd f 
syms kp kd kpt kdt

A = [0 0 1 0 ;
     -kp 0 -kd 0 ;
     0 0 0 1 ;
     0 -kpt 0 -kdt]
 

%% first flight


B = [0;0;0;0];

Xe = [-A^-1*B]

