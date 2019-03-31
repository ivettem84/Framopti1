%SIMULACION DE DATOS ENTRENADOS
% at1=sim(net,x);
% at1=(at1*ns);
%TS=(TS*ns)

load pacientesreal.dat
load tarreal.dat

x1=pacientesreal;


edad = x1(1,:)/100;
sexo = x1(2,:);
imc= x1(3,:)/100;
sisto= x1(4,:)/162;
dias=x1(5,:)/115;
fuma=x1(6,:);
padre= x1(7,:)/2;

pn2=[edad; sexo; imc; sisto; dias; fuma; padre];

rtarg=tarreal;
num=length(rtarg);

%SIMULANDO DATOS PRONOSTICADOS
entr=sim(net,pn2);
sim1 = entr*100;
sim2=round(sim1);

%IMPRIMIR SOLO EL PRONOSITICO
pronostico1=rtarg;

 for j=1:num
     pronostico1(1,j)=sim2(1,j);
 end
 
 pronostico1=round(pronostico1);

%%%%%%%%%%%%%%%%%%%%
%INTEGRACION POR PROMEDIO

   prom=pronostico1;
   for iii=1:12
   erroresga(iii)=abs(rtarg(iii)-pronostico1(iii));  
   mse_calc(iii) = sum((rtarg(iii)-pronostico1(iii)).^2)/length(rtarg);
   end

   %mse_calc = sum((y-targets).^2)/length(y);

errorestfpa=0;
for ii=1:12
   errorestfpa=errorestfpa+mse_calc(ii);
end

errorestfpa=errorestfpa/12;
