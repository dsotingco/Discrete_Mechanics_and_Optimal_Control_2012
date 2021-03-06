%check to see if the constraints were fulfilled
%result should be a vector of zeros if the constraints are fulfilled
function res = cartpoleCheckOptimTraj(optimtraj,h,params)
qd = optimtraj(1:2,:);
    qsize = size(qd);
    N = qsize(2);
fd = zeros(2,N);
fd(1,:) = optimtraj(3,:);

%initial and final positions
qi = [0; 1e-2];
qf = [0; pi];
% qi = qd(:,1);
% qf = qd(:,end);
qdoti = [0; 0]; %also need initial velocities
qdotf = [0; 0]; %final velocities
IC = [qi; qdoti];

%calculate left and right discrete forces
f0left = (h./4).*(fd(:,1) + fd(:,2));
fpenul = (h./4).*(fd(:,end-1) + fd(:,end));
    previousf = fd(:,1:end-2);
    currentf = fd(:,2:end-1);
    nextf = fd(:,3:end);
fleft = (h./4).*(currentf+nextf);   %this is f_{k}^{-}
fright = (h./4).*(currentf+previousf);  %this is f_{k-1}^{+}

%calculate the q's
previousq = qd(:,1:end-2);
currentq = qd(:,2:end-1);
nextq = qd(:,3:end);

% disp('Boundary conditions in time: ');
% disp(num2str(qd(:,1) - qi));
% disp(num2str(qd(:,end) - qf));
% 
% disp('Discrete momentum boundary conditions: ');
% disp(num2str(cartpoleD2L(qd(:,1),qdoti,params) + cartpoleD1Ld(qd(:,1),qd(:,2),h,params) + f0left));
% disp(num2str(-cartpoleD2L(qd(:,end),qdotf,params) + cartpoleD2Ld(qd(:,end-1),qd(:,end),h,params) + fpenul));
% 
% disp(num2str(cartpoleD2Ld(previousq,currentq,h,params) + cartpoleD1Ld(currentq,nextq,h,params) + fright + fleft));
a = qd(:,1) - qi;
b = qd(:,end) - qf;
c = cartpoleD2L(qd(:,1),qdoti,params) + cartpoleD1Ld(qd(:,1),qd(:,2),h,params) + f0left;
d = -cartpoleD2L(qd(:,end),qdotf,params) + cartpoleD2Ld(qd(:,end-1),qd(:,end),h,params) + fpenul;
e = cartpoleD2Ld(previousq,currentq,h,params) + cartpoleD1Ld(currentq,nextq,h,params) + fright + fleft;
% res = [a; b; c; d; e(1,:)'; e(2,:)'];
res.initBC = a;
res.finalBC = b;
res.initEL = c;
res.finalEL = d;
res.midEL = e;
end