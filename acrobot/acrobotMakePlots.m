%make plots for acrobot

%%
%initial guess of zeros, 10 iterations
clear all;
close all;

load dircolguesszero10;
load dmocguesszero10;

%plot q1
figure;
hold on;
plot(tab,dircolInitGuess(1,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tab,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q1');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot q2
figure;
hold on;
plot(tab,dircolInitGuess(2,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tab,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q2');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot u
figure;
hold on;
plot(tab,dircolInitGuess(5,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tab,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%% 
%initial guess of energy, 10 iterations
clear all;
close all;

load dircolguessenergy10;
load dmocguessenergy10;

%plot q1
figure;
hold on;
plot(tab,dircolInitGuess(1,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tab,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q1');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot q2
figure;
hold on;
plot(tab,dircolInitGuess(2,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tab,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q2');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot u
figure;
hold on;
plot(tab,dircolInitGuess(5,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tab,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%%
%initial guess of zeros, 100 iterations
clear all;
close all;

load dircolguesszero100b;
load dmocguesszero100b;

%plot q1
figure;
hold on;
plot(tab,dircolInitGuess(1,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tab,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q1');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot q2
figure;
hold on;
plot(tab,dircolInitGuess(2,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tab,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q2');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot u
figure;
hold on;
plot(tab,dircolInitGuess(5,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tab,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%% 
%initial guess of energy, 100 iterations
clear all;
close all;

load dircolguessenergy100b;
load dmocguessenergy100b;

%plot q1
figure;
hold on;
plot(tab,dircolInitGuess(1,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(1,:),'bd-','LineWidth',2);
plot(tab,optimTraj(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q1');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot q2
figure;
hold on;
plot(tab,dircolInitGuess(2,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(2,:),'bd-','LineWidth',2);
plot(tab,optimTraj(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Angle q2');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');

%plot u
figure;
hold on;
plot(tab,dircolInitGuess(5,:),'ko-','LineWidth',2);
plot(tab,dircolTraj(5,:),'bd-','LineWidth',2);
plot(tab,optimTraj(3,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot Control Effort');
legend('Initial Guess','Dircol Trajectory','DMOC Trajectory');