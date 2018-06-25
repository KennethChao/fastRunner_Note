clc;
clear;
close all;
figure()
kpMax = 20;
kdMax = 7;
sampledNum = 200;


T = 0.5;
aMin =0.3*T;
aMax = 0.5*T;
sampledNum2 = 10;


kpSampled = 0:kpMax/(sampledNum-1):kpMax;
kdSampled = 0:kdMax/(sampledNum-1):kdMax;
aSampled = aMin:(aMax-aMin)/(sampledNum2-1):aMax;


if aMin == aMax
[X,Y] = meshgrid(kpSampled,kdSampled);
Z = aMin;
sampledNum2 = 1;
else
[X,Y,Z] = meshgrid(kpSampled,kdSampled,aSampled);
end
Map = X;

m = 1;
I = 10;

for i = 1:size(X,1)
    for j = 1:size(X,2)
        for k = 1:size(X,3)

            if aMin == aMax
                kp = X(i,j);
                kd = Y(i,j);      
                a = Z;

                f = T/a*m*9.81;
                K = 1/2*f/I*kp;
                C = 1/2*f/I*kd;

                A = [1-a^2*K T-a^2*C; 
                    -2*a*K 1-2*a*C];
                qq = abs(eig(A));
                if qq(1)<1 && qq(2)<1
                    Map(i,j) = max(qq);
                else
                    Map(i,j) = nan ;
                end
            else    
                kp = X(i,j,k);
                kd = Y(i,j,k);      
                a = Z(i,j,k);

                f = T/a*m*9.81;
                K = 1/2*f/I*kp;
                C = 1/2*f/I*kd;

                A = [1-a^2*K T-a^2*C; 
                    -2*a*K 1-2*a*C];
                qq = abs(eig(A));
                if qq(1)<1 && qq(2)<1
                    Map(i,j,k) = max(qq);
                else
                    Map(i,j,k) = nan ;
                end
            end
        end
    end
end
if aMin == aMax
    h=surf(X,Y,Map);
    set(h,'EdgeColor','none','FaceColor','interp');
    
    set(h,'DefaultTextFontName','Times','DefaultTextFontSize',18,...
       'DefaultAxesFontName','Times','DefaultAxesFontSize',18,...
    'DefaultLineLineWidth',1,'DefaultLineMarkerSize',7.75)
    colorbar
    str = sprintf('$T = %.3f$, $a = %.3f$, $f = %0.3f$', T,a,f);
    title(str,'Interpreter','latex','FontName','Times','FontWeight','Normal')    
    
    xlabel('$kp$','Interpreter','latex')
    ylabel('$kd$','Interpreter','latex')
        axis([0 10 0 10])
    view(2)

else
    h=slice(X,Y,Z,Map/max(max(max(Map))),kpSampled,kdSampled,aSampled);

    set(h,'EdgeColor','none','FaceColor','interp');
    alpha(0.4);

    axis([0 kpMax 0 kdMax aMin aMax])
    
    set(h,'DefaultTextFontName','Times','DefaultTextFontSize',18,...
       'DefaultAxesFontName','Times','DefaultAxesFontSize',18,...
    'DefaultLineLineWidth',1,'DefaultLineMarkerSize',7.75)
    colorbar
    xlabel('$kp$','Interpreter','latex')
    ylabel('$kd$','Interpreter','latex')
    zlabel('$\alpha$','Interpreter','latex')
    az = -45;
    el = 69;
    view(az, el);
    
        view(2)
end
     
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    % alpha(0.5);