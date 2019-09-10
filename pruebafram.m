clc;
clear;


load pacreealnew.dat
load pacreealnewtar.dat

% load pactst.dat
% load tarpactstreal.dat

%x= pactst;

x=pacreealnew;
rtarg=pacreealnewtar;

edad = x(1,:)/100;
sexo = x(2,:);
imc= x(3,:)/100;
sisto= x(4,:)/162;
dias=x(5,:)/115;
fuma=x(6,:);
padre= x(7,:)/2;

paciente=[edad; sexo; imc; sisto; dias; fuma; padre];

load('framin190805.mat')




n=length(paciente);

for i=1:n

estudio = net(paciente);
riesgo(:,i)=round(estudio*100);

end

p1 = 1:1:numel(rtarg);
figure

plot(p1,rtarg,'-ro',p1,riesgo,'-.b');
title(strcat('BSA Best experiment, MSE : 0.0004'));
%title(strcat('Real Patients Comparison, MSE : 0.0004'));
xlabel('Patients')
ylabel('% of risk within incoming 4 years')
hleg1 = legend('Target','NN');
