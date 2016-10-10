function [theta, MSE ] = OLSestimate(data_normalized, order_poly, one_ind_var)

   m = size(data_normalized, 1);
   X = [ones(m, 1), data_normalized(:, one_ind_var), data_normalized(:, one_ind_var).^2, data_normalized(:, one_ind_var).^3, data_normalized(:, one_ind_var).^4];
   X_design = X(:, 1: (order_poly + 1));
   Y = data_normalized(:, 1);
   theta = inv(X_design'*X_design)*(X_design')*Y;
   pred = X_design * theta;
   sqrErrors = (pred - Y).^ 2;
   MSE = 1/m * sum(sqrErrors);

end

