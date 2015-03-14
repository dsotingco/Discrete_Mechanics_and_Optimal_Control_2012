function res = cartpoleDerivsUtape(t,states,params,u)

%unpack params
mc = params.mc;
mp = params.mp;
l = params.l;
g = params.g;

%unpack states
x = states(1);
theta = states(2);
xdot = states(3);
thetadot = states(4);

%pull in the control input
f = u;

%calculate accelerations
xddot = (f + mp.*sin(theta).*(l.*thetadot.^2 + g.*cos(theta))) ./ (mc + mp.*(sin(theta)).^2);
thetaddot = (-f.*cos(theta) - mp.*l.*thetadot.^2.*sin(theta).*cos(theta) - (mc+mp).*g.*sin(theta)) ./ (l.*(mc+mp.*(sin(theta)).^2));

res = [xdot; thetadot; xddot; thetaddot];
end