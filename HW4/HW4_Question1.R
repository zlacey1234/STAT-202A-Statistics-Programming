## Homework 4 Question 1
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: November 11th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 4
## Due Date: November 25th, 2021
##
## Question 1
##

library(Rcpp)
library(tidyverse)

## 1. Approximation of an integral in C.
##    
##    

# Source the C functions
sourceCpp("paretoint.cpp")

# Number of increment points in the Pareto Density function (resolution of 
#    the Density function). This dictates the resolution of the 
#    integration since increasing this means we approximate the 
#    integration with more rectangles (finer Riemann Sum) 
nSampleIncrements = 1000000

numParetoIntPoints = 15

iterations = 1:(numParetoIntPoints + 1)

xMaxSeq = vector("double", (numParetoIntPoints + 1))

for (iteration in iterations) {
  xMaxSeq[iteration] = 10^(2*((iteration - 1) / numParetoIntPoints) + 1)
}
print(xMaxSeq)

paretoIntegralValuesPartA = vector("double", (numParetoIntPoints + 1))

for (iteration in iterations) {
  paretoIntegralValuesPartA[iteration] = 
    paretoint(0.0, xMaxSeq[iteration], nSampleIncrements, 3, 2, 0.0)
} 

print(paretoIntegralValuesPartA)

paretoIntegralValuesPartATibble =
  tibble(iterations = iterations,
         xMaxSeq = xMaxSeq,
         paretoIntegralValuesPartA = paretoIntegralValuesPartA)

paretoIntegralValuesPartATibble %>% ggplot() + 
  geom_point(aes(x = xMaxSeq, y = paretoIntegralValuesPartA)) +
  labs(x = expression(x["max"]),
       y = 
         expression(
           " Pareto Density Integrations paretoint("*x["max"]* 
             ", c = 3, p = 2)"))

##    B. Repeat the above, but now using c = 12 and p = 3.5.

paretoIntegralValuesPartB = vector("double", (numParetoIntPoints + 1))

for (iteration in iterations) {
  paretoIntegralValuesPartB[iteration] = 
    paretoint(0.0, xMaxSeq[iteration], nSampleIncrements, 12, 3.5, 0.0)
} 

print(paretoIntegralValuesPartB)

paretoIntegralValuesPartBTibble =
  tibble(iterations = iterations,
         xMaxSeq = xMaxSeq,
         paretoIntegralValuesPartB = paretoIntegralValuesPartB)

paretoIntegralValuesPartBTibble %>% ggplot() + 
  geom_point(aes(x = xMaxSeq, y = paretoIntegralValuesPartB)) +
  labs(x = expression(x["max"]),
       y = 
         expression(
           " Pareto Density Integrations paretoint("*x["max"]* 
             ", c = 12, p = 3.5)"))