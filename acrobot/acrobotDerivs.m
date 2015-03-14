function res = acrobotDerivs(t,states,params)
%unpack params
m1 = params.m1;
m2 = params.m2;
I1 = params.I1;
I2 = params.I2;
l1 = params.l1;
l2 = params.l2;
lc1 = params.lc1;
lc2 = params.lc2;
g = params.g;

%unpack states
theta1 = states(1);
theta2 = states(2);
theta1dot = states(3);
theta2dot = states(4);

q = [theta1; theta2];
qdot = [theta1dot; theta2dot];

%build inertia matrix
H(1,1) = I1 + I2 + m2.*l1.^2 + 2.*m2.*l1.*lc2.*cos(theta2);
H(1,2) = I2 + m2.*l1.*lc2.*cos(theta2);
H(2,1) = I2 + m2.*l1.*lc2.*cos(theta2);
H(2,2) = I2;

%build Coriolis matrix
C(1,1) = -2.*m2.*l1.*lc2.*theta2dot.*sin(theta2);
C(1,2) = -m2.*l1.*lc2.*theta2dot.*sin(theta2);
C(2,1) = m2.*l1.*lc2.*theta1dot.*sin(theta2);
C(2,2) = 0;

%build gravity matrix
G(1,1) = m1.*g.*lc1.*sin(theta1) + m2.*g.*(l1.*sin(theta1) + lc2.*sin(theta1+theta2));
G(2,1) = m2.*g.*lc2.*sin(theta1+theta2);

%build input shaping matrix
B = [0; 1];

%pull in the control law
u = acrobotControl(states,params);

%calculate accelerations
qddot = H\(B*u - C*qdot - G);

res = [qdot; qddot];

end