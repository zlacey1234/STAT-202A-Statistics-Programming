## Homework 2 Question 2
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: October 20th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 2
## Due Date: October 26th, 2021 (Tuesday), 11:59 PM PST
##
## Question 2
##

library(tidyverse)

## 2. Identification of influential points in multivariate regression.
##
##    The purpose of this problem is to investigate how influential 
##    each point in a dataset is on a particular regression estimate.
##
##    a. Median sale prices data for Los Angeles County Housing in Aug 
##       2013 from the Los Angeles Times were compiled into the file 
##       LAhousingpricesaug2013.txt and placed on the course website. 
##       Let $Y$ = sales of single family homes in August, $X_{1}$ = 
##       median price of a single family residence (SFR) in thousands 
##       of dollars, $X_{2}$ = median price of a condo in thousands of 
##       dollars, and $X_{3}$ = median home price per square foot, in 
##       dollars. (Note that, in the original LA Times dataset, some 
##       of the names of the cities had spaces in them, and some of 
##       the numbers have commas in them. These problems have been 
##       removed in the LAhousingpricesaug2013.txt file.) Each of 
##       these 4 vectors initially has length 269. If any row has an 
##       "n/a" in it for any of these 4 variables, then remove this 
##       entire row. Now each vector will have length 217.

LAHousingPriceAug2013URL = 
  "http://www.stat.ucla.edu/~frederic/202a/F21/LAhousingpricesaug2013.txt"

housingData = read_table(LAHousingPriceAug2013URL)

print(housingData)

##    b. Perform regression (with intercept) of $Y$ on $X = {X_{1}, 
##       X_{2}, X_{3}}$ to compute a vector of parameter estimates, 
##       $\hat{\beta} = (\hat{\beta}_{0}, \hat{\beta}_{1}, 
##       \hat{\beta}_{2}, \hat{\beta}_{3})$, where $\hat{\beta}_{0}$, 
##       is the estimate intercept and for $i = 1, 2, 3$, 
##       $\hat{\beta}_{i}$, is the slope of the corresponding to 
##       explanatory variable $X_{i}$. Record $\hat{\beta}_{1}$.

##    c. Let $i = 1$. Perform regression with intercept of $Y$ on 
##       $X$ with row $i$ removed from the dataset. Let 
##       $\hat{\beta}_{^{(-i)}}$, denote your resulting vector of 
##       parameter estimates so that $\hat{\beta}_{1^{(-i)}}$, is 
##       your estimate of the slope corresponding to $X_{1}$. Record 
##       $\hat{\beta}_{1^{(-i)}} - \hat{\beta}_{1}$.

##    d. Repeat part (C) for $i = 2, 3, 4, \dots, 217$.

##    e. Plot the influences, $\hat{\beta}_{1^{(-i)}} - 
##       \hat{\beta}_{1}$, versus $i$. That is, the x-axis will span 
##       from $i = 1$ to $217$, and the y-axis will be 
##       $\hat{\beta}_{1^{(-i)}} - \hat{\beta}_{1}$, which indicates 
##       the influence of observation $i$ on the estimated slope.


