## Homework 3 Question 1
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: October 27th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 3
## Due Date: November 11th, 2021
##
## Question 1
##

library(Rcpp)
library(tidyverse)

## 1. Approximation of an infinite series in C. 
## 
##    It is well known that 
##   
##    1 - 1/2 + 1/3 - 1/4 + 1/5 - 1/6 +/- ... = ln(2). 
##
##    Write a C function called alt2(n) that computes the first 'n' terms
##    in this series, as a function of 'n'. Call your C function from R 
##    to evaluate alt2(n) for various 'n'. Using R, plot alt2(n) vs. 'n',
##    for 'n' ranging from some small number up to 1 million. You may set 
##    up your range of the y-axis in a way that you feel is appropriate. 
##    You do not need to show alt2(n) for all values of n and should not 
##    plot alt2 for very small values of 'n' if they are off the plot.

# Source the C function
sourceCpp("alt2.cpp")

# Number of Iterations in the Series
nIterations = 1000000

# Initialize a vector to store the resulting alt2 estimates in. 
alt2Estimates = vector("numeric", nIterations)

# Determine the first 1,000,000 alt2 estimates of ln(n)
alt2Estimates = alt2(1000000)

# Sequence from [(1,000), (1,000,000)] with a 1,000 increment spacing.
# This is used to summarize the results in a less computationally 
# expensive way (as opposed to including all 1,000,000 values)
nSeq = seq(1000, nIterations, 1000)

# Summarized alt2 estimate results
alt2EstimatesSeq = alt2Estimates[nSeq]

print(nSeq)
print(alt2EstimatesSeq)

# Place the summarized alt2 estimate results into a Tibble
alt2EstimatesTibble = tibble(n = nSeq, 
                             alt2Estimates = alt2EstimatesSeq)

# Plot the results
alt2EstimatesTibble %>% ggplot() +
  geom_point(aes(x = n, y = alt2Estimates)) + 
  labs(x = "Sequence Number n",
       y = "alt2() Estimates")

print("Finished")