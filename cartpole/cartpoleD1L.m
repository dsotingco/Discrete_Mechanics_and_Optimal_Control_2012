%derivative of Lagrangian with respect to x and theta
function res = cartpoleD1L(q,qdot,params)
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

dLdx = zeros(1,length(x));
dLdtheta = -mp.*l.*xdot.*thetadot.*sin(theta) - mp.*g.*l.*sin(theta);

res = [dLdx; dLdtheta];
end