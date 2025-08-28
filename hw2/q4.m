%HW2 - Q4
clear;clc;

%converting imp into 2d array
im1 = double(imread('T1.jpg'));
im2 = double(imread('T2.jpg'));

[rows, cols] = size(im2);
corr_coeffs=zeros(1,21);
qmi=zeros(1,21);
mi=zeros(1,21);
index=1;
tx_val=-10:1:10;
for tx = -10:1:10
    shifted_im2=zeros(rows,cols);
    if tx>0
        zer=zeros(size(im2,1), tx);
    shifted_im2 = [zer im2];
    shifted_im2=shifted_im2(:,1:size(im2,2));
    elseif tx<0
    shifted_im2(:, 1:(end - abs(tx))) = im2(:, (abs(tx) + 1):end);
    else 
        shifted_im2=im2;
    end
    vec1=im1(:);
    vec2=shifted_im2(:);
    r=corr(vec1,vec2);
    corr_coeffs(index)=r;
    range_min = min(min(im1(:)), min(shifted_im2(:)));
    range_max = max(max(im1(:)), max(shifted_im2(:)));
    [p,q]=dependence(im1,shifted_im2,10,[range_min range_max]);
    qmi(index)=q;
    mi(index)=p;
    index = index + 1;
end
function [mi, qmi] = dependence(im1, im2, binwidth, range)
I1=im1(:);
I2 = im2(:);
edges=range(1):binwidth:range(2);
noofbins=length(edges)-1;
jointhist=zeros(noofbins,noofbins);
for k = 1:length(I1)
    v1=I1(k);
    v2=I2(k);
    if v1==0 || v2==0
        continue;
    end
    b1 = find(edges <= v1, 1, 'last');
    b2 = find(edges <= v2, 1, 'last');
    if b1 < noofbins+1 && b2 < noofbins+1
        jointhist(b1,b2)=jointhist(b1,b2)+1;
    end
end
jointhist=jointhist/sum(jointhist(:));
p1=sum(jointhist,2);
p2=sum(jointhist,1);
mi=0;
for i= 1: noofbins
    for j=1:noofbins
        if jointhist(i,j)>0 && p1(i)>0 && p2(j)>0
            mi=mi+jointhist(i,j)*log(jointhist(i,j)/(p1(i)*p2(j)));
        end
    end
end
temp=p1*p2;
qmi=sum(sum((jointhist-temp).^2));
end

%plotting the plots
figure;
plot(tx_val,corr_coeffs);
xlabel('tx');
ylabel('corr_coeffs');
figure;
plot(tx_val,qmi);
xlabel('tx');
ylabel('qmi');
figure;
plot(tx_val,mi);
xlabel('tx');
ylabel('mi');

%I2=255-I1
sim2=255-im1;
corr_coeffs=zeros(1,21);
qmi=zeros(1,21);
mi=zeros(1,21);
index=1;
tx_val=-10:1:10;
for tx = -10:1:10
    shifted_sim2=zeros(rows,cols);
    if tx>0
        zer=zeros(size(sim2,1), tx);
    shifted_sim2 = [zer sim2];
    shifted_sim2=shifted_sim2(:,1:size(sim2,2));
    elseif tx<0
    shifted_sim2(:, 1:(end - abs(tx))) = sim2(:, (abs(tx) + 1):end);
    else 
        shifted_sim2=sim2;
    end
    vec1=im1(:);
    vec2=shifted_sim2(:);
    r=corr(vec1,vec2);
    corr_coeffs(index)=r;
    range_min = min(min(im1(:)), min(shifted_sim2(:)));
    range_max = max(max(im1(:)), max(shifted_sim2(:)));
    [p,q]=dependence(im1,shifted_sim2,10,[range_min range_max]);
    qmi(index)=q;
    mi(index)=p;
    index = index + 1;
end
figure;
plot(tx_val,corr_coeffs);
xlabel('tx');
ylabel('corr_coeffs');
figure;
plot(tx_val,qmi);
xlabel('tx');
ylabel('qmi');
figure;
plot(tx_val,mi);
xlabel('tx');
ylabel('mi');

%I2 = 255 ×(I1)^2/max((I1)2) + 1.
tim2=255*(im1).^2/max(im1(:).^2)+1;
corr_coeffs=zeros(1,21);
qmi=zeros(1,21);
mi=zeros(1,21);
index=1;
tx_val=-10:1:10;
for tx = -10:1:10
    shifted_tim2=zeros(rows,cols);
    if tx>0
        zer=zeros(size(tim2,1), tx);
    shifted_tim2 = [zer tim2];
    shifted_tim2=shifted_tim2(:,1:size(tim2,2));
    elseif tx<0
    shifted_tim2(:, 1:(end - abs(tx))) = tim2(:, (abs(tx) + 1):end);
    else 
        shifted_tim2=tim2;
    end
    vec1=im1(:);
    vec2=shifted_tim2(:);
    r=corr(vec1,vec2);
    corr_coeffs(index)=r;
    range_min = min(min(im1(:)), min(shifted_tim2(:)));
    range_max = max(max(im1(:)), max(shifted_tim2(:)));
    [p,q]=dependence(im1,shifted_tim2,10,[range_min range_max]);
    qmi(index)=q;
    mi(index)=p;
    index = index + 1;
end
figure;
plot(tx_val,corr_coeffs);
xlabel('tx');
ylabel('corr_coeffs');
figure;
plot(tx_val,qmi);
xlabel('tx');
ylabel('qmi');
figure;
plot(tx_val,mi);
xlabel('tx');
ylabel('mi');