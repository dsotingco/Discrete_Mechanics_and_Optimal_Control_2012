function res = cartpoleLagrangian(q,qdot,params)
%unpack params
mc = params.mc;
mp = params.mp;
l = params.l;
g = params.g;

%unpack states
x = q(1,:);
theta = q(2,:);
xdot = qdot(1,:);
thetadot = qdot(2,:);

res = 0.5.*(mc+mp).*xdot.^2 - mp.*l.*xdot.*thetadot.*cos(theta) + 0.5.*mp.*l.^2.*thetadot.^2 + mp.*g.*l.*cos(theta);
end