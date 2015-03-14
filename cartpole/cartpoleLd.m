function res = cartpoleLd(currentq,nextq,h,params)
%currentq and next q should be 2x1 vectors of [theta; x]
q = (currentq + nextq)./2;
qdot = (nextq - currentq)./h;

% states = [q; qdot];

res = h.*cartpoleLagrangian(q,qdot,params);
end