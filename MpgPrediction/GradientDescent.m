function [w] = GradientDescent(X,Y,alpha)
m = size(X,2);
w= zeros(m,1);
for k = 1:600 
    for i = 1:size(X,1) 
        w=w+alpha*(Y(i)-(1+exp(-X(i,:)*w))^(-1)).*X(i,:)'; 
    end
end
end
