%HW2 - q1 - c
clc; clear; close all;

n = 1000;
p = [1e-4, 5e-4, 0.001, 0.005, 0.01, 0.02, 0.05, 0.08, 0.1, 0.2];

%1a(ii)
e1=2*n*sqrt(p);

%1b(v)
e2=n*ones(size(p));

%plot
figure;
plot(p,e1,'-o'); 
hold on;
plot(p,e2,'-s','MarkerSize',1);
grid on;

xlabel('p');
ylabel('E[Total number of tests]');
title('Plot of expected number of tests for both methods vs p');

legend('First Method (optimal s)','Second Method (optimal \pi, T_1)');

