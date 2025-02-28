# DataMining: Top Revenue Generating Movies - Predicting Future Revenue Based on Attributes 


Introduction and Background 


For this project, we explored the relationships between variables of top revenue generating movies and then chose a model to predict future movie revenues. Our dataset covers the top 5000 movies on The Movie Database (TMDB) and was found on Kaggle. Originally, this dataset rated movies based on IMDb, but for legal reasons, it is now rated based on TMDB ratings.
The dataset lists 20 columns, such as revenue, budget, genres, popularity, runtime, spoken  languages, original title, production country, vote average, and vote count, and 4803 rows, but during the data cleaning process we found 2 missing values so the final amount of rows used for the project is 4801. Our dependent variable (y) is revenue, and the independent variables (x variables) are budget, popularity, runtime, and vote average. 
Popularity indicates the overall popularity of a movie among the audience, vote average indicates the average rate viewers have given to the movie, budget indicates how much money was spent making the movie, and runtime is how long the movie was.
The overarching research question is how do budget, popularity, vote average, and runtime affect the revenue of the movies, and ultimately, how will they help predict future movie revenues. This is an interesting question to explore because when filmmakers start producing a movie, they could adjust their budget or movie runtime based on information about what the predicted revenue could be. This research question will help understand how the variables affect movie revenues and how to predict them in the most accurate way so future film industry stakeholders can make informed decisions.
To start, we used inference where we tested which independent variables have a significant relationship with revenue. We used linear regression, multiple linear regression, created plots for the variables, and generated summary information to find the significance.
For prediction, we initially approached finding a model by using the K-fold approach, but ultimately performed it by using the validation set approach. Additionally, we used prediction and confidence intervals to show a range of where movie revenue could fall. Lastly, we also performed both a regression analysis and a classification analysis using the decision tree method.



Data Summary Statistics


  The summary of our dependent variable and the independent variable is as follows:       
<img width="571" alt="Screenshot 2024-02-06 at 9 12 15 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/ab2fba03-4b27-456f-85e2-fab183beb867">

  From the scatterplots, we can see that all of the independent variables have a somewhat positive relationship with the dependent variable (revenue).
  
<img width="654" alt="Screenshot 2024-02-06 at 9 12 56 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/db5a4212-e31f-4b7f-a26e-e952b1fde366">

  The higher the budget, the higher revenue a movie generates. For popularity levels,  most of the movies are between 0 and 200, but there exists a positive correlation where the higher the popularity level, the higher the revenue. For vote average, between 6 and 8 votes, the revenue starts to increase proportionally to the vote average.  For run time, there is not a clear association in the graph, which was later confirmed by the significance test performed during the multilinear regression part.



Data Mining Method Description 


Inference

Simple Linear Regression

  As mentioned in the introduction, the purpose of the project is to understand how individual independent variables (budget, popularity, and vote average) relate to the dependent variable (revenue). By creating a linear regression model, we seek to establish and quantify these relationships and estimate future movie revenues based on the identified patterns in the data. The use of a regression model allowed for a systematic analysis of the impact of each independent variable on the dependent variable and helped make predictions for new movies based on their characteristics. 
  We used the lm() function to create a linear regression model in R. By using the simple linear regression model, the intercept and coefficients (beta) for each variable were generated, thus creating the equation to predict revenue. Below are the summary visualizations of each independent variable and their relationships with revenue. 

<img width="571" alt="Screenshot 2024-02-06 at 9 13 28 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/f16e8db0-ce64-4985-925a-7f2a5d8040e6">

  In each case, the remarkably low p-values (<0.05) indicate that the positive association between all four independent variables and revenue holds considerable significance. Further analysis or consideration of additional variables may improve the model's predictive accuracy. These coefficients can be used in the linear regression equation to predict movie revenue based on the corresponding independent variable values.  
  When looking at the regression model summaries, it appears that very low p-values indicate the 4 independent variables are statistically significantly associated with the dependent variable (revenue). However, it doesn't necessarily mean that the association is practically significant or that the model is the best fit.
