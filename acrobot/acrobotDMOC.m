%main run function for acrobot DMOC

clear all;
close all;

%start matlabpool if not already running

load acrobotTraj2;

yab = yab';

h = tab(2) - tab(1);
N = length(tab);

load acrobotparams;

qd = yab(1:2,:);

%initial guess for fmincon
optimInitGuess = [qd; uab];
% optimInitGuess(1,:) = linspace(0,pi,N);
% optimInitGuess(2,:) = zeros(1,N);
% optimInitGuess(3,:) = zeros(1,N);

%linear inequalities for fmincon
A = [];
B = [];

%linear equalities for fmincon
Aeq = [];
Beq = [];

%lower and upper bounds for fmincon
LB = [-pi; -pi; -200];
UB = [pi; pi; 200];

%fmincon options
maxiter = 100;
options = optimset('Algorithm','sqp','UseParallel','always','MaxIter',maxiter,'Display','iter');

tic;
[optimTraj,fval,exitflag,output,lambda,grad,hessian] = fmincon(@acrobotObFun,optimInitGuess,A,B,Aeq,Beq,LB,UB,@acrobotConstraints,options,tab,params);
toc;

%%
figure;
hold on;
plot(tab,optimInitGuess(1,:),'k.-','LineWidth',2);
plot(tab,optimTraj(1,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q1');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,optimInitGuess(2,:),'k.-','LineWidth',2);
plot(tab,optimTraj(2,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q2');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,optimInitGuess(3,:),'k.-','LineWidth',2);
plot(tab,optimTraj(3,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Optimized Trajectory');


