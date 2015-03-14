function [t,y,u] = acrobotInitialTrajectory
close all;

%time
t0 = 0;
h = 0.05;
tf = 20;
t = t0:h:tf;

load acrobotparams;
%pack params
% params.m1 = 1;
% params.m2 = 1;
% params.I1 = 1;
% params.I2 = 5;
% params.l1 = 1;
% params.l2 = 1;
% params.lc1 = params.l1./2;
% params.lc2 = params.l2./2;
% params.g = 9.8;

%initial conditions - state is [theta1; theta2; theta1dot; theta2dot]
IC = [1e-2; 0; 0; 0];

options = odeset;
[t,y] = ode45(@acrobotDerivs,t,IC,options,params);

%reconstruct u
u = zeros(1,length(t));
for index = 1:length(t)
    states = y(index,:)';
    u(index) = acrobotControl(states,params);
end

figure;
subplot(2,1,1), plot(t,y(:,1),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot theta1');
subplot(2,1,2), plot(t,y(:,2),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot theta2');

figure;
subplot(2,1,1), plot(t,y(:,3),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot theta1dot');
subplot(2,1,2), plot(t,y(:,4),'k.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot theta2dot');

figure;
plot(t,u,'k.-','LineWidth',2);
xlabel('Time');
ylabel('Acrobot control input');

end