The R-square in the summary served as an indicator of how effectively our statistical model predicted the observed outcomes in the dataset. ‘Run time’ and ‘vote average’ are close to 0 which indicate that the models explain none of the variability in the dependent variable. However, ‘budget’ and ‘popularity’ are closer to 1 which suggest that a larger proportion of the variance in our dependent variable is accounted for by those independent variables. The high RSE values meant a high deviation of our model from the true regression line.
  We created diagnostic plots as they are essential in simple linear regression to assess the validity of the underlying assumptions (linearity, independence, homoscedasticity, and normality of residuals). The red line in the plots is the line of best fit and helps visualize how well the model fits the data. The black dots on the plots represent the residuals. In our diagnostics plots we conclude that the black dots mostly are randomly scattered around the red line with no clear pattern. It appears they have many extreme high/low values.

<img width="644" alt="Screenshot 2024-02-06 at 9 13 53 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/880c752e-47c5-4cee-86d3-7ba21b344c18">

  The Residuals vs Fitted plots show a random scatter of points around the horizontal axis with no clear pattern. This suggests that the relationship between the independent and dependent variables is adequately captured by the model. The Q-Q Residual plot indicates whether the residuals follow a normal distribution or not, and in each variable’s plots, we can see that there are outliers which indicate non-normality in the residuals. The third plot, scale-location, assesses homoscedasticity, which means constant variance of residuals. None of the variables show consistent spread points therefore we can conclude that the outliers in the spread may indicate heteroscedasticity. Lastly, the outlying points of the fourth plot in each variable in terms of leverage and residuals tell us that these points have high influence on the estimated coefficients.
  After identifying numerous unusual x variables, outliers, and high leverage points, we revisited our dataset to make adjustments to improve the model’s accuracy. 
Multilinear Regression and Interaction Terms
	For the multilinear regression equation, we used the same variables as above for the simple linear regression. This was done to check for the significant values for each independent variable as a part of a multilinear regression equation. The result is as follows:

<img width="247" alt="Screenshot 2024-02-06 at 9 14 50 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/77563ec3-632e-41d9-893a-9e9df78139a7">

Analyzing the p-value for each variable,  ‘budget’, ‘popularity’ and ‘vote_average’ have very small p-values (<0.05), which makes them significant variables for our model. In contrast, ‘runtime’ has a high p-value (0.52), which means that the variable is not significant. Using backward selection, we removed the ‘runtime’ variable from our model.

<img width="301" alt="Screenshot 2024-02-06 at 9 15 14 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/37954cd9-3833-4d66-8bbf-c46e3da02bd4">

  The positive correlation for ‘budget’ indicates that the revenue will increase if the budget increases. This idea is also supported by the research paper, Analysis of Relations Between Budgets and Revenues from Movies, Devansh Hingad, who states that as the budget increases, revenue will also increase. Similarly, the ‘popularity’ coefficient has a positive correlation with revenue, the more people watching the movie, the higher the popularity, and thus, higher the box-office return which indicates the movie revenue. Lastly, ‘vote_average’ also shows a positive correlation, which indicates a growth in revenue as the vote average increases. According to research done by the Journal of Marketing, the ratings for movies affect revenues, particularly when these ratings are initially rated by professional critics; high ratings from professional critics lead to high ratings by amateurs “which in turn can contribute to enhanced revenues” (Moon).
  Next, we calculated the VIF to assess multicollinearity; the values all appear to be close to 1, which indicates low multicollinearity and is ideal for the model.    

<img width="378" alt="Screenshot 2024-02-06 at 9 15 46 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/12134266-61ff-4844-bf2d-55b248208175">

  Following the multilinear regression, we used interaction terms to see the relationship between our significant predictor variables, ‘budget’, ‘popularity’, and ‘vote_average’ - as well as how it impacts ‘revenue’, our y variable. Since runtime is insignificant , we did not include it in our interactions. 
  Based on our results, they seem to indicate that the combined effects on movie revenue are not just the sum of the main effects. For budget:popularity, it appears that budget weakens the effect of popularity as the interaction term is a lower positive value. Similarly, for budget:vote_average, it appears that budget weakens the effect of vote_average as the interaction term is a lower positive value. Lastly, for popularity: vote_average, it appears that popularity significantly weakens the effect of vote_average since the interaction term is a large negative value. This is unique since both main effects have positive coefficients but the interaction term is negative; this could be a result of multicollinearity since the main effects could be influenced by the joint effects which could lead to unexpected signs for the interaction term. All interaction terms showed significance with budget: vote_average and popularity:vote_average at the lowest p-value of <2e-16, signifying strong interaction effects.

  <img width="660" alt="Screenshot 2024-02-06 at 9 16 37 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/14a38856-9aee-4e9a-859c-36361a614041">

  For our hypothesis testing, using the independent variables ‘budget’, ‘popularity’, and ‘vote_average’, we have Ho: B1=0, B2=0, B3=0, and Ha: at least one B is non 0, meaning that there is a statistical significant difference between a variable and revenue. Based on the high F-statistic result, 2115, the model is statistically significant, so we reject Ho and accept the alternative hypothesis, Ha. 

  
