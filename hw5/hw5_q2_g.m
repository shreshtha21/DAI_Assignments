clc;clear;close all;
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
k=[1,2,3,5,10,15,20,30,50,60];
recognition_rate=zeros(length(k),1);
recognition_rate_skip=zeros(length(k),1);
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
    end
    recognition_rate(j)=(crct/size(test_data,2))*100;


    if kc>3
    U_skip=V(:,4:kc);
    train_coeff_skip=U_skip'*A;
    test_coeff_skip=U_skip'*(test_data-mean_train);
    crct_skip=0;
    for i=1:size(test_data,2)
        diff_skip=sum((train_coeff_skip-test_coeff_skip(:,i)).^2,1);
        [~,idx_min_skip]=min(diff_skip);
        predicted_label_skip=train_labels(idx_min_skip);
        if predicted_label_skip==test_labels(i)
            crct_skip=crct_skip+1;
        end
    end
    recognition_rate_skip(j)=(crct_skip/size(test_data,2))*100;
    end
end
y_train_data=[];
y_test_data=[];
y_train_labels=[];
y_test_labels=[];
y_people=39;
y_train_no=40;
for p=1:y_people
    if p==14
        continue;
    end
    folder=fullfile('CroppedYale',sprintf('yaleB%02d', p));
    img_files=dir(fullfile(folder,'*.pgm'));
    train_count = min(y_train_no, length(img_files));
    for i = 1:length(img_files)
        im=imread(fullfile(folder, img_files(i).name));
        im=double(im(:)); 
        if i <= train_count
            y_train_data=[y_train_data,im(:)];
            y_train_labels=[y_train_labels; p];
        else
            y_test_data=[y_test_data,im(:)];
            y_test_labels=[y_test_labels; p];
        end
    end
end
y_mean_train=mean(y_train_data,2);
A=y_train_data-y_mean_train*ones(1, size(y_train_data, 2));
L=A' * A;
[V,D]=eig(L);
[eigenvals,idx]=sort(diag(D),'descend');
V=V(:,idx);
y_recognition_rate=zeros(length(k),1);
y_recognition_rate_skip=zeros(length(k),1);
V=A*V;
V=normc(V);
for j=1:length(k)
    kc=k(j);
    U=V(:,1:kc);
    train_coeff=U'*A;
    test_coeff=U'*(y_test_data-y_mean_train);
    crct=0;
    for i=1:size(y_test_data,2)
        diff=sum((train_coeff-test_coeff(:,i)).^2,1);
        [~,idx_min]=min(diff);
        predicted_label=y_train_labels(idx_min);
        if predicted_label==y_test_labels(i)
            crct=crct+1;
        end
    end
    y_recognition_rate(j)=(crct/size(y_test_data,2))*100;
    if kc>3
    U_skip=V(:,4:kc);
    train_coeff_skip=U_skip'*A;
    test_coeff_skip=U_skip'*(y_test_data-y_mean_train);
    crct_skip=0;
    for i=1:size(y_test_data,2)
        diff_skip=sum((train_coeff_skip-test_coeff_skip(:,i)).^2,1);
        [~,idx_min_skip]=min(diff_skip);
        predicted_label_skip=y_train_labels(idx_min_skip);
        if predicted_label_skip==y_test_labels(i)
            crct_skip=crct_skip+1;
        end
    end
    y_recognition_rate_skip(j)=(crct_skip/size(y_test_data,2))*100;
    end
end
figure;
plot(k, recognition_rate, '-ob', 'LineWidth', 2, 'MarkerFaceColor', 'b');
hold on;
plot(k, y_recognition_rate, '-or', 'LineWidth', 2, 'MarkerFaceColor', 'r');
title('Recognition Rate (All Eigenfaces)', 'FontSize', 14);
xlabel('Number of Eigenfaces (k)');
ylabel('Recognition Rate (%)');
legend('ORL', 'Yale');
grid on; xticks(k); ylim([0 100]);

figure;
plot(k, recognition_rate_skip, '-ob', 'LineWidth', 2, 'MarkerFaceColor', 'b');
hold on;
plot(k, y_recognition_rate_skip, '-or', 'LineWidth', 2, 'MarkerFaceColor', 'r');
title('Recognition Rate (Skipping Top 3 Eigenfaces)', 'FontSize', 14);
xlabel('Number of Eigenfaces (k)');
ylabel('Recognition Rate (%)');
legend('ORL - skip top 3', 'Yale - skip top 3');
grid on; xticks(k); ylim([0 100]);
