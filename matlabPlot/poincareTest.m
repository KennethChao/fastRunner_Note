% TODO add reference for the system, add comments for the purpose of this
% code

sigma = 10;
beta = 8/3;
rho = 28;
parms = {};
parms.sigma = sigma;
parms.beta = beta;
parms.rho = rho;

close all;
f = @(t,a) dymModel(t,a);

% x0 = [16.21325444114593,-55.78140243373939,249];
for xdot = 0.3:1:10
x0 = [1.5, xdot];
[t,a] = ode45(f,[0 100],x0);     % Runge-Kutta 4th/5th order ODE solver
plot(a(:,1),a(:,2))

hold on
end

function da = dymModel(t,a)
x = a(1);
y = a(2);

dx = 0.4*x-0.001*x*y;
dy = -0.3*y+0.5*x*y;

da = [dx;dy];
end