Prediction


Prediction and Confidence Interval

  To further explore the regression model in the previous section, we ran multiple prediction interval and confidence interval tests based on the simple linear regression models presented above. We wanted to see where the predicted revenues for movies could fall given some value for the independent variable and the sample results are as follows:

<img width="706" alt="Screenshot 2024-02-06 at 9 17 12 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/4cd7d78e-242e-46a4-bc08-14f2cced581e">

  In all cases above, the prediction interval contained a much wider range than the confidence interval as it considered the variability in data and uncertainty associated with the individual predictor values.

  
Training and Testing Dataset

  To assess the performance of our prediction model and create our testing and training dataset, the first approach we decided to use was the K-fold method because it trains the model using different data parts, providing a less biased model. To see how well the model performed, we ran the glm.fit function and then the cross-validation error. We utilized a model with 10 K-folds, and the values from the cross-validation error were extremely high (1.237291e^16, 1.216720e^16, 1.212364e^16, 1.234499e^16, 1.308496e^16,  4.889757e^16, 1.198987e^17,  3.092019e^16, 7.094536e^, and 17 5.391929e^19), which indicates that the model might not perform well on new data and could result in overfitting.
  Thus, we decided to use the validation set approach. We divided our data into two parts: the first half became the training dataset and the second half became the testing dataset. Based on the training dataset, we ran a multilinear regression equation and then calculated the mean squared error. We repeated this process to fit a quadratic and cubic regression and got the MSE for those models as well. The results are as follows: 

<img width="651" alt="Screenshot 2024-02-06 at 9 17 45 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/fb9866b7-f2df-4c3e-8a96-5ac02e1baf1d">

  Based on the above, the multiple linear regression model is the most appropriate model as it had the lowest mean squared error. The total variability in the response variable, TSS, is very high, 1.273472*10^20, indicating that the response variable has a large variability across the dataset. However, the R-squared value of 0.6381 is closer to 1 than 0  which indicates that the model explains a large part of that variability. 
  The F-statistic calculated for the regression model, which evaluates the overall significance, is high at 1337.192 , indicating that the model is overall statistically significant, and the RSE calculated is also high, 98097345, which indicates a high variability. Even though we see the high variability in the RSE,which shows the difference between the observed and the predicted value, in the context of ‘revenue’ it makes sense for the model, since the value of revenue could be anywhere from 0 to infinity, which also indicates a high variability rate, seeing that the value can vary depending on many variables. 


Predicting Future Revenue

  For predicting future revenues, we developed a predictive equation, using the predict function in R, to forecast the future revenue based on independent variables such as budget, popularity, and vote average. The model and coefficients are as follows: 
Revenue = Intercept + (B1 x Budget) + (B2 x Popularity) + (B3 x Vote Average)

<img width="642" alt="Screenshot 2024-02-06 at 9 18 17 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/c4fd5c73-ffa2-4844-a22e-e014900d49a2">

We randomly selected two rows (2816 and 4163) from the testing dataset to apply to the model to see how well it performed. We used the provided values for each independent variable in the respective rows. We calculated the predictions by using the betas from regression. The results represent the predicted revenue for the given rows based on the linear regression model and the specified coefficients. They are as follows:

<img width="637" alt="Screenshot 2024-02-06 at 9 18 40 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/5ae93c30-1de0-4458-ac13-72c7263c7dcf">

  We underestimated the first prediction and overestimated the second prediction. We concluded that our R prediction was off because our model is not the best since it had a high RSE indicating that yhat was very different from the actual value.  
