% Define p(s) as an element-wise function
p = @(s) 1 - (1./s).^(1./s);

% Evaluate the function p for a range of s values
sValues = linspace(1, 10, 100);
pValues = p(sValues);

% Plot the results
figure
plot(sValues, pValues, 'LineWidth', 1.5);
xlabel('s values');
ylabel('p(s)');
title('Plot of p(s) vs s');
grid on;
hold on;

% Add vertical lines at every integer from 1 to 10
for k = 1:10
    xline(k, '--k'); % dashed black vertical line
end
