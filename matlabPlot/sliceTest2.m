clc;
clear;
close all;
% figure()
kpMax = 4;
kdMax = 4;
sampledNum = 200;

aMin = 1;
aMax = 3;
sampledNum2 = 20;


kpSampled = 0:kpMax/(sampledNum-1):kpMax;
kdSampled = 0:kdMax/(sampledNum-1):kdMax;
aSampled = aMin:(aMax-aMin)/(sampledNum2-1):aMax;

[X,Y,Z] = meshgrid(kpSampled,kdSampled,aSampled);
%[X,Y,Z] = meshgrid(0:20/100:10,0:10/100:5,0.2:0.005:0.3);

% [X,Y] = meshgrid(kpSampled,kdSampled);
Map = X;
T = 1;
ratio = 0.3;
a = 0.2
m = 1;
I = 10;

for i = 1:size(X,1)
    for j = 1:size(X,2)
        for k = 1:size(X,3)

            kp = X(i,j,k);
            kd = Y(i,j,k);      
            T = Z(i,j,k);
            a = T*ratio;
            f = T/a*m*9.81;
            K = 1/2*f/I*kp;
            C = 1/2*f/I*kd;

            A = [1-a^2*K T-a^2*C; 
                -2*a*K 1-2*a*C];
            qq = abs(eig(A));
            if qq(1)<1 && qq(2)<1
                Map(i,j,k) = abs(det(A));
            else
                Map(i,j,k) = nan ;
            end
        end
    end
end

h=slice(X,Y,Z,Map/max(max(max(Map))),kpSampled,kdSampled,aSampled);


% h=slice(X,Y,Z,Map,X,Y,Z);
% h = interp3(Map);
set(h,'EdgeColor','none','FaceColor','interp');
% axis equal
alpha(0.4);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       % h=surface(Map)
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          set(h,'EdgeColor','none','FaceColor','interp');

set(h,'DefaultTextFontName','Times','DefaultTextFontSize',18,...
   'DefaultAxesFontName','Times','DefaultAxesFontSize',18,...
'DefaultLineLineWidth',1,'DefaultLineMarkerSize',7.75)
colorbar
xlabel('$kp$','Interpreter','latex')
ylabel('$kd$','Interpreter','latex')
zlabel('$T$','Interpreter','latex')
az = -45;
el = 69;
view(az, el);

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    % alpha(0.5);