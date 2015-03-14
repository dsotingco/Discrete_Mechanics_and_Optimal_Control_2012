%main run function for acrobot DIRCOL

clear all;
close all;

%start matlabpool if not already running

load acrobotTraj2;

yab = yab';

h = tab(2) - tab(1);
N = length(tab);

load acrobotparams;

qd = yab(1:4,:);

%initial guess for fmincon
dircolInitGuess = [qd; uab];
% dircolInitGuess(1,:) = linspace(0,pi,N);
% dircolInitGuess(2,:) = zeros(1,N);
% dircolInitGuess(3,:) = zeros(1,N);
% dircolInitGuess(4,:) = zeros(1,N);
% dircolInitGuess(5,:) = zeros(1,N);

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
[dircolTraj,fval,exitflag,output,lambda,grad,hessian] = fmincon(@acrobotObFunDircol,dircolInitGuess,A,B,Aeq,Beq,LB,UB,@acrobotConstraintsDircol,options,tab,params);
toc;

%%
figure;
hold on;
plot(tab,dircolInitGuess(1,:),'k.-','LineWidth',2);
plot(tab,dircolTraj(1,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q1');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,dircolInitGuess(2,:),'k.-','LineWidth',2);
plot(tab,dircolTraj(2,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q2');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,dircolInitGuess(3,:),'k.-','LineWidth',2);
plot(tab,dircolTraj(3,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q1dot');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,dircolInitGuess(4,:),'k.-','LineWidth',2);
plot(tab,dircolTraj(4,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot q2dot');
legend('Initial Guess','Optimized Trajectory');

figure;
hold on;
plot(tab,dircolInitGuess(5,:),'k.-','LineWidth',2);
plot(tab,dircolTraj(5,:),'b.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Optimized Trajectory');