Regression Tree Method
  In addition to the above, we utilized the Decision Tree to help predict movie revenue. Through implementing the Regression Tree Method, we found that the most notable independent variables that affect the prediction were the ‘budget’ and ‘popularity’. These two variables were at internal node positions that decided where a movie’s revenue would fall. Since our regression tree was relatively short and balanced, with 9 terminal nodes, we did not further prune the tree. The regression tree is as follows:

  <img width="564" alt="Screenshot 2024-02-06 at 9 19 40 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/16814801-e192-440b-a8a0-d73254adce83">


  Classification Tree Method
  
  We also utilized the Classification Tree Method to help identify which movies would be a success or not. The standard here was that if a movie generated any profit, so a revenue amount greater than the budget, the movie would be considered a success. Using this criteria, we added a new column to the existing dataframe called "Success" which contained two qualitative variables: "No" and "Yes". The logic in this column is if a movie had greater revenue than budget, it would fall under "Yes" and if the movie had less or equal revenue than budget, it would fall under "No".
  Next, a classification tree was implemented. Based on the results, there are 4 terminal nodes and have a misclassification error rate of 0.2214. We evaluated the model by splitting it into a testing and training set and predicting classification on the test dataset; from here, we then created a confusion table that resulted in 549 False and 1852 True and presented an accuracy rate of 0.77. The classification tree is as follows below: 

  <img width="551" alt="Screenshot 2024-02-06 at 9 20 17 AM" src="https://github.com/gabidasanches/DataMining-Top-Revenue-Generating-Movies/assets/123784158/6d476480-50d5-471c-9214-82d6d83cd164">


  Conclusion
  
For this project, our aim was to better understand how ‘budget’, ‘runtime’, ‘vote average’, and ‘popularity’ affected the revenue of a movie. For the first part, we focused on inference. ‘Runtime’ has been proven to be statistically insignificant and will likely have no effect on the revenue of a movie. On the other hand, ‘budget’ was the most statistically significant, followed by ‘vote average’ and ‘popularity’. 
Our second part focused on the prediction. We created models using a simple linear regression and multilinear regression which allowed us to predict future revenue of movies based on our predictors. However, since we had a high RSE, we didn’t find the exact revenue that matched the one in our test and training set. Additionally, we used precision intervals, confidence intervals, and decision trees to further explore predicting movie revenue. But based on the results, we were still able to conclude that the higher the budget, the higher the revenue. Overall, after all the various testings and analyses, we now have a better insight of the relationships between each variable and movie revenue. 


Research

 To support our findings, we have researched a few articles that have reached similar conclusions. According to the newsletter Why Content is King by Nathan Baschez, higher budget equates to a higher box office return. In addition, movies that are more expensive to make have almost always broken even and are more likely to be successful. In the research paper, Analysis of Relations Between Budgets and Revenues from Movies, Devansh Hingad also reached the same conclusion. He further states the vice verse, where a decrease in budget causes a decrease in revenue. However, the idea that less budget means less revenue is not supported by Nathan Baschez. Baschez has stated that the positive correlation between budget and revenue only applies after a certain amount of budget. For movies with lower budget, it does not necessarily increase the chances of less revenue. Regardless, both have supported the idea that budget have a significant impact on revenue and that a higher budget will increase the amount of revenue for the movie. In addition, the research done by the Journal of Marketing also supports our findings for vote average - that high ratings can contribute to a higher revenue.

 
Limitations to Research

Overall, while we have delved into quite a few independent variables that could impact a movie's revenue, there could be other lurking variables that are hard to capture. Our data and analysis does not consider a movie’s showing times at a theater, month of release, popularity of the actors and film directors, limiting our research and predictions to the variables that are available in the TMDB dataset. 


Practical Implications

The analyses done in this project will allow real world stakeholders in the movie industry to decide what areas they should focus on to maximize their movies’ revenues. For example, a producer may look at a movie’s genre and runtime before deciding on shooting the movie, or perhaps an investor may look at the budget before investing, or perhaps the marketing department for a movie company will focus on raising popularity and vote averages. We believe the results obtained from this project will benefit many across the movie industry.
