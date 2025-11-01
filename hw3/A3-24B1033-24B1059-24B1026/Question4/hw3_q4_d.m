clc; clear;
mu=0;
sigma_true=4;
n=1000;
samples = mu + sigma_true * randn(n, 1);
shuffle=samples(randperm(n));
T=shuffle(1:750);
V=shuffle(751:end);

sigma_values=[0.001,0.1,0.2,0.9,1,2,3,5,10,20,100];
LL = zeros(size(sigma_values));
D=zeros(size(sigma_values));
for i = 1:length(sigma_values)
    sigma=sigma_values(i);
    pdf=zeros(size(V));
    pdf_true=normpdf(V, mu, sigma_true);
    for j = 1:length(V)
        pdf(j)=mean(normpdf(V(j), T, sigma_values(i)));
    end
    LL(i)=sum(log(pdf));
    D(i)=sum((pdf_true-pdf).^2);
end
[bestLL, idx]=max(LL);
best_sigma=sigma_values(idx);

[bestD, idxD]=min(D);
bestD_sigma=sigma_values(idxD);
fprintf('Best sigma by LL = %f (LL=%f)\n', best_sigma, bestLL);
fprintf('Best sigma by D  = %f (D=%f)\n', bestD_sigma, bestD);
fprintf('D value for sigma that maximized LL = %f\n', D(idx));
figure;
plot(log(sigma_values), D,'-o','LineWidth',1.5);
xlabel('log(\sigma)');
ylabel('D');

x= -8 : 0.1 : 8;
pn_hat=zeros(size(x));
for j= 1: length(x)
    pn_hat(j) = mean(normpdf(x(j), T, bestD_sigma));
end
true_density=normpdf(x, 0 , 4);
figure;
plot(x, pn_hat, 'b');
hold on;
plot(x, true_density, 'r');
xlabel('x');
ylabel('density');
legend('Estimated density (KDE)','True density (Gaussian)','Location','south');