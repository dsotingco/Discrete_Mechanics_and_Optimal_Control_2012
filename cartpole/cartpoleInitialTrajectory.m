function [t,y,u] = cartpoleInitialTrajectory
close all;

%time
h = 1e-2;
t0 = 0;
tf = 20;
t = t0:h:tf;

load cartpoleparams;
% %pack params
% params.mc = 10;
% params.mp = 1;
% params.l = 0.5;
% params.g = 9.8;

%initial conditions - state is [x; theta; xdot; thetadot]
IC = [0; 1e-2; 0; 0];

% %ode45
% options = odeset;
% [t,y] = ode45(@cartpoleDerivs,t,IC,options,params);

%RK4
N = length(t);
y = zeros(4,N);
y(:,1) = IC;
for index = 1:length(t)-1
    k1 = h.*cartpoleDerivs(t(index),y(:,index),params);
    k2 = h.*cartpoleDerivs(t(index)+0.5.*h,y(:,index)+0.5.*k1,params);
    k3 = h.*cartpoleDerivs(t(index)+0.5.*h,y(:,index)+0.5.*k2,params);
    k4 = h.*cartpoleDerivs(t(index)+h,y(:,index)+k3,params);
    y(:,index+1) = y(:,index) + (1/6).*(k1 + 2.*k2 + 2.*k3 + k4);
end
y = y';

%reconstruct u
u(1:length(t)) = 0;
for index = 1:length(t)
    states = y(index,:)';
    u(index) = cartPoleControl(states,params);
end

% plot the states
figure;
plot(t,y(:,1),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Cart-pole position x');

figure;
plot(t,y(:,2),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Cart-pole angle theta');

figure;
plot(t,y(:,3),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Cart-pole xdot');

figure;
plot(t,y(:,4),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Cart-pole thetadot');

figure;
plot(t,u,'k.-','LineWidth',2);
xlabel('Time');
ylabel('Cart-pole control input');
end