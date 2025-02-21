clc; clear;

addpath(genpath("path/to/mosek"));
load("assets/Data.mat");

cost = zeros(length(Data),1);
yalmipTime = zeros(length(Data),1);
solverTime = zeros(length(Data),1);

for i = 1:length(Data)
    A = Data{i}.A;
    b = Data{i}.b;
    [m,n] = size(A);

    x = sdpvar(n,1);
    t = sdpvar(1);

    objective = t;
    constraints = [A*x == b,...
                    x >= 0,...
                    x'*x <= t];
    options = sdpsettings('solver','mosek',...
            'savesolveroutput',1,...
            'verbose',1);

    sol = optimize(constraints,objective,options);

    cost(i,1) = sqrt(value(objective));
    yalmipTime(i,1) = sol.yalmiptime;
    solverTime(i,1) = sol.solvertime;
end

figure(1)
subplot(1,3,1)
plot(1:length(Data),cost,'-o')
title('Cost')

subplot(1,3,2)
plot(1:length(Data),yalmipTime,'-o')
title('YALMIP Time')

subplot(1,3,3)
plot(1:length(Data),solverTime,'-o')
title('SeDuMi Solver Time')