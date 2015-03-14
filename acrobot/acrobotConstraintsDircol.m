%acrobot constraints for DMOC
function [C,Ceq] = acrobotConstraintsDircol(optimvars,t,params)
C = 0;  %no inequalities

h = t(2) - t(1);

%optimvars should be 3xN
%rows are [q1; q2; f] 
%columns correspond to time

%split up optimvars into position states and control inputs
qd = optimvars(1:4,:);
    qsize = size(qd);
    N = qsize(2);
fd = zeros(2,N);
fd(2,:) = optimvars(5,:);

%initial and final positions
qi = [0; 0];
qf = [pi; 0];
% qi = qd(:,1);
% qf = qd(:,end);
qdoti = [0; 0]; %also need initial velocities
qdotf = [0; 0]; %final velocities
IC = [qi; qdoti];
FC = [qf; qdotf];

%the position states at the beginning and end must match the specified
%initial and final states
Ceq(1:4,:) = qd(:,1) - IC;    
Ceq(5:8,:) = qd(:,end) - FC;

rowIndex = 9;
for k = 1:N-1
    Ceq(rowIndex:rowIndex+3,:) = qd(:,k+1) - qd(:,k) - h.*acrobotDerivsUtape(t(k),qd(:,k),params,fd(2,k));
    rowIndex = rowIndex + 4;
end

end