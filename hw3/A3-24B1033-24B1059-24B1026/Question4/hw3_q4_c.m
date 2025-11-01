clc; clear;
mu=0;
sigma=4;
n=1000;
samples = mu + sigma * randn(n, 1);
shuffle=samples(randperm(n));
T=shuffle(1:750);
V=shuffle(751:end);

sigma_values=[0.001,0.1,0.2,0.9,1,2,3,5,10,20,100];
LL = zeros(size(sigma_values));
for i = 1:length(sigma_values)
    sigma=sigma_values(i);
    pdf=zeros(size(V));
    for j = 1:length(V)
        pdf(j)=mean(normpdf(V(j), T, sigma_values(i)));
    end
    LL(i)=sum(log(pdf));
end
[bestLL, idx]=max(LL);
best_sigma=sigma_values(idx);
fprintf('Best sigma = %f, Best Log-Likelihood = %f\n', best_sigma, bestLL);
figure;
plot(log(sigma_values), LL, '-o','LineWidth',1.5);
xlabel('log(\sigma)');
ylabel('Log-Likelihood');

x= -8 : 0.1 : 8;
pn_hat=zeros(size(x));
for j= 1: length(x)
    pn_hat(j) = mean(normpdf(x(j), T, best_sigma));
end
true_density=normpdf(x, 0 , 4);
figure;
plot(x, pn_hat, 'b');
hold on;
plot(x, true_density, 'r');
xlabel('x');
ylabel('density');
legend('Estimated density (KDE)','True density (Gaussian)','Location','south');