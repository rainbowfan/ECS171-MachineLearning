data = read.csv('I:/ECS171/Dataset/finaldata.csv', stringsAsFactors = FALSE)
dim(data) #1532 55

data[, 'pct_ba'] = as.numeric(data[, 'pct_ba'])
data[, 'pct_grad_prof'] = as.numeric(data[, 'pct_grad_prof'])
data[, 'pct_born_us'] = as.numeric(data[, 'pct_born_us'])

data = data[, -c(1:3)] #remove first three columns
#omit na in the data
data = na.omit(data)

dat.stan = data
for(j in 1:ncol(data))
  dat.stan[,j] = (data[,j] - mean(data[,j]))/sd(data[,j])

cor(dat.stan) #correlation matrix
pairs(dat.stan) #scatter plot

#shuffle
dat.stan = dat.stan[sample(nrow(dat.stan), nrow(dat.stan)),]

sapply(1:46,function(i)plot(dat.stan[,i]))
colnames(dat.stan)
tr_data_x = dat.stan[1:1000, c(1:46)]
tr_data_y = dat.stan[1:1000, c(47:52)]
plot(tr_data_y[,1], type = 'l') #variation is stable dont need to transform
ts_data_x = dat.stan[1001:nrow(dat.stan), c(1:46)]
ts_data_y = dat.stan[1001:nrow(dat.stan), c(47:52)]

#lasso
library(glmnet)
#feature selection for mn_earnings
fit_mn = cv.glmnet(as.matrix(tr_data_x),tr_data_y[,1])
plot(fit_mn)
fit_mn$lambda.min
name_feature = rownames(coef(fit_mn)) 

table((coef(fit_mn) != 0)[,1]) #21 feature variables with non-zero coefficients
nonzero_v_ymn = name_feature[which(coef(fit_mn) != 0)][-1] #22
nonzero_v_ymn

#fit linear regression for mn 
#all features are considered
y_mn_all = lm(tr_data_y[,1]~.,tr_data_x)
summary(y_mn_all) 
mse_mn_l_tr = mean(y_mn_all$residuals^2) #training error 0.2293947
y_mn_all_ts = predict(y_mn_all, ts_data_x)
mse_mn_l_ts = mean((ts_data_y[,1]-y_mn_all_ts)^2) #testing error 0.345116

#lasso for mn
#predictors are reduced
y_mn_lasso_tr = predict(fit_mn, newx = as.matrix(tr_data_x))
mse_mn_lasso_tr = mean((y_mn_lasso_tr - tr_data_y[,1])^2) #training error 0.2720426
y_mn_lasso_ts = predict(fit_mn, newx = as.matrix(ts_data_x))
mse_mn_lasso_ts = mean((y_mn_lasso_ts - ts_data_y[,1])^2) #testing error 0.238153

#transform back
dat.stan[,j] = (data[,j] - mean(data[,j]))/sd(data[,j])
y_mn_lasso_ts_b = y_mn_lasso_ts*sd(data[,47]) + mean(data[,47])
ts_mn = ts_data_y[,1]*sd(data[,47]) + mean(data[,47])
par(mfrow = c(2,2))
plot(ts_mn, y_mn_lasso_ts_b, ylim = range(20000, 140000),xlab = 'Actual Mean Earnings (Testing Data)', ylab = 'Predicted Mean Earings', main = 'Lasso')
abline(0,1)
summary(y_mn_lasso_ts_b - ts_mn)
plot(y_mn_lasso_ts_b - ts_mn, ylab = 'Deviation from actual values', main = 'Deviation from actual values(lasso)')
abline(0,0)
boxplot(y_mn_lasso_ts_b - ts_mn)

#decision trees
library (gbm)
set.seed(1)
train = 1:1000
boost.mn=gbm(data[train, 47]~., data=data[train, c(1:46)], distribution="gaussian",
             n.trees=10000, interaction.depth= 5, cv.folds = 10)
plot(boost.mn$cv.error)
min(boost.mn$cv.error)

summary(boost.mn, cBars= 15, las = 1.5)
par(mfrow=c(1,1))
plot(boost.mn ,i="sat_avg")
plot(boost.mn ,i='faminc')

yhat.boost=predict (boost.mn,newdata =data[-train,c(1:46)],
                    n.trees=10000)
mean((yhat.boost - data[-train, 47])^2)
par(mfrow = c(1,1))
plot(data[-train, 47],yhat.boost,  ylim = range(20000, 140000), xlim = c(20000, 140000), main = 'Boosting', xlab = 'Actual Mean Earnings', ylab = 'Predicted Mean Earnings')
abline(0,1)
summary(yhat.boost - data[-train,47])
plot(yhat.boost - data[-train,47], ylim = c(-60000, 20000), ylab = 'Deviation from actual values', main = 'Deviation from actual values(boosting)')
abline(0,0)
boxplot(yhat.boost - data[-train, 47])

#compare with unstandardized linear model
y_mn_all = lm(data[train,47]~.,data[train,c(1:46)])
summary(y_mn_all) 
mse_mn_l_tr = mean(y_mn_all$residuals^2) #training error 0.2293947
y_mn_all_ts = predict(y_mn_all, data[-train, c(1:46)])
mse_mn_l_ts = mean((data[-train,47]-y_mn_all_ts)^2) #testing error 0.345116

predict_md=predict(fit_md,newx=as.matrix(ts_data_x))
y_mn = lm(tr_data_y[,1]~.,tr_data_x[, nonzero_v_ymn])
x = tr_data_y[,1]
y = fitted(y_mn)
plot(x,y)

y_mn_all = lm(tr_data_y[,1]~.,tr_data_x)
plot(x, fitted(y_mn_all))
