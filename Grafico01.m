%--------------------------------------------------------------------------
% Modelo RBC basico
% Codigo para realizar gr?ficos de las funciones impulso respuesta
% Codigo elaborado por: Carlos Rojas Quiroz
%--------------------------------------------------------------------------

clear all;

dynare RBC01.mod

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','innv','lab','w','r','kap','z'};
names  ={'PBI','Consumo', 'Inversion','Empleo','Salario real','Tasa de interes','Capital','Productividad'};
[nper,junk1] = size(y_e_z);
nvar = length(varble);
fecha = (0:1:nper)';

shock  = 'e_z';
size_shock = 1;
resp_mat0 = [];
for ii=1:nvar
    eval(['y1=',char(varble(ii)),'_',char(shock),';']);
    y1= y1*size_shock;
    y1=[0;y1];
    resp_mat0 = [resp_mat0 y1];
end
save('Model00','resp_mat0');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dynare RBC01d.mod

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','innv','lab','w','r','kap','z'};
names  ={'PBI','Consumo', 'Inversion','Empleo','Salario real','Tasa de interes','Capital','Productividad'};
[nper,junk1] = size(y_e_z);
nvar = length(varble);
fecha = (0:1:nper)';

shock  = 'e_z';
size_shock = 1;
resp_mat1 = [];
for ii=1:nvar
    eval(['y1=',char(varble(ii)),'_',char(shock),';']);
    y1= y1*size_shock;
    y1=[0;y1];
    resp_mat1 = [resp_mat1 y1];
end
save('Model01','resp_mat1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load Model00
load Model01

figure(1)
for ii=1:nvar
    subplot(2,4,ii);
    %plot(dates,resp_mat0(:,ii),'-r','LineWidth',1.5); 
    m=plot(fecha,resp_mat0(:,ii));
    set(m,'Color',[51/255 130/255 214/255],'LineWidth',2.5,'LineStyle','--');
    grid on; xlim([1 40]);
    hold on; 
    plot([0 40],[0 0],'-k','LineWidth',1.5)
    hold off;
    if ii>8
        xlabel('Trimestres','Fontsize',10)
    end
    ylabel('Desv. % EE','Fontsize',10)
    title(names(ii),'Interpreter','none','Fontsize',14);
   if ii==nvar
        legend('Modelo RBC basico');
   end
end

figure(2)
for ii=1:nvar
    subplot(2,4,ii);
    plot(fecha,resp_mat0(:,ii),'--r',fecha,resp_mat1(:,ii),'--b','LineWidth',2); 
    grid on; xlim([1 40]);
    hold on; 
    plot([0 40],[0 0],'-k','LineWidth',1.5)
    hold off;
    if ii>8
        xlabel('Trimestres','Fontsize',10)
    end
    ylabel('Desv. % EE','Fontsize',10)
    title(names(ii),'Interpreter','none','Fontsize',14);
   if ii==nvar
        legend('L variable','L fijo');
   end
end