%ECS171
%homework1
%Student: Hong Fan

%Question1:
 data = load('E:\ECS171\Dataset\auto_mpg1.txt','-ascii');
 mpg = data(:, 1);
 p1 = prctile(mpg, 33);
 p2 = prctile(mpg, 66);
 min_mpg = min(mpg);
 max_mpg = max(mpg);
 
%Question2:
%Add one column to data : 1 represents low mpg, 2 represents median mpg and 3 represents high mpg 
 for i = 1:392;
       if data(i, 1) < p1,
          data(i, 9) = 1;
       elseif data(i, 1) < p2 & data(i, 1) > p1,
          data(i, 9) = 2;
       else data(i, 1) > p2,
          data(i, 9) = 3;
       end;
end;

%Normalization
for i = 1:8;
    data(:, i) = (data(:, i) - min(data(:, i)))./(max(data(:, i)) - min(data(:, i)));
end;

Varnames = ['mpg         '; 'cylinders   '; 'displacement'; 'horsepower  ';'weight      ';'acceleration';'year        ';'origin      '];  

figure
gplotmatrix(data(:, 1:8), [], data(:, 9), ['g', 'b', 'r'], [],[],[],[], Varnames, []);

%Question3:
%Please check OLSestimate.m
%one_ind_var asks the user to type index(2-cylinders, 3- displament, 4- horsepower, 5 � weight, 6- acceleration, 7-model year, 8- origin).

%Question4:
training_dat = data(1:280, :);
test_dat = data(281:392, :);

%single variable--cylinders
x = test_dat(:, 2);
y = test_dat(:, 1);

%MSE--training data
%0th order polynomial
[theta, MSE ] = OLSestimate(training_dat, 0, 2) 

%1st order polynomial
[theta, MSE ] = OLSestimate(training_dat, 1, 2) 
[theta, MSE ] = OLSestimate(training_dat, 1, 3)
[theta, MSE ] = OLSestimate(training_dat, 1, 4)
[theta, MSE ] = OLSestimate(training_dat, 1, 5)
[theta, MSE ] = OLSestimate(training_dat, 1, 6)
[theta, MSE ] = OLSestimate(training_dat, 1, 7)
[theta, MSE ] = OLSestimate(training_dat, 1, 8)

%2nd order polynomial
[theta, MSE ] = OLSestimate(training_dat, 2, 2) 
[theta, MSE ] = OLSestimate(training_dat, 2, 3)
[theta, MSE ] = OLSestimate(training_dat, 2, 4)
[theta, MSE ] = OLSestimate(training_dat, 2, 5)
[theta, MSE ] = OLSestimate(training_dat, 2, 6)
[theta, MSE ] = OLSestimate(training_dat, 2, 7)
[theta, MSE ] = OLSestimate(training_dat, 2, 8)

%3rd, 4th by replacing 2 into 3, 4
%MSE for test data--replacing training_dat by test_dat 

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 2);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 2);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 2);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 2);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 2);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('cylinders')
ylabel('mpg')


%single variable--displacement
x = test_dat(:, 3);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 3);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 3);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 3);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 3);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 3);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('displacement')
ylabel('mpg')


%horsepower
x = test_dat(:, 4);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 4);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 4);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 4);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 4);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 4);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('horsepower')
ylabel('mpg')

%weight
x = test_dat(:, 5);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 5);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 5);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 5);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 5);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 5);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('weight')
ylabel('mpg')

%acceleration
x = test_dat(:, 6);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 6);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 6);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 6);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 6);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 6);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('acceleration')
ylabel('mpg')

%year
x = test_dat(:, 7);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 7);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 7);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 7);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 7);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 7);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('year')
ylabel('mpg')

%origin
x = test_dat(:, 8);
y = test_dat(:, 1);

x_new = 0:0.001:1;
y0 = OLSestimate(test_dat, 0, 8);
y0_fit = y0;

y1 = OLSestimate(test_dat, 1, 8);
y1_fit = y1(1) + y1(2)* x_new;

y2 = OLSestimate(test_dat, 2, 8);
y2_fit = y2(1) + y2(2)* x_new + y2(3)*(x_new.^2);

y3 = OLSestimate(test_dat, 3, 8);
y3_fit = y3(1) + y3(2)*x_new + y3(3)*(x_new.^2)+ y3(4)*(x_new.^3);

y4 = OLSestimate(test_dat, 4, 8);
y4_fit = y4(1) + y4(2)*x_new + y4(3)*(x_new.^2)+ y4(4)*(x_new.^3) + y4(5)* (x_new.^4);


figure
plot(x,y,'*',x_new, y0_fit,'r', x_new,y1_fit,'b', x_new, y2_fit,'k', x_new, y3_fit,'g', x_new, y4_fit,'y');
title('Model Fitting with Single Variable')
xlabel('origin')
ylabel('mpg')


%Question 5
[ theta, MSE] = OLSestimate_all7var(0, training_dat) %zero order using training data
[ theta, MSE] = OLSestimate_all7var(1, training_dat) %first order using training data
[ theta, MSE] = OLSestimate_all7var(2, training_dat) %second order using training data

[ theta, MSE] = OLSestimate_all7var(0, test_dat) %zero order using test data
[ theta, MSE] = OLSestimate_all7var(1, test_dat) %first order using test data
[ theta, MSE] = OLSestimate_all7var(2, test_dat) %second order using test data

%Question 6
%set alpha = 0.05
%MSE in training data
[pred, MSE] = LogisticRegression(training_dat, 0.05)
%MSE in test data
[pred, MSE] = LogisticRegression(test_dat, 0.05)

%find thresholds 
%after min_max normalization, boundary separating low and median mpg
%becomes:
p1_normalized = (p1 - min_mpg)/(max_mpg - min_mpg) %p1_normalized = 0.2557
%boundary separating median and hign mpg becomes
p2_normalized = (p2 - min_mpg)/(max_mpg - min_mpg) %p2_normalized = 0.4764

%Question7
data_o= load('E:\ECS171\Dataset\auto_mpg1.txt','-ascii');
x1 = (6 - min(data_o(:,2)))/(max(data_o(:,2))-min(data_o(:,2)));
x2 = (300 - min(data_o(:,3)))/(max(data_o(:,3))-min(data_o(:,3)));
x3 = (170 - min(data_o(:,4)))/(max(data_o(:,4))-min(data_o(:,4)));
x4 = (3600 - min(data_o(:,5)))/(max(data_o(:,5))-min(data_o(:,5)));
x5 = (9 - min(data_o(:,6)))/(max(data_o(:,6))-min(data_o(:,6)));
x6 = (80 - min(data_o(:,7)))/(max(data_o(:,7))-min(data_o(:,7)));
x7 = (1 - min(data_o(:,8)))/(max(data_o(:,8))-min(data_o(:,8)));

%Use second-order, multi_variate polynomial:
theta = OLSestimate_all7var(2, data)
X = [1, x1, x2, x3, x4, x5, x6, x7, x1.^2, x2.^2,x3.^2,x4.^2, x5.^2,x6.^2,x7.^2]
mpg_pred = X*theta %mpg_pred = 0.3280 --is predicted to be median mpg

%Use logistic regression:
%[MSE, w] = LogisticRegression(data_normalized, alpha) 
%get w---[MSE, w] = LogisticRegression(data, 0.05); 
w = [-0.0489; 0.0168;0.5651;-1.0329;-2.8594;0.0663;1.2035;0.2445];
X_d = X(1:8)
mpg_pred = (1 + exp(- X_d* w)).^(-1) %mpg_pred = 0.2689 -- is predicted to be median mpg


