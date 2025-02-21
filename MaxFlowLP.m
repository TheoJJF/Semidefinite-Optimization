clc; clear;

addpath(genpath("path/to/sedumi"));
load("assets/maxflow.mat");

sedumiTime = zeros(length(MaxFlow), 1);
cost = zeros(length(MaxFlow), 1);

for i = 1:length(MaxFlow)
    A = MaxFlow{i}.A;
    b = MaxFlow{i}.b;
    c = MaxFlow{i}.c;
    K = MaxFlow{i}.K;
    
    [m,n] = size(A);

    [x,y,info] = sedumi(A,b,c,K);

    % wallsec = preprocessing + IPM + postprocessing
    sedumiTime(i,1) = info.wallsec;
    cost(i,1) = c'*x;
end

figure(1)
subplot(1,2,1)
plot(1000:1000:1e4,cost,'-o')
title('Cost')

subplot(1,2,2)
plot(1000:1000:1e4,sedumiTime,'-o')
title('SeDuMi Solution Time')