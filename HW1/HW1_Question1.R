## Homework 1 Question 1
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: September 24th, 2021
## 
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 1
## Due Date: October 6th, 2021 (Wednesday), 2:00 PM PST
##
## Question 1
##

library(Rcpp)

## 1. Assessing estimates of the 90th percentile of 100 independent, 
##    identically-distributed (iid) uniform (0, 1) random variables. 
##
##    The R function quantile() implements a somewhat complex 
##    interpolation method in order to estimate a particular quantile, 
##    such as the 90th percentile. We will compare the estimate in 
##    quantile() with simpler estimates. 

## a. Write a function that takes as input a vector of length 100 and 
##    outputs the 90th of the 100 values sorted from smallest to largest. 
##    Note that the input vector may not be sorted.

## Function that sorts the sample vector and returns the nth element of 
## the sorted vector. 
computeNSample = function(sampleVector, n) {
  sortedSampleVector = sort(sampleVector)
  
  sortedSampleVector[n]
}

## Function which returns the 90th element of the sorted vector.
compute90th = function(sampleVector) {
  computeNSample(sampleVector, 90)
}

## b. Write a function to find the 91st of the sorted vector of 100 
##    values. 

## Function which returns the 91st element of the sorted vector.
compute91st = function(sampleVector) {
  computeNSample(sampleVector, 91)
}

## c. Write a function that outputs the average of the 90th and 91st of 
##    the sorted vector of 100 values.

## Function which returns the average of the 90th and 91st element of the 
## sorted vector.
computeAvg90th91st = function(sample90thCurrentCalculation, 
                              sample91stCurrentCalculation) {
  (sample90thCurrentCalculation + sample91stCurrentCalculation) / 2
}

## d. For each of your function in part a - c, as well as the function 
##    quantile(x, 0.9), do the following:
##
##    (i).   Generate 100 independent, identically-distributed (iid) 
##           uniform (0, 1) random variables, and calculate your estimates 
##           of the 90th percentile. 
##
##    (ii).  Repeat step (i) 100,000 times.
##
##    (iii). Plot the sample mean of the first 'm' of your estimates, as a 
##           function of m.
nIterations = 100000

mIterations = 100000

computedSampleData  = matrix(nrow = 4, ncol = nIterations)

iterations = 1:nIterations

computeSampleN = function(iterationsIdx) {
  sampleIidData = runif(100)
  
  c1 = compute90th(sampleIidData)
  c2 = compute91st(sampleIidData)
  c3 = computeAvg90th91st(c1, c2)
  c4 = quantile(sampleIidData, 0.9)
  
  return(c(c1, c2, c3, c4))
}

# Start the clock!
ptm = proc.time()

computedSampleData = sapply(iterations, computeSampleN)

# Stop the clock
proc.time() - ptm

sampleMean90thN = vector("numeric", mIterations)
sampleMean91stN = vector("numeric", mIterations)
sampleMean90th91stN = vector("numeric", mIterations)
sampleMean90thQuantileN = vector("numeric", mIterations)

sourceCpp("sample_mean_c.cpp")

# Start the clock!
ptm = proc.time()

sampleMean90thN = sample_mean_c(
  as.double(computedSampleData[1, ]),
  mIterations)

sampleMean91stN = sample_mean_c(
  as.double(computedSampleData[2, ]),
  mIterations)

sampleMean90th91stN = sample_mean_c(
  as.double(computedSampleData[3, ]),
  mIterations)

sampleMean90thQuantileN = sample_mean_c(
  as.double(computedSampleData[4, ]),
  mIterations)
# Stop the clock
proc.time() - ptm



plot_sample_mean = function(m_iter) {
  plot(1:m_iter, sampleMean90thN, pch=".", col="red", 
       xlab="First m iterations", ylab="Sample Mean")
  
  points(1:m_iter, sampleMean91stN, pch=".", col="blue")
  points(1:m_iter, sampleMean90th91stN, pch=".", col="green")
  points(1:m_iter, sampleMean90thQuantileN, pch=".")
  
  legend(50000, 0.915, 
         legend = c("Compute 90th", "Compute 91st", 
                    "Average 90th and 91st", "Compute Quantile"),
         cex = 0.8,
         col = c("red", "blue", "green", "black"),
         pch = c(".",".",".","."))
}

plot_sample_mean(mIterations)


## e. Report the ultimate sample mean of your 100,000 estimates, for each of 
##    the four estimates. In 1-2 sentences, indicate which of the 4 estimates 
##    appears to be the best, and why.

print(c("Computed 90th of Sorted:",
        sampleMean90thN[nIterations]))
print(c("Computed 91st of Sorted:",
        sampleMean91stN[nIterations]))
print(c("Computed Average 90th and 91st:",
        sampleMean90th91stN[nIterations]))
print(c("Computed 90th from Quantile:",
        sampleMean90thQuantileN[nIterations]))

print("Finished")
