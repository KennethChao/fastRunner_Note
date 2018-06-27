clc
syms  zd f 
syms kp kd kpt kdt

syms T a K C

A = [0 1; -2*K 0]
A = [0 1; -2*K -2*C]
B = [1 (T-a); 0 1]
%  exp(A)
exp(A*a)*B
%% first flight


% B = [0;0;0;0];

% Xe = [-A^-1*B]

% [1 a ; 0 1]* [1 T-a ; 0 1 ]