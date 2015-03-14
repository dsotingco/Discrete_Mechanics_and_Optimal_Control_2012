%derivative of Lagrangian with respect to xdot and thetadot
function res = cartpoleD2L(q,qdot,params)
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

dLdxdot = (mc+mp).*xdot + mp.*l.*thetadot.*cos(theta);
dLdthetadot = mp.*l.*xdot.*cos(theta) + mp.*l.^2.*thetadot;

res = [dLdxdot; dLdthetadot];
end