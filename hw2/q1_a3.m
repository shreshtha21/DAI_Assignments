%HW2-q1-a-iii

%p(s)
p= @(s) 1-(1./s).^(1./s);

sval=1:10; %integer s
pval=p(sval);

[pmax,idx]=max(pval);
smax=sval(idx);

%plot
figure
stem(sval,pval,'filled');
xlabel('s values (integer)');
ylabel('p(s)');
title('Plot of p(s) vs integer s');
grid on;
hold on;
plot(smax,pmax,'ro','MarkerSize',8,'MarkerFaceColor','r');
fprintf('Maximum p(s) ≈ %.6f at integer s = %d\n',pmax,smax);