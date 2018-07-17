% TODO add reference for the system, add comments for the purpose of this
% code

k = 20;
beta = 74/180*pi;
delta = 4;
g = 0.46;
parms = {};
parms.g = g;
parms.beta = beta;
parms.k = k;

close all;
f = @(t,a) dymModelStance(t,a, parms);

% x0 = [16.21325444114593,-55.78140243373939,249];
% for xdot = 0.3:1:10
% x0 = [1.5, xdot];

tspan = 0:0.01:200;
options = odeset('Event',@slipEventFcn)
x0 = [1,-cos(beta-delta),beta,sin(beta-delta)]
[t,a] = ode45(f,tspan,x0,options);     % Runge-Kutta 4th/5th order ODE solver

figure()
plot(a(:,[1 3]))
x = a(:,1).*cos(a(:,3))*-1;
y = a(:,1).*sin(a(:,3));

figure()
plot(x,y);

y0 = a(end,1)*sin(a(end,3));
yd0 = a(end,2)*cos(a(end,3)-pi/2);
x0 = [y0,yd0]
options = odeset('Event',@(t,x)tdEventFcn(t,x,beta));
f = @(t,a) dymModelFlight(t,a, parms);
[t,a] = ode45(f,tspan,x0,options);     % Runge-Kutta 4th/5th order ODE solver
figure()
plot(a(:,[1]))




% end

function dx = dymModelStance(t,x,parms)
%
g = parms.g;
k = parms.k;
%
l = x(1);
ld = x(2);
theta = x(3);
thetad = x(4);

ldd = l*thetad^2-k*(l-1)-g*sin(theta);
thetadd = (-g*l*cos(theta)-2*l*ld*thetad)/l^2;

dx = [ld;ldd;thetad;thetadd];

end

function dx = dymModelFlight(t,x,parms)
%
g = parms.g;
yd = x(2);
ydd = -g;

dx = [yd;ydd];

end


function [position,isterminal,direction] = slipEventFcn(t,x)
position = x(1)-1; % The value that we want to be zero
isterminal = 1;  % Halt integration 
direction = 1;   % The zero can be approached from either direction
end

function [position,isterminal,direction] = tdEventFcn(t,x,beta)
position = x(1)-sin(beta); % The value that we want to be zero
isterminal = 1;  % Halt integration 
direction = -1;   % The zero can be approached from either direction
end