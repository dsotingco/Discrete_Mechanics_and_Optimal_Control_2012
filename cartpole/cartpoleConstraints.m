%constraint function for fmincon
function [C,Ceq] = cartpoleConstraints(optimvars,t,params)
C = 0;  %no inequalities

h = t(2) - t(1);

%optimvars should be 3xN
%rows are [x; theta; f] 
%columns correspond to time

%split up optimvars into position states and control inputs
qd = optimvars(1:2,:);
    qsize = size(qd);
    N = qsize(2);
fd = zeros(2,N);
fd(1,:) = optimvars(3,:);


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

% %calculate the q's
% previousq = qd(:,1:end-2);
% currentq = qd(:,2:end-1);
% nextq = qd(:,3:end);

%the position states at the beginning and end must match the specified
%initial and final states
Ceq(1:2,:) = qd(:,1) - qi;    
Ceq(3:4,:) = qd(:,end) - qf;

%discrete momentum boundary condition at the initial time
Ceq(5:6,:) = cartpoleD2L(qd(:,1),qdoti,params) + cartpoleD1Ld(qd(:,1),qd(:,2),h,params) + f0left;

%discrete momentum boundary condition at the final time
Ceq(7:8,:) = -cartpoleD2L(qd(:,end),qdotf,params) + cartpoleD2Ld(qd(:,end-1),qd(:,end),h,params) + fpenul;

% %forced discrete Euler-Lagrange equations
% Ceq(7:8,:) = cartpoleD2Ld(previousq,currentq,h,params) + cartpoleD1Ld(currentq,nextq,h,params) + fright + fleft;

%forced discrete Euler-Lagrange equations
rowIndex = 9;
    for k = 2:N-1
        qprev = qd(:,k-1);
        qcurr = qd(:,k);
        qnext = qd(:,k+1);
        fl = (h./4).*(fd(:,k)+fd(:,k+1));
        fr = (h./4).*(fd(:,k)+fd(:,k-1));
%         Ceq(7+k:7+k+1,:) = cartpoleD2Ld(qprev,qcurr,h,params) + cartpoleD1Ld(qcurr,qnext,h,params) + fl + fr;
        Ceq(rowIndex:rowIndex+1,:) = cartpoleD2Ld(qprev,qcurr,h,params) + cartpoleD1Ld(qcurr,qnext,h,params) + fl + fr;
        rowIndex = rowIndex + 2;
    end
end