clc;
close all;
tspan = 0:0.01:100;


[t,x] = ode45(@dym,tspan,[-0.5;0.01;0;0]);
x(:,2) = x(:,2)/100;
plot(x(:,1:2))

unshiftedX = x(1:(end-1),:)';

shiftedX = x(2:(end),:)';
[evals,modes,Atilde] = tdmd(unshiftedX,shiftedX,length(unshiftedX));
evals

function dx = dym(t,x)

I = 1.45e-4;
m = 0.5164;

k = 2.69;
kTheta = 7.86*1e-4;
e = 0.5*9.28*1e-3;

A = [ 0  0        1 0;
      0  0        0 1;
     -k/m -e/m        -0  0;      
     -e/I -kTheta/I   0 -0];

dx = A*x;%+[0;0;1;0]*10*cos(100*t);
    


end