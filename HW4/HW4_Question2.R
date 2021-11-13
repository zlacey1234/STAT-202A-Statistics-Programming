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

# Sourcing the C function
sourceCpp("gaussianKernelRegression.cpp")

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

# Number of elements in vector m
numVectorM = length(m)

# Number of observations in the data (petroleum taxes X and petroleum 
# consumption Y data)
numPetroleum = length(petroleumTaxes)

# Kernel regression estimates result vector
kernelRegressionEstimate = vector("double", numVectorM)

# Estimation of the Gaussian kernel regression 
kernelRegressionEstimate = 
  gaussianKernelRegression(
    numPetroleum, petroleumTaxes, petroleumConsumption,
    numVectorM, m, kernelRegressionEstimate,
    b2)

kernelRegressionEstimateTibble = tibble(m = m,
                                        kernelRegressionEstimate =
                                          kernelRegressionEstimate)

kernelRegressionEstimateTibble %>% ggplot() + 
  geom_line(aes(x = m, y = kernelRegressionEstimate)) +
  labs(x = expression(m[i]*", i = 1, ..., 100"),
       y = "Kernel Regression Estimate")


##   D.
##

kernelRegressionEstimateSample = function(n, X, Y, m, g2, res2, bw) {
  numSamplePair = 100
  i = 0
  
  XSample = c()
  YSample = c()
  
  samplePointIdx = sample(1:n, numSamplePair, rep=TRUE)
  
  print(samplePointIdx)
  
  while (i < numSamplePair) {
    # increment
    i = i + 1
    
    XSample[i] = X[samplePointIdx[i]]
    YSample[i] = Y[samplePointIdx[i]]
  }
  
  newKernelRegressionEstimate = gaussianKernelRegression(
    numSamplePair, XSample, YSample, 
    m, g2, res2, 
    bw)
}

##   E. 
##

# Number of times we sample
numTimesSample = 200

# Computed Sampled Kernel Regression Estimates
computedSampledKernelRegressionEstimates =
  matrix(nrow = numVectorM, ncol = numTimesSample)

# Matrix to store the 95% confidence band values
confidenceBandValues = matrix(nrow = numVectorM, ncol = 2)

sampleIterations = 1:numTimesSample


for (iteration in sampleIterations) {
  kernelRegressionEstimateFromSample = vector("double", numVectorM)
  
  computedSampledKernelRegressionEstimates[, iteration] = 
    kernelRegressionEstimateSample(
      numPetroleum, petroleumTaxes, petroleumConsumption,
      numVectorM, m, kernelRegressionEstimateFromSample,
      b2)
}

# Find the 95% confidence band value for each m_i, i = 1, ..., 100.
for (i in 1:100) {
  mDataFori = computedSampledKernelRegressionEstimates[i, ]
  
  sortedmDataFori = sort(mDataFori, decreasing = TRUE)
  
  confidenceBandValues[i, 1] = sortedmDataFori[5]
  confidenceBandValues[i, 2] = sortedmDataFori[195]
}


sampledPetroleumDataTibble = tibble(i = 1:100,
                                    mi = m,
                                    f_mi = kernelRegressionEstimate, 
                                    confidence5th = 
                                      confidenceBandValues[, 1],
                                    confidence195th = 
                                      confidenceBandValues[, 2])

sampledPetroleumDataTibble %>% ggplot(aes(x = mi, y = f_mi)) + 
  geom_line() + geom_ribbon(aes(ymin = confidence195th, 
                                ymax = confidence5th), alpha = 0.1) +
  geom_line(aes(x = mi, y = confidence195th), linetype=2) + 
  geom_line(aes(x = mi, y = confidence5th), linetype=2)
  