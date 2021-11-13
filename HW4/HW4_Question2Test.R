## Homework 4 Question 2
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: November 11th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 4
## Due Date: November 25th, 2021
##
## Question 2
##

library(Rcpp)
library(tidyverse)

## 2. 
##


##   A.
##


##   B. 
##

# Loading the Petroleum Data
petroleumData = read.table("Petroleum.txt")

print(petroleumData)

# Extracting the Petroleum Taxes Data (Cents Per Gallon) [Variable X]
petroleumTaxes = as.double(as.vector(petroleumData[, 2]))

print(petroleumTaxes)

# Extracting the Consumption of Petroleum Data (Millions of Gallons) 
# [Variable Y]
petroleumConsumption = as.double(as.vector(petroleumData[, 6]))

print(petroleumConsumption)

##   C.
##

# Bandwidth of the Petroleum Taxes Data (Cents Per Gallon) [Variable X] 
# using Scott's Rule of Thumb
b2 = bw.nrd(petroleumTaxes)

# Range of the Petroleum Taxes Data (Cents Per Gallon) [Variable X] 
petroleumTaxesRange = range(petroleumTaxes)

# Vector 'm': vector of equally spaced Petroleum Taxes spanning the 
# range of the Petroleum Taxes Data (Cents Per Gallon) [Variable X] 
# (vector of length 100).
m = seq(petroleumTaxesRange[1], petroleumTaxesRange[2], length = 100)

# Sourcing the C function
#sourceCpp("gaussianKernelRegression.cpp")

# Number of elements in vector m
numVectorM = length(m)

# Number of observations in the data (petroleum taxes X and petroleum 
# consumption Y data)
numPetroleum = length(petroleumTaxes)

# Kernel regression estimates result vector
kernelRegressionEstimate = vector("double", numVectorM)

## Estimation of the Gaussian kernel regression 
#kernelRegressionEstimate = 
#  gaussianKernelRegression(
#    numPetroleum, petroleumTaxes, petroleumConsumption,
#    numVectorM, m, kernelRegressionEstimate,
#    b2)

mNW = function(m, X, Y, bw, K = dnorm) {
  
  Kx = sapply(X, function(Xi) K((m - Xi) / bw) / bw)
  
  print(Kx)
  
  W = Kx / rowSums(Kx)
  
  print(W)
  
  drop(W %*% Y)
}

kernelRegressionEstimate = mNW(m, petroleumTaxes, petroleumConsumption, 
                               b2)


kernelRegressionEstimateTibble = tibble(m = m,
                                        kernelRegressionEstimate =
                                          kernelRegressionEstimate)

kernelRegressionEstimateTibble %>% ggplot() + 
  geom_line(aes(x = m, y = kernelRegressionEstimate)) +
  labs(x = expression(m[i]*", i = 1, ..., 100"),
       y = "Kernel Regression Estimate")