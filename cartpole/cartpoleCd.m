function res = cartpoleCd(currentq,nextq,currentf,nextf,h)
% currentq = qtraj(:,1:end-1);
% nextq = qtraj(:,2:end);
% currentf = ftraj(:,1:end-1);
% nextf = ftraj(:,2:end);
% 
q = (currentq + nextq)./2;
qdot = (nextq - currentq)./h;
fmid = (currentf + nextf)./2;

res = h.*cartpoleCost(q,qdot,fmid);

end