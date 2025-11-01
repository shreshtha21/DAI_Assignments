clc;clear;close all;
data=[];
train_data=[];
test_data=[];
train_labels=[];
test_labels=[];
people=32;
train_no=6;
test_no=4;
for p=1:people
    folder=fullfile('ORL',sprintf('s%d',p));
    img_files=dir(fullfile(folder,'*.pgm'));
    for i = 1:length(img_files)
        im=imread(fullfile(folder, img_files(i).name));
        im=double(im(:));
        data=[data;im(:)]; 
        if i <= train_no
            train_data=[train_data,im(:)];
            train_labels=[train_labels; p];
        else
            test_data=[test_data,im(:)];
            test_labels=[test_labels; p];
        end
    end
end
mean_train=mean(train_data,2);
A=train_data-mean_train*ones(1, size(train_data, 2));
L=A' * A;
[V,D]=eig(L);
[eigenvals,idx]=sort(diag(D),'descend');
V=V(:,idx);
k=[1,2,3,5,10,15,20,30,50,75,100,150,170];
recognition_rate=zeros(length(k),1);
V=A*V;
V=normc(V);
for j=1:length(k)
    kc=k(j);
    U=V(:,1:kc);
    train_coeff=U'*A;
    test_coeff=U'*(test_data-mean_train);
    crct=0;
    for i=1:size(test_data,2)
        diff=sum((train_coeff-test_coeff(:,i)).^2,1);
        [~,idx_min]=min(diff);
        predicted_label=train_labels(idx_min);
        if predicted_label==test_labels(i)
            crct=crct+1;
        end
        recognition_rate(j)=(crct/size(test_data,2))*100;
    end
end
figure;
plot(k, recognition_rate, '-o', 'LineWidth', 2, 'MarkerFaceColor', 'b');
title('Face Recognition Rate vs. Number of Eigenfaces (k)', 'FontSize', 14);
xlabel('Number of Eigenfaces (k)', 'FontSize', 12);
ylabel('Recognition Rate (%)', 'FontSize', 12);
grid on;
xticks(k);
xtickangle(45);
ylim([0 100]);
legend('Recognition Rate', 'Location', 'SouthEast')
