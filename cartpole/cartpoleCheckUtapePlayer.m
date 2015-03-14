%check the cartpolePlayUtape.m

clear all;
close all;

load cartpoleTraj3;
%gives you tcp,ycp,ucp

ycp = ycp';
[tcheck,ycheck] = cartpolePlayUtape(tcp,ucp);

figure;
hold on;
plot(tcp,ycp(1,:),'bo');
plot(tcheck,ycheck(1,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Position x');
legend('Original','U-tape checker');

figure;
hold on;
plot(tcp,ycp(2,:),'bo');
plot(tcheck,ycheck(2,:),'r.-','LineWidth',2);
xlabel('Time');
ylabel('Cartpole Angle theta');
legend('Original','U-tape checker');
 