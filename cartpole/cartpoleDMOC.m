%main run function for cartpole DMOC

clear all;
close all;

%start matlabpool if not already running

load cartpoleTraj3;

tcp = tcp';
ycp = ycp';

h = tcp(2) - tcp(1);
N = length(tcp);

load cartpoleparams;
% %pack params
% params.mc = 10;
% params.mp = 1;
% params.l = 0.5;
% params.g = 9.8;

qd = ycp(1:2,:);

%ud contains both force (in row 1) and the torque which is zero (in row 2)
ud = zeros(2,N);
ud(1,:) = ucp;

%initial guess for fmincon
% optimInitGuess = [qd; ucp];
optimInitGuess(1,:) = zeros(1,N);   
optimInitGuess(2,:) = linspace(0,pi,N); 
optimInitGuess(3,:) = zeros(1,N);

%linear inequalities for fmincon
A = [];
B = [];

%linear equalities for fmincon
Aeq = [];
Beq = [];

%lower and upper bounds for fmincon
LB = [];
UB = [];

%fmincon options
% options = optimset('Algorithm','sqp','UseParallel','always','PlotFcns',@optimplotx);
maxiter = 100;
options = optimset('Algorithm','sqp','UseParallel','always','MaxIter',maxiter,'Display','iter');

tic;
[optimTraj,fval,exitflag,output,lambda,grad,hessian] = fmincon(@cartpoleObFun,optimInitGuess,A,B,Aeq,Beq,LB,UB,@cartpoleConstraints,options,tcp,params);
toc;

%%
[tcheck,ycheck] = cartpolePlayUtape(tcp,optimTraj(3,:));    %double-check to see if dynamics were enforced
%the double-check may not work because it's open-loop...any little
%deviation sends it off course...

%%
figure;
hold on;
plot(tcp,optimInitGuess(1,:),'k.-','LineWidth',2);
plot(tcp,optimTraj(1,:),'bo-','LineWidth',2);
plot(tcheck,ycheck(1,:),'r.-','LineWidth',2);
xlabel('Time')
ylabel('Cartpole Position x');
legend('Initial Guess','Optimized Trajectory','Utape checker');

figure;
hold on;
plot(tcp,optimInitGuess(2,:),'k.-','LineWidth',2);
plot(tcp,optimTraj(2,:),'bo-','LineWidth',2);
plot(tcheck,ycheck(2,:),'r.-','LineWidth',2);
xlabel('Time')
ylabel('Cartpole Angle theta');
legend('Initial Guess','Optimized Trajectory','Utape checker');

figure;
hold on;
plot(tcp,optimInitGuess(3,:),'k.-','LineWidth',2);
plot(tcp,optimTraj(3,:),'b.-','LineWidth',2);
xlabel('Time')
ylabel('Cartpole Input Force');
legend('Initial Guess','Optimized Trajectory');

