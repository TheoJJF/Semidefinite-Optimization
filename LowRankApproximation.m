clc; clear;

A = imread("assets/Geisel Library.jpg");
A = im2double(A);
A = rgb2gray(A);

[m, n] = size(A);
K = [10,40,80,160];
A_k = cell(1,length(K));
Error = zeros(1,length(K));

[U,S,V] = svd(A);
idx = 1;

for k = K
    A_k{idx} = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
    Error(1,idx) = norm(A-A_k{idx}, 'fro');
    fprintf('Error for k = %d is %.2f\n',k,Error(1,idx'));
    idx = idx + 1;
end

figure(1)
subplot(1,2,1);
plot(K,Error,'-o');
grid on;
xlabel('$k$','Interpreter','latex');
ylabel('$\|A-A_k\|_\mathcal{F}$','Interpreter','latex');

subplot(1,2,2);
plot(K,m*n-(m+n+1)*K,'-o');
grid on;
xlabel('$k$','Interpreter','latex');
ylabel('Total savings','Interpreter','latex');