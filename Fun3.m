function n = Fun3 (Sol,k1)


% load pacientestrain.dat
% load pacientestarg.dat
% 
% x=pacientestrain;
% ta=pacientestarg;


load paci100.dat
load pacitar1.dat 

x= paci100;
%ta= pacitar1;

edad = x(1,:)/100;
sexo = x(2,:);
imc= x(3,:)/100;
sisto= x(4,:)/162;
dias=x(5,:)/115;
fuma=x(6,:);
padre= x(7,:)/2;

x1=[edad; sexo; imc; sisto; dias; fuma; padre];
ta1=pacitar1/100;


disp('Iniciando Entrenamiento...');
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIMER MODULO %%%%%%%%%%%%%%%%%%%%%%%%%%
        
          disp('Inicia Modulo 1...');
%           
%           if(Chrom(i,1)==1)%Monolitica
%              display('Red monolitica en construccion')
%           elseif (Chrom(i,1)==2) % Modular
              if(Sol(1,1)==1)% 1 modulo y  1 capa
                  net=newff(minmax(x1),[Sol(1,2),1],{'tansig','purelin','logsig'},'trainlm');
              end
              
              if(Sol(1,1)==2)% 1 modulo y  2 capa
                  net=newff(minmax(x1),[Sol(1,2),Sol(1,3),1],{'tansig','tansig','purelin','purelin','logsig'},'trainlm');
              end
              

              net.LW{2,1} = net.LW{2,1}*0.05;
              net.b{2}=net.b{2}*0.01;
              net.trainParam.show=NaN;
              net.trainParam.goal=1e-7;
              net.trainParam.lr=0.001;
              net.trainParam.epochs = 250;
              net.trainParam.showWindow=0;
              [net,tr1]=train(net,x1,ta1);
          
          disp('Fin del entrenamiento de la Red monolitica');
          
   fnob2fpa();

   
   %filename = [ 'best' num2str(k1) '.mat' ];
% save(filename)
  n=errorestfpa;
  




