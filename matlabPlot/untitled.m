clc;
clear


a = 0.3;
T = 1;
kp = 0.1;
kd = 0.4;

buf = [];
for kp = 0:0.1:30
    for a = 0:1/300:1

f = 140.143;
m = 10;
I = 10;
K = 1/2*f/I*kp;
C = 1/2*f/I*kd;

M = [1-a^2*K T; -2*a*K 1];

% A = [1-a^2*K T-a^2*C; 
%     -2*a*K 1-a^2*C];

eig(M);
qq = abs(eig(M));

% eig(A);
% qq = abs(eig(A));
%if qq(1)<1 && qq(2)<1
    buf = [buf;[kp,a,(det(M))]];
%end
    end
end

x = buf(:,1);
y = buf(:,2);
z = buf(:,3);

tri = delaunay(x,y);
plot(x,y,'.')

[r,c] = size(tri);
disp(r)

h = trisurf(tri, x, y, z);
axis vis3d
shading interp
%colorbar EastOutside
view(2);