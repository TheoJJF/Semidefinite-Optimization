clc; clear;

addpath(genpath("path/to/mosek"));

n = 3;
N = 30;

A = [-1,0.4,0.8;
    1,0,0;
    0,1,0];
C = zeros(n,N);
b = [1;0;0.3];
xdes = [7;2;-6];
x0 = zeros(n,1);

for i = 1:N
    C(:,i) = A^(N-i)*b;
end

f = sdpvar(N,1);
u = sdpvar(N,1);

objective = sum(f);
constraints = [u <= f,...
                u >= -f,...
                u <= (f+ones(N,1))/2,...
                u >= -(f+ones(N,1))/2,...
                C*u == xdes];
options = sdpsettings('solver','mosek',...
            'savesolveroutput',1,...
            'verbose',1);

sol = optimize(constraints,objective,options);

stairs(0:N-1,u,'linewidth',2)
axis tight
xlabel('t')
ylabel('u')
