%HW1-QUESTION 1
clc; clear;

%%% PART 1: f = 0.3 %%%
fprintf("f=0.3 \n")

%x values and the original sine wave
x = [-3:0.02:3];
y=6.5*sin(2.1*x+pi/3);
window_size=17;

%plotting the original sine wave
plot(x,y, 'b');
xlabel('x');
hold on;

%corruption 
n=length(y);
f=0.3;
k=round(f*n);
rand_y=randperm(n,k);
corrupt_values=100+(120-100)*rand(1,k);
z=y;
z(rand_y)=y(rand_y)+corrupt_values;

%plotting the corrupted sine wave
plot(x,z, 'r.');
xlabel('x');
hold on;

%median filtering
ymedian=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    ymedian(i)=median(z(startindex:endindex));
end;

%plotting the median filtered values
plot(x, ymedian, 'g');
xlabel('x');

%mean filtering
ymean=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    ymean(i)=mean(z(startindex:endindex));
end;

%plotting the mean filtered values
plot(x, ymean, 'm');
xlabel('x');
hold on;

%quartile filtering
yquartile=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    yquartile(i)=prctile(z(startindex:endindex),25);
end;

%plotting the quartile filtered values
plot(x, yquartile, 'c');
xlabel('x');

%legend and title
legend('sinx', 'corruptedsinx','ymedian','ymean','yquartile')
title(sprintf('FILTERING RESULT (f = %.0f%%)',f*100));
hold off;

%calculating mean squared error(MSE)
sosy=0;
for i=1:n,
    sosy=sosy+y(i)^2;
end;

%median MSE
msemedian=0;
for i=1:n
    msemedian = msemedian + (y(i) - ymedian(i))^2;
end
msemedian = msemedian / sosy;
fprintf("The mean sqaured value between y and ymedian is %.3f \n", msemedian);

%mean MSE
msemean=0;
for i=1:n
    msemean = msemean + (y(i) - ymean(i))^2;
end
msemean = msemean / sosy;
fprintf("The mean sqaured value between y and ymean is %.3f \n", msemean);

%quartile MSE
msequartile=0;
for i=1:n
    msequartile = msequartile + (y(i) - yquartile(i))^2;
end
msequartile = msequartile / sosy;
fprintf("The mean sqaured value between y and yquartile is %.3f \n", msequartile);


%%% PART 2: f = 0.6 %%%
fprintf("f=0.6 \n")

%x values and the original sine wave
x = [-3:0.02:3];
y=6.5*sin(2.1*x+pi/3);
figure%;

%plotting the original sine wave
plot(x,y, 'b');
xlabel('x');
hold on;

%corruption 
n=length(y);
f=0.6;
k=round(f*n);
rand_y=randperm(n,k);
corrupt_values=100+(120-100)*rand(1,k);
z=y;
z(rand_y)=y(rand_y)+corrupt_values;

%plotting the corrupted sine wave
plot(x,z, 'r.');
xlabel('x');
hold on;

%median filtering
ymedian=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    ymedian(i)=median(z(startindex:endindex));
end;

%plotting the median filtered values
plot(x, ymedian, 'g');
xlabel('x');

%mean filtering
ymean=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    ymean(i)=mean(z(startindex:endindex));
end;

%plotting the mean filtered values
plot(x, ymean, 'm');
xlabel('x');
hold on;

%quartile filtering
yquartile=zeros(1,n);
for i=1:n,
    startindex=max(1,i-8);
    endindex=min(n,i+8);
    yquartile(i)=prctile(z(startindex:endindex),25);
end;

%plotting the quartile filtered values
plot(x, yquartile, 'c');
xlabel('x');

%legend and title
legend('sinx', 'corruptedsinx','ymedian','ymean','yquartile')
title(sprintf('FILTERING RESULT (f = %.0f%%)',f*100));
hold off;

%calculating mean squared error(MSE)
sosy=0;
for i=1:n,
    sosy=sosy+y(i)^2;
end;

%median MSE
msemedian=0;
for i=1:n
    msemedian = msemedian + (y(i) - ymedian(i))^2;
end
msemedian = msemedian / sosy;
fprintf("The mean sqaured value between y and ymedian is %.3f \n", msemedian);

%mean MSE
msemean=0;
for i=1:n
    msemean = msemean + (y(i) - ymean(i))^2;
end
msemean = msemean / sosy;
fprintf("The mean sqaured value between y and ymean is %.3f \n", msemean);

%quartile MSE
msequartile=0;
for i=1:n
    msequartile = msequartile + (y(i) - yquartile(i))^2;
end
msequartile = msequartile / sosy;
fprintf("The mean sqaured value between y and yquartile is %.3f \n", msequartile);

