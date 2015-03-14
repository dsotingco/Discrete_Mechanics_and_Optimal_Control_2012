%make plots

%%
clear all;
close all;

load optimTraj3;
load dircolTraj1a;
load cartpoleparams;

figure;
hold on;
plot(tcp,optimInitGuess(1,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Position x');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

figure;
hold on;
plot(tcp,optimInitGuess(2,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Angle theta');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

figure;
hold on;
plot(tcp,optimInitGuess(5,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

disp(['Dircol cost: ' num2str(cartpoleObFunDircol(dircolTraj,tcp,params))]);
disp(['DMOC cost: ' num2str(cartpoleObFun(optimTraj,tcp,params))]);

%%
clear all;
close all

load optimTraj4;
load dircolTraj2;
load cartpoleparams;

figure;
hold on;
plot(tcp,optimInitGuess(1,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Position x');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

figure;
hold on;
plot(tcp,optimInitGuess(2,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Angle theta');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

figure;
hold on;
plot(tcp,optimInitGuess(5,:),'ko-','LineWidth',2);
plot(tcp,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tcp,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

disp(['Initial Guess cost: ' num2str(cartpoleObFunDircol(optimInitGuess,tcp,params))]);
disp(['Dircol cost: ' num2str(cartpoleObFunDircol(dircolTraj,tcp,params))]);
disp(['DMOC cost: ' num2str(cartpoleObFun(optimTraj,tcp,params))]);


