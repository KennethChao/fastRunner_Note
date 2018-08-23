close all

x = linspace(0,4,20);
y = linspace(-5,3,20);
[x,y] = meshgrid(x,y);
u = y;
v = -10*sin(x) - y +9;
quiver(x,y,u,v,5);
axis([0 4 -5 3])
