function res = acrobotD1Ld(qcurr,qnext,h,params)
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

q = (qcurr + qnext)./2;
qdot = (qnext - qcurr)./h;

q1 = q(1,:);
q2 = q(2,:);
q1dot = qdot(1,:);
q2dot = qdot(2,:);


dL_dq1 = (-1./h).*(I1 + m2.*l1.^2 + I2 + 2.*m2.*l1.*lc2.*cos(q2)).*q1dot - (1./h).*(I2 + m2.*l1.*lc2.*cos(q2)).*q2dot - 0.5.*m1.*g.*lc1.*sin(q1) + m2.*g.*(-0.5.*l1.*sin(q1) - 0.5.*lc2.*sin(q1+q2));

dL_dq2 = -0.5.*m2.*l1.*lc2.*q1dot.^2.*sin(q2) - (1./h).*I2.*q2dot - 0.5.*m2.*l1.*lc2.*q1dot.*q2dot.*sin(q2) - (1./h).*(I2 + m2.*l1.*lc2.*cos(q2)).*q1dot - 0.5.*m2.*g.*lc2.*sin(q1+q2);

res = [dL_dq1; dL_dq2];

end