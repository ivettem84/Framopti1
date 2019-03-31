

function [best,fmin,N_iter]=fpann(para)
warning off
for k1=11:15
% Default parameters
% if nargin<1
%    para=[50 0.8];
% end

comienza=now;

n=[5 8 10 12 14 16 18 20 22 24 26 28 30 32 34];           % Population size, typically 10 to 25
p=[0.2 0.7 0.6 0.4 0.1 0.8 0.9 0.3 0.5 0.7 0.2 0.8 0.4 0.5 0.6];           % probabibility switch
% Iteration parameters
N_iter=[2000 1250 1000 833 714 625 556 500 455 417 385 357 333 313 294];            % Total number of iterations

n=n(k1);
p=p(k1);
N_iter=N_iter(k1);

s1=pwd; %Identify current folder
s2=['\erroresFPAoc1702-' num2str(k1) '.txt'];
%$s2='\erroresFPA0810.txt';
dir = strcat(s1,s2);
%--crear arhivo para guardar errores
error1= fopen(dir, 'wt');

d=3;

% Lb=0*ones(1,d);
% Ub=30*ones(1,d);

Lb=[1 1 1];
Ub=[2 30 30];

% Initialize the population/solutions
for i=1:n
  Sol(i,:)=round(Lb+(Ub-Lb).*rand(1,d));
  Fitness(i)=Fun3(Sol(i,:));
  fprintf(error1,['Error:' num2str(Fitness(i)) ' Iteracion:' int2str(i) ' Individuos:' int2str(i) ' Capas: ' int2str(Sol(i,1)) ' Neuronas capa 1: ' int2str(Sol(i,2))  ' Neuronas Capa 2: ' int2str(Sol(i,3)) '\n']); 
end

% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
S=Sol; 
fprintf(error1,['\n----------------------------------------\n\n']);
% Start the iterations -- Flower Algorithm 
for t=1:N_iter
        % Loop over all bats/solutions
        for i=1:n
          % Pollens are carried by insects and thus can move in
          % large scale, large distance.
          % This L should replace by Levy flights  
          % Formula: x_i^{t+1}=x_i^t+ L (x_i^t-gbest)
          if rand>p
          %% L=rand;
          L=Levy(d);
          dS=L.*(Sol(i,:)-best);
          S(i,:)=Sol(i,:)+dS;
          
          % Check if the simple limits/bounds are OK
          S(i,:)=simplebounds(S(i,:),Lb,Ub);
          
          % If not, then local pollenation of neighbor flowers 
          else
              epsilon=rand;
              % Find random flowers in the neighbourhood
              JK=randperm(n);
              % As they are random, the first two entries also random
              % If the flower are the same or similar species, then
              % they can be pollenated, otherwise, no action.
              % Formula: x_i^{t+1}+epsilon*(x_j^t-x_k^t)
              S(i,:)=S(i,:)+epsilon*(Sol(JK(1),:)-Sol(JK(2),:));
              % Check if the simple limits/bounds are OK
              S(i,:)=simplebounds(S(i,:),Lb,Ub);
          end
          
           S=round(S);
           
          % Evaluate new solutions
           Fnew=Fun3(S(i,:));
          % If fitness improves (better solutions found), update then
            if (Fnew<=Fitness(i))
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
        
        fprintf(error1,['Error:' num2str(Fitness(i)) ' Iteracion:' int2str(i) ' Individuos:' int2str(i) ' Capas: ' int2str(Sol(i,1)) ' Neuronas capa 1: ' int2str(Sol(i,2))  ' Neuronas Capa 2: ' int2str(Sol(i,3))  '\n']);
           end
           
          % Update the current global best
          if Fnew<=fmin
                best=S(i,:)   ;
                fmin=Fnew   ;
          end
        end

        % Display results every 100 iterations
        if round(t/100)==t/100
        best
        fmin
        end
        
end
% 
%     figure
%     plot(best)
% Output/display
% figure(1)
% plot(1:N_iter,log10(fmin))
% xlabel('Iterations');
% ylabel('Best');

termina=now;%%%%%%%%% TIEMPO FINAL
fprintf(error1,['\n----------------------------------------\n\n']);
fprintf(error1,['Best Solution:' num2str(best) ' fmin=',num2str(fmin) '   FPA time:', datestr(termina-comienza,'HH:MM:SS') '\n']);
disp(['Total number of evaluations: ',num2str(N_iter*n)]);
disp(['Best solution=',num2str(best),'   fmin=',num2str(fmin) '   FPA time:', datestr(termina-comienza,'HH:MM:SS')]);



end 

% Application of simple constraints
function s=simplebounds(s,Lb,Ub)
  % Apply the lower bound
  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % Apply the upper bounds 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  % Update this new move 
  s=ns_tmp;


% Draw n Levy flight sample
function L=Levy(d)
% Levy exponent and coefficient
% For details, see Chapter 11 of the following book:
% Xin-She Yang, Nature-Inspired Optimization Algorithms, Elsevier, (2014).
beta=3/2;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
    u=randn(1,d)*sigma;
    v=randn(1,d); 
    step=u./abs(v).^(1/beta);
L=0.01*step; 

% Objective function and here we used Rosenbrock's 3D function
% function z=Fun(u)
% z=(1-u(1))^2+100*(u(2)-u(1)^2)^2+100*(u(3)-u(2)^2)^2;


