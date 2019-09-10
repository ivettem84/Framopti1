clc;
clear;

% load pacientestrain.dat
% load pacientestarg.dat

load pacientestrain.dat
load pacientestarg.dat

x= pacientestrain;
ta1= pacientestarg;

edad = x(1,:)/100;
sexo = x(2,:);
imc= x(3,:)/100;
sisto= x(4,:)/162;
dias=x(5,:)/115;
fuma=x(6,:);
padre= x(7,:)/2;

x1=[edad; sexo; imc; sisto; dias; fuma; padre];
%ta1=pacientestarg/100;

net=newff(minmax(x1), [8,4,1], {'tansig','tansig','purelin','purelin'},'trainlm'); 
net.LW{1,1}=net.LW{1,1}*0.01;       %Pesos de conexiones
net.b{1}=net.b{1}*0.01;             %Umbrales
net.trainParam.show = 100;           % El resultado se muestra cada 100 épocas
net.trainParam.lr = 0.01;           % Tasa de aprendizaje usado en algún gradiente
net.trainParam.epochs =250;         % Máximo numero de iteraciones
net.trainParam.goal = 1e-10;          % Tolerancia de Error, criterio de parada
net.trainParam.min_grad=1e-11;         %Minimum performance gradient
%Start training
%net.trainParam.showWindow=0;
[net,tr1] = train(net,x1,ta1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulando datos entrenados
A1=sim(net,x1);
%Riesgo=round(A1);
% menos=(A1-t);
% mse_calc = sum((A1-t1).^2)/length(t);

%save('framin190805.mat')