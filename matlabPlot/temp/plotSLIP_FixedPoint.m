close all
for i = 1:3
    plot(kVec,stableSolution(i,:),'bo')
    plot(kVec,unstableSolution(i,:),'ro')
    hold on
end
yticks([0,0.5,1])
axis([0 20, 0 1.1])

    xlabel('$k$','Interpreter','latex')
    ylabel('$\delta*$','Interpreter','latex')
    legend('unstable fixed points','stable fixed points')
    
  set(gca,'DefaultTextFontName','Times','DefaultTextFontSize',18,...
       'DefaultAxesFontName','Times','DefaultAxesFontSize',18,...
    'DefaultLineLineWidth',1,'DefaultLineMarkerSize',7.75)
%     colorbar
%     grid on
   