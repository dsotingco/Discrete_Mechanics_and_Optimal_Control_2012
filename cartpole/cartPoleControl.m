function f = cartPoleControl(states,params)
%unpack params
mc = params.mc;
mp = params.mp;
l = params.l;
g = params.g;

%unpack states
x = states(1);
theta = states(2);
xdot = states(3);
thetadot = states(4);

persistent K;
persistent S;

rho = 2000;    %threshold below which the controller switches to LQR
            %rho = 6 works well for S = eye(4)

theta0 = pi;
thetadot0 = 0;

statesd = [0; pi; 0; 0];
statestilda = states - statesd;

%build LQR gain matrix if not built
if isempty(K)
    %cart-pole LQR
        Q = 1.*eye(4);
        R = 1;
        
        %build inertia matrix
        H(1,1) = mc + mp;
        H(1,2) = mp.*l.*cos(theta0);
        H(2,1) = mp.*l.*cos(theta0);
        H(2,2) = mp.*l.^2;
        
        %build Coriolis matrix
        C = zeros(2);
        C(1,2) = -mp.*l.*thetadot0.*sin(theta0);

        G = [0; mp.*g.*l.*sin(theta0)];
        Bd = [1; 0];

        dGdq = zeros(2);
        dGdq (2,2) = mp.*g.*l.*cos(theta0);

        %linearize
        A(1:2,1:2) = 0;
        A(1:2,3:4) = eye(2);
        A(3:4,1:2) = -H\dGdq;
        A(3:4,3:4) = -H\C;

        B = zeros(4,1);
        B(3:4) = H\Bd;
        
        %lqr
        [K,S,Elqr] = lqr(A,B,Q,R);
end

    if statestilda'*S*statestilda<rho
        f = -K*statestilda;
    else
        %Energy Shaping
        ke = 1;    %energy
        kp = 1;    %proportional (for cart position)
        kd = 1;     %derivative (for cart speed)

        %energy shaping
        Ed = mp.*g.*l;
%         E = (1/2).*(mc+mp).*xdot.^2 + mp.*l.*xdot.*thetadot.*cos(theta) + (1/2).*mp.^l.^2.*thetadot.^2 - mp.*g.*l.*cos(theta);
        E = 0.5.*mp.*l.^2.*thetadot.^2 - mp.*g.*l.*cos(theta);
        Etilda = E - Ed;

        %control law
%         f = ke.*cos(theta).*thetadot.*Etilda - kp.*x - kd.*xdot;
        xddot_des = ke.*cos(theta).*thetadot.*Etilda - kp.*x - kd.*xdot;
        f = (mc+mp-mp.*(cos(theta)).^2).*xddot_des - mp.*g.*sin(theta).*cos(theta) - mp.*l.*thetadot.^2.*sin(theta);

%         %from pset03 solution
%         Etilda = 0.125.*thetadot.^2 - 4.9.*cos(theta) - 4.9;
%         xddot_des = ke.*thetadot.*cos(theta).*Etilda - kp.*x - kd.*xdot;
%         f = (11 - cos(theta).^2).*xddot_des - 9.8.*sin(theta).*cos(theta) - 0.5.*thetadot.^2.*sin(theta);
    end
end