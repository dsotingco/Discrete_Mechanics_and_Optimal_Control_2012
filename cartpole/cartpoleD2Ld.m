%discrete derivative of Lagrangian 
function res = cartpoleD2Ld(currentq,nextq,h,params)
%unpack params
mc = params.mc;
mp = params.mp;
l = params.l;
g = params.g;

q = (currentq + nextq)./2;
qdot = (nextq - currentq)./h;

x = q(1,:);
theta = q(2,:);
xdot = qdot(1,:);
thetadot = qdot(2,:);

% res = h.*cartpoleD2L(q,qdot,params);

dLd_dxk = h.*((mc+mp).*xdot./h + (mp.*l./h).*thetadot.*cos(theta));
dLd_dthetak = h.*((mp.*l./h).*xdot.*cos(theta) - (mp.*l./2).*xdot.*thetadot.*sin(theta) + (mp.*l.^2./h).*thetadot - (mp.*g.*l./2).*sin(theta));

res = [dLd_dxk; dLd_dthetak];
end