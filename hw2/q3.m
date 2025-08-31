%hw2-q3

n=1e5; 

%defining some random pdfs on [0,1]
pdfs={@(x) ones(size(x)), ...              %constant
        @(x) 2*x, ...                        %linear->f(x)=2x
        @(x) 3*x.^2, ...                     %quadratic->f(x)=3x^2
        @(x) (pi/2)*sin(pi*x/2)};            %sine

names={'Constant(0,1)','Linear PDF 2x','Quadratic PDF 3x^2','Sine PDF'};

for k=1:length(pdfs)
    f=pdfs{k};
    switch k
        case 1
            x=rand(n,1);                   % Uniform(0,1)
        case 2
            x=sqrt(rand(n,1));             % F(x) = x^2
        case 3
            x=rand(n,1).^(1/3);          
        case 4
            u=rand(n,1);
            x=(2/pi)*acos(1 - u);       
    end

    % Two estimators
    est1 = mean(x);              % correct Monte Carlo estimator
    est2 = mean(f(x).*x);        % WRONG estimator

    % True expectation by numerical integration
    trueVal = integral(@(t) t.*f(t),0,1);
    trueVal2= integral(@(x) x.*f(x).*f(x),0,1);
    fprintf('\nPDF: %s\n', names{k});
    fprintf('True E[X] = %.4f\n', trueVal);
    fprintf('True E[X.fX(x)] = %.4f\n', trueVal2);
    fprintf('Estimator 1 (mean xi) = %.4f\n', est1);
    fprintf('Estimator 2 (mean f(xi)xi) = %.4f\n', est2);
end
