#create dataframe to read csv into R
df <- read.csv("tmdb_5000_movies.csv")
View(df)

#checking if there are any na values and creating new df that omits the missing values
na_checking <- is.na(df)
print(na_checking, TRUE)
true_values <-which(na_checking, arr.ind = TRUE)
print(true_values)
df <- na.omit(df)

#summary of variables
dim(df)
summary(df)


#utilizing stargazer package to create tables
#install.packages("stargazer")
library(stargazer)
stargazer(df, type="text",title="Summary Table", out = "summarytable.txt")

#creating scatter plots
par(mfrow = c(2, 2))
plot(df$budget, df$revenue, xlab = "Budget", ylab = "Revenue")
plot(df$runtime, df$revenue, xlab = "Runtime", ylab = "Revenue")
plot(df$popularity, df$revenue, xlab = "Popularity", ylab = "Revenue")
plot(df$vote_average, df$revenue, xlab = "Vote Average", ylab = "Revenue")


#linear regression
lm_budget <- lm(revenue ~ budget, data = df)
lm_runtime <- lm(revenue ~ runtime, data = df)
lm_vote <- lm(revenue ~ vote_average, data = df)
lm_popularity <- lm(revenue ~ popularity, data = df)

summary(lm_budget)
summary(lm_runtime)
summary(lm_vote)
summary(lm_popularity)

#simple linear regression summary table using stargazer 
stargazer(lm_budget, type="text", report=("vc*p"))
stargazer(lm_runtime, type="text", report=("vc*p"))
stargazer(lm_vote, type="text", report=("vc*p"))
stargazer(lm_popularity, type="text", report=("vc*p"))


#creating diagnostic plots of the least squares regression fit - visualization of data 
par(mfrow = c(2,2))
plot(lm_budget)
plot(lm_runtime)
plot(lm_vote)
plot(lm_popularity)
###*** run the above plot codes one by one not all together otherwise you’ll get an error or the graphics won’t appear.

#what is the predicted revenue if budget is $20m?
predict(lm_budget,data.frame(budget=(c(20000000))), interval="confidence")
predict(lm_budget,data.frame(budget=(c(20000000))), interval="prediction")
#what is the predicted revenue if runtime is 150 minutes?
predict(lm_runtime,data.frame(runtime=(c(150))), interval="confidence")
predict(lm_runtime,data.frame(runtime=(c(150))), interval="prediction")
#what is the predicted revenue if vote average is 7?
predict(lm_vote,data.frame(vote_average=(c(7))), interval="confidence")
predict(lm_vote,data.frame(vote_average=(c(7))), interval="prediction")
#what is the predicted revenue if popularity is 150?
predict(lm_popularity,data.frame(popularity=(c(150))), interval="confidence")
predict(lm_popularity,data.frame(popularity=(c(150))), interval="prediction")


#Multilinear Regression 
lm.fit1 = lm(revenue ~ budget + popularity + runtime + vote_average, data=df)
summary(lm.fit1)
stargazer(lm.fit1, type="text",title="Multilinear Regression Results", out = "multilinear.txt",  report=("vc*p"))


# ----- Budget, popularity, vote_average are significant ------
# ----- Runtime is not significant  ------

#test VIF
library(car)
vif(lm.fit1)


#backward selection to remove the non-significant variables, that have p-value higher than 0.005
lm.fit1 <- update(lm.fit1, . ~ . - runtime)
summary(lm.fit1)
stargazer(lm.fit1, type="text",title="Multilinear Regression Results (after backward selection)", out = "multilinear.txt",  report=("vc*p"))

#Test VIF with only the significant variables 
vif(lm.fit1)
  
  # ----- All VIF values are bellow the common threshold of 5, which indicates an acceptable level of multicollinearity. -----



# Interaction Terms
it1 = lm(revenue ~ budget * popularity,data=df)
summary(it1)

it2 = lm(revenue ~ budget * vote_average,data=df)
summary(it2)

it3 = lm(revenue ~ popularity * vote_average,data=df)
summary(it3)


# Residual
residuals <- residuals(lm.fit1)
rse <- sqrt(sum(residuals^2) / (length(residuals) - ncol(model.matrix(lm.fit1))))
rse
rsquared <- summary(lm.fit1)$r.squared
rsquared

