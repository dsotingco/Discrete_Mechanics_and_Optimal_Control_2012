function res = acrobotCd(currentq,nextq,currentf,nextf,h)
q = (currentq + nextq)./2;
qdot = (nextq - currentq)./h;
fmid = (currentf + nextf)./2;

res = h.*acrobotCost(q,qdot,fmid);
end