function [theta, MSE] = OLSestimate_all7var(order_poly, data_normalized)

   m = size(data_normalized, 1);
   X = [ones(m, 1), data_normalized(:, 2:8), data_normalized(:, 2:8).^2];
   X_design = X(:, 1: (1 + 7*order_poly));
   Y = data_normalized(:, 1);
   theta = inv(X_design'*X_design)*(X_design')*Y;
   pred = X_design* theta;
   sqrErrors = (pred - Y).^ 2;
   MSE = 1/m * sum(sqrErrors);


end

