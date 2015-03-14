function res = acrobotD2L(q,qdot,params)
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

%unpack the states
q1 = q(1,:);
q2 = q(2,:);
q1dot = qdot(1,:);
q2dot = qdot(2,:);

dL_dq1dot = (I1 + m2.*l1.^2 + I2 + 2.*m2.*l1.*lc2.*cos(q2)).*q1dot + (I2 + m2.*l1.*lc2.*cos(q2)).*q2dot;
dL_dq2dot = I2.*q2dot + (I2 + m2.*l1.*lc2.*cos(q2)).*q1dot;

res = [dL_dq1dot; dL_dq2dot];


end