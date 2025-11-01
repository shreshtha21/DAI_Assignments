clc;clear;close all;
% Case (a)
mu=[1;1];
C=[9 0; 0 4];
% Generating 100 samples from U(0,1)
z=randn(2,100);
% Cholesky decomposition
A=chol(C, 'lower');
% Generating samples from N(mu, C)
x=A'*z+repmat(mu, 1, 100);
%Plotting graph

figure;
plot(x(1,:),x(2,:) ,'.');
xlabel('x₁');
ylabel('x₂');
title('Samples from 2D Gaussian N(μ, C)');
axis equal; grid on;

%Calculating eigenvectors and eigenvalues 
[V,D]=eig(C);
%Calculating min and max direction
[~,idxmax]=max(diag(D));
[~,idxmin]=min(diag(D));
vmax=V(:,idxmax);
vmin=V(:,idxmin);
fprintf('Case (a)\n');
fprintf('Max variance direction: v= [%.2f, %.2f]\n', vmax(1), vmax(2));
fprintf('Min variance direction: v= [%.2f, %.2f]\n', vmin(1), vmin(2));

% Case (b)
mu=[1;2];
C=[9 1; 1 4];
% Generating 100 samples from U(0,1)
z=randn(2,100);
% Cholesky decomposition
A=chol(C, 'lower');
% Generating samples from N(mu, C)
x=A'*z+repmat(mu, 1, 100);
% Plotting graph
figure;
plot(x(1,:),x(2,:) ,'.');
xlabel('x₁');
ylabel('x₂');
title('Samples from 2D Gaussian N(μ, C)');
axis equal; grid on;
%Calculating eigenvectors and eigenvalues 
[V,D]=eig(C);
%Calculating min and max direction
[~,idxmax]=max(diag(D));
[~,idxmin]=min(diag(D));
vmax=V(:,idxmax);
vmin=V(:,idxmin);
fprintf('Case (b)\n');
fprintf('Max variance direction: v= [%.2f, %.2f]\n', vmax(1), vmax(2));
fprintf('Min variance direction: v= [%.2f, %.2f]\n', vmin(1), vmin(2));
