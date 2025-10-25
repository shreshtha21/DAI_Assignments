clc; clear; close all;
[I_train, labels, I_test, labels_test] = readMNIST();
digits = [0,3,6,7];

for k = 1:length(digits)
    curr_d=digits(k);
    dig_idx=find(labels==curr_d);
    nsamples=length(dig_idx);
    data_mat=zeros(784,nsamples); 
    for i=1:nsamples
        img_idx=dig_idx(i);
        A=I_train{img_idx};
        A=A'; 
        c=A(:); 
        data_mat(:,i)=c;
    end
    
    %(a)
    data_mat=double(data_mat);
    C=cov(data_mat'); 

    %(b)
    [V,D] = eig(C);
    ev = diag(D);
    sorted_ev = sort(ev,'descend');
    
    %(c)
    figure; 
    plot(1:784, sorted_ev);
    title(['ev (Decreasing Order) for Digit: ' num2str(curr_d)], 'FontSize', 14);
    xlabel('Component Index', 'FontSize',12);
    ylabel('Eigenvalue (Variance)', 'FontSize',12);
    grid on;
    
    %(d)
    [~,sort_idx] = sort(ev,'descend');
    top5_vec = V(:, sort_idx(1:5));
    
    figure; 
    sgtitle(['Top 5 Eigenvectors ("Eigen-digits") for Digit: ' num2str(curr_d)], 'FontSize', 16);
    for i=1:5
        vec=top5_vec(:, i);
        img=reshape(vec, 28, 28);
        img_re=mat2gray(img);
        subplot(1,5,i);
        imagesc(img_re); 
        colormap(gray); 
        axis image off; 
        title(['Eigenvec ' num2str(i)], 'FontSize',12);
    end
end