#K fold CV training/testing
#library(boot)
#glm.fit=glm(revenue~budget + popularity + vote_average, data=df)
#summary(glm.fit)
#cv.err=cv.glm(df,glm.fit)
#cv.err
#set.seed(17)
#cv.error.10 <- rep(0,10)
#for (i in 1:10){
#  glm.fit=glm(revenue~poly(budget + popularity + vote_average,i),data=df)
#  cv.error.10[i]=cv.glm(df,glm.fit,K=10)$delta[1]
#}
#cv.error.10

#validation set
library(ISLR)
set.seed(3)
train=sample(1:nrow(df), 0.5 *nrow(df))
test= setdiff(1:nrow(df), c(train))

lm.fit=lm(revenue~budget + popularity + vote_average, data=df,subset=train)
summary(lm.fit)
mean((df$revenue-predict(lm.fit,df))[-train]^2)
anova(lm.fit)

#quadratic
lm.fit2=lm(revenue~poly(budget + popularity + vote_average, 2),data=df,subset=train)
summary(lm.fit2)
mean((df$revenue-predict(lm.fit2,df))[-train]^2)

#cubic
lm.fit3=lm(revenue~poly(budget + popularity + vote_average, 3),data=df,subset=train)
summary(lm.fit3)
mean((df$revenue-predict(lm.fit3,df))[-train]^2)

  #Choosing the model with the lowest error or highest R-squared
    #model lmfit (the first try) - because it has the highest Rsquared value, and the lowest error rate 
      
#Calculating TSS - Total Variability in the response variable (revenue)
TSS <- sum((df$revenue - mean(df$revenue))^2)
TSS

F_statistic <- summary(lm.fit)$fstatistic[1]
F_statistic

  #Even though we have a high TSS, the Rsquared is close to 1, which indicates a better-fit model, RSE, which measures the error, is relatively small, 
    #and all variables have small p-values (they are significant)


#predict the future revenue based on independent variables (budget,popularity,vote_average)

#for predicting the future revenue, we will use 
  #Intercept: -5.478e+07
  #Budget: 2.122e+00 
  #Popularity: 1.978e+06
  #Vote Average: 5.343e+06


#for row 2816 - actual revenue is 96,800,000

predicted_revenue1 <- (-5.47*10^7) + (2.122 *12000000) + ((1.978*10^6)*22.434102) + ((5.343*10^6)*7.3)
predicted_revenue1

#for row 4163 - actual revenue is 19,152,480

predicted_revenue2 <- (-5.47*10^7) + (2.122  *1987650) + ((1.978*10^6)*32.841229) + ((5.343*10^6)*6.6)
predicted_revenue2

#Using Decision Tree to predict movie revenue
library(tree)
train = sample(1:nrow(df), 0.5*nrow(df))
tree.df=tree(revenue~budget+popularity+vote_average,df, subset=train)
summary(tree.df)
plot(tree.df)
text(tree.df,pretty=0)
tree.df

#Pruning tree - ultimately we decided not to since the original decision tree only has 11 leaves and looks balanced
#cv.df=cv.tree(tree.df)
#cv.df
#plot(cv.df$size,cv.df$dev,type='b')
#yhat=predict(tree.df,newdata=df[-train,])
#df.test=df[-train,"medv"]
#plot(yhat,df.test)
#abline(0,1)
#mean((yhat-df.test)^2)

# Using Decision Tree to decide whether a movie will be a success or not
Success = as.factor(ifelse(df$revenue <= df$budget, "No", "Yes"))
df = data.frame(df, Success)
tree.df = tree(Success~budget+popularity+vote_average, df)
summary(tree.df)
#plotting decision tree
plot(tree.df)
text(tree.df, pretty = 0)
#evaluating this tree
set.seed(2)
#train = sample(1:nrow(df), (4803/2))
train=sample(1:nrow(df), 0.5 *nrow(df))
df.test = df[-train,]
Success.test = Success[-train]
tree.df = tree(Success~budget+popularity+vote_average, df, subset = train)
tree.pred = predict(tree.df, df.test, type = "class")
table(tree.pred == Success.test)
mean(tree.pred == Success.test)
