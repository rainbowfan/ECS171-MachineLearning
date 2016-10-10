function [MSE, w] = LogisticRegression(data_normalized, alpha)

   m = size(data_normalized, 1);
   X = [ones(m, 1), data_normalized(:, 2:8)];
   Y = data_normalized(:, 1);
   w = GradientDescent(X, Y, alpha);
   pred = (1 + exp(- X* w)).^(-1);
   sqrErrors = (pred - Y).^ 2;
   MSE = 1/m * sum(sqrErrors);


end