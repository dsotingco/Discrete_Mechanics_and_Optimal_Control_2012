function Jd = acrobotObFunDircol(optimvars,t,params)
h = t(2) - t(1);

qd = optimvars(1:4,:);
fd = optimvars(5,:);

qsize = size(qd);
N = qsize(2);   

Jd = 0;
    for k = 1:N-1
        currentq = qd(:,k);
        nextq = qd(:,k+1);
        currentf = fd(:,k);
        nextf = fd(:,k+1);
        Jd = Jd + acrobotCd(currentq,nextq,currentf,nextf,h);
    end

end