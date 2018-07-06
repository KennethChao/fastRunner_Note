clc;
clear;
close all;

kpMax = 200;
kdMax = 200;
sampledNum = 200;

aMin = 2 ;
aMax = 2;
sampledNum2 = 20;


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
ratio = 0.1;
m = 1;
I = 10;

for i = 1:size(X,1)
    for j = 1:size(X,2)
        for k = 1:sampledNum2

            
            if aMin == aMax
                kp = X(i,j);
                kd = Y(i,j);      
                T = Z;
                a = T*ratio;
                f = T/a*m*9.81;
                K = 1/2*f/I*kp;
                C = 1/2*f/I*kd;

%                 A = [1-a^2*K T-a^2*C; 
%                     -2*a*K 1-2*a*C];
A = [ (exp(-a*(C + (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) - C*exp(-a*(C + (C^2 - 2*K)^(1/2))) + exp(-a*(C - (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) + C*exp(-a*(C - (C^2 - 2*K)^(1/2))))/(2*(C^2 - 2*K)^(1/2)), (exp(-a*(C - (C^2 - 2*K)^(1/2))) - exp(-a*(C + (C^2 - 2*K)^(1/2))))/(2*(C^2 - 2*K)^(1/2)) + ((T - a)*(exp(-a*(C + (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) - C*exp(-a*(C + (C^2 - 2*K)^(1/2))) + exp(-a*(C - (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) + C*exp(-a*(C - (C^2 - 2*K)^(1/2)))))/(2*(C^2 - 2*K)^(1/2));
                                                                                                             (K*exp(-a*(C + (C^2 - 2*K)^(1/2))) - K*exp(-a*(C - (C^2 - 2*K)^(1/2))))/(C^2 - 2*K)^(1/2), (exp(-a*(C + (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) + C*exp(-a*(C + (C^2 - 2*K)^(1/2))) + exp(-a*(C - (C^2 - 2*K)^(1/2)))*(C^2 - 2*K)^(1/2) - C*exp(-a*(C - (C^2 - 2*K)^(1/2))))/(2*(C^2 - 2*K)^(1/2)) + ((T - a)*(K*exp(-a*(C + (C^2 - 2*K)^(1/2))) - K*exp(-a*(C - (C^2 - 2*K)^(1/2)))))/(C^2 - 2*K)^(1/2)];
                try
                qq = abs(eig(A));
                    if qq(1)<1 && qq(2)<1
                        Map(i,j) = max(qq);
                    else
                        Map(i,j) = nan ;
                    end  
                catch
                Map(i,j) = nan ;    
                end
            else
                kp = X(i,j,k);
                kd = Y(i,j,k);      
                T = Z(i,j,k);
                a = T*ratio;
                f = T/a*m*9.81;
                K = 1/2*f/I*kp;
                C = 1/2*f/I*kd;

%                 A = [1-a^2*K T-a^2*C; 
%                     -2*a*K 1-2*a*C];
A = [           1,          T - a + exp(a);
 exp(-2*K*a), exp(-2*K*a)*(T - a) + 1]               ;                    
                qq = abs(eig(A));
%                 if real(qq(1))<0 && real(qq(2))<0
%                 if qq(1)<1 && qq(2)<1
                    Map(i,j,k) = abs(det(A));%max(qq);
%                 else
%                     Map(i,j,k) = nan ;
%                 end              
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
    view(2)
    axis([0 kpMax 0 kdMax])
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
    zlabel('$T$','Interpreter','latex')
    az = -45;
    el = 69;
    view(az, el);
    view(2)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    % alpha(0.5);