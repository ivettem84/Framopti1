clc;
clear;

load pacreealnew.dat
%load tarreal.dat

load('framinop280301.mat')

paciente=pacreealnew;



n=length(paciente);

for i=1:n

estudio = net(paciente);
riesgo(:,i)=round(estudio*100);

end
