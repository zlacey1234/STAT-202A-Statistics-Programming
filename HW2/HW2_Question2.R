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

# Housing Data [X]
housingData = read.table(LAHousingPriceAug2013URL, header = TRUE)

# Sales of Single Family Homes [Y]
salesSingleFamilyHomes = 
  as.numeric(as.vector(housingData[, 3]))

# Median Price of Single Family Residence [X1]
medianPriceSFR = 
  as.numeric(as.vector(housingData[, 4]))

# Median Price of Condos [X2]
medianPriceCondo = 
  as.numeric(as.vector(housingData[, 7]))

# Median Home Price Per Square Foot [X3]
medianHomePriceSqFt =
  as.numeric(as.vector(housingData[, 9]))

# Vector that is the sum of the Y, X1, X2, X3 vectors (where if 
# any of the rows have NA, then NA is coerced to the summation 
# value). So any row that has a NA in any of the four variables
# will have NA value in the corresponding row of checkForNAVector.
checkForNAVector = 
  (salesSingleFamilyHomes + medianPriceSFR 
   + medianPriceCondo + medianHomePriceSqFt)

rowIndexBooleanNoNA = !is.na(checkForNAVector)

# Sales of Single Family Homes [Y]
Y = salesSingleFamilyHomes[rowIndexBooleanNoNA]

# Median Price of Single Family Residence [X1]
X1 = medianPriceSFR[rowIndexBooleanNoNA]

# Median Price of Condos [X2]
X2 = medianPriceCondo[rowIndexBooleanNoNA]

# Median Home Price Per Square Foot [X3]
X3 = medianHomePriceSqFt[rowIndexBooleanNoNA]


##    b. Perform regression (with intercept) of $Y$ on $X = {X_{1}, 
##       X_{2}, X_{3}}$ to compute a vector of parameter estimates, 
##       $\hat{\beta} = (\hat{\beta}_{0}, \hat{\beta}_{1}, 
##       \hat{\beta}_{2}, \hat{\beta}_{3})$, where $\hat{\beta}_{0}$, 
##       is the estimate intercept and for $i = 1, 2, 3$, 
##       $\hat{\beta}_{i}$, is the slope of the corresponding to 
##       explanatory variable $X_{i}$. Record $\hat{\beta}_{1}$.

Beta = lm(Y ~ X1 + X2 + X3)

Beta0 = Beta$coefficients[1]
Beta1 = Beta$coefficients[2]
Beta2 = Beta$coefficients[3]
Beta3 = Beta$coefficients[4]

attributes(Beta)
summary(Beta)

print(Beta1)

##    c. Let $i = 1$. Perform regression with intercept of $Y$ on 
##       $X$ with row $i$ removed from the dataset. Let 
##       $\hat{\beta}_{^{(-i)}}$, denote your resulting vector of 
##       parameter estimates so that $\hat{\beta}_{1^{(-i)}}$, is 
##       your estimate of the slope corresponding to $X_{1}$. Record 
##       $\hat{\beta}_{1^{(-i)}} - \hat{\beta}_{1}$.

BetaIterationRemoved = function(iterationIdx, Y, X1, X2, X3) {
  iterationRemovedY = Y[-iterationIdx]
  iterationRemovedX1 = X1[-iterationIdx]
  iterationRemovedX2 = X2[-iterationIdx]
  iterationRemovedX3 = X3[-iterationIdx]
  
  iterationRemovedBeta = lm(iterationRemovedY ~ 
                              iterationRemovedX1 
                            + iterationRemovedX2 
                            + iterationRemovedX3)
}

##    d. Repeat part (C) for $i = 2, 3, 4, \dots, 217$.

nSampleIterations = length(Y)

iterations = 1:nSampleIterations

Beta0MinusIteration = vector("numeric", nSampleIterations)
Beta1MinusIteration = vector("numeric", nSampleIterations)
Beta2MinusIteration = vector("numeric", nSampleIterations)
Beta3MinusIteration = vector("numeric", nSampleIterations)

for (iteration in iterations) {
  BetaMinusIteration = BetaIterationRemoved(iteration, Y, X1, X2, X3)
  
  Beta0MinusIteration[iteration] = BetaMinusIteration$coefficients[1]
  Beta1MinusIteration[iteration] = BetaMinusIteration$coefficients[2]
  Beta2MinusIteration[iteration] = BetaMinusIteration$coefficients[3]
  Beta3MinusIteration[iteration] = BetaMinusIteration$coefficients[4]
}

influenceIntercept = Beta0MinusIteration - Beta0
influenceX1 = Beta1MinusIteration - Beta1
influenceX2 = Beta2MinusIteration - Beta2
influenceX3 = Beta3MinusIteration - Beta3

print(influenceIntercept)
print(influenceX1)
print(influenceX2)
print(influenceX3)

##    e. Plot the influences, $\hat{\beta}_{1^{(-i)}} - 
##       \hat{\beta}_{1}$, versus $i$. That is, the x-axis will span 
##       from $i = 1$ to $217$, and the y-axis will be 
##       $\hat{\beta}_{1^{(-i)}} - \hat{\beta}_{1}$, which indicates 
##       the influence of observation $i$ on the estimated slope.

influenceTibble = 
  tibble(iterations = iterations,
         intercept = influenceIntercept,
         X1 = influenceX1,
         X2 = influenceX2,
         X3 = influenceX3)

influenceTibble %>% ggplot() +
  geom_point(aes(x = iterations, y = X1)) +
  labs(x = "Observations i = 1, ..., 217",
       y = 
         expression(
           X[1]*" Influence of Observation "*beta[1]*"(-i) - "*beta[1]))


print("Finished")
