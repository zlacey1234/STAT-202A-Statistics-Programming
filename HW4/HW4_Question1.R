## Homework 4 Question 1
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: November 11th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 4
## Due Date: November 29th, 2021
##
## Question 1
##

library(Rcpp)
library(tidyverse)

## 1. Approximation of an integral in C.
##    
##    Consider the integral from 0 to $x_{max}$ of the shifted Pareto 
##    density
##
##    f(x) = (p-1)c^{p-1}(x+c)^{-p}
##
##    where $c > 0$ and $p>1$ are parameters.
##
##    A. Let $c=3$ and $p=2$. Write a C function called 
##       $paretoint(x_{max}, c, p)$ that approximates this integral over a 
##       grid of 1 million values ranging from $x=0$ to $x=x_{max}$. Note 
##       that technically $paretoint()$ is not only going to be a function 
##       of $x_{max}$, $c$, and $p$, but will also have another input 
##       variable which will store the result. Call your C function from R 
##       to evaluate $paretoint(x_{max}, c, p)$ for various choices of 
##       $x_{max}$ between 10 and 1000 (you do not need to calculate 
##       paretoint for every integer between 10 and 1000, but choose 
##       around 10-15 numbers between 10 and 1000), and for $c=3$ and 
##       $p=2$ each time. Using R, plot $paretoint(x_{max}, 3, 2)$ vs. 
##       $x_{max}$, for $x_{max}$ ranging from 10 up to 1000. You may set 
##       up your range of the y-axis in a way that you feel is 
##       appropriate.
##

# Source the C functions
sourceCpp("paretoint.cpp")

# Number of increment points in the Pareto Density function (resolution of 
#    the Density function). This dictates the resolution of the 
#    integration since increasing this means we approximate the 
#    integration with more rectangles (finer Riemann Sum) 
nSampleIncrements = 1000000

# Number of Pareto Integral Points (number of points on our generated 
#    plots)
numParetoIntPoints = 15

# Iterations 1, 2, ... 16
iterations = 1:(numParetoIntPoints + 1)

# Sequence of the 16 different xMax values (upper-bound x-values)
xMaxSeq = vector("double", (numParetoIntPoints + 1))

# Calculate the the 16 different xMax values (upper-bound x-values)
for (iteration in iterations) {
  xMaxSeq[iteration] = 10^(2*((iteration - 1) / numParetoIntPoints) + 1)
}
print(xMaxSeq)

# Vector to store the Pareto integral values for Part (A)
paretoIntegralValuesPartA = vector("double", (numParetoIntPoints + 1))

# Solve the Pareto integral values for Part (A) for each of the 16 
#     different xMax values (upper-bound x-values)
for (iteration in iterations) {
  paretoIntegralValuesPartA[iteration] = 
    paretoint(0.0, xMaxSeq[iteration], nSampleIncrements, 3, 2, 0.0)
} 

print(paretoIntegralValuesPartA)

# Place the Pareto integral values for Part (A) into a tibble. 
paretoIntegralValuesPartATibble =
  tibble(iterations = iterations,
         xMaxSeq = xMaxSeq,
         paretoIntegralValuesPartA = paretoIntegralValuesPartA)

# Create a Point Plot for the Pareto Integral Values for Part (A).
paretoIntegralValuesPartATibble %>% ggplot() + 
  geom_point(aes(x = xMaxSeq, y = paretoIntegralValuesPartA)) +
  labs(x = expression(x["max"]),
       y = 
         expression(
           " Pareto Density Integrations paretoint("*x["max"]* 
             ", c = 3, p = 2)"))

##    B. Repeat the above, but now using c = 12 and p = 3.5.

# Vector to store the Pareto integral values for Part (B)
paretoIntegralValuesPartB = vector("double", (numParetoIntPoints + 1))

# Solve the Pareto integral values for Part (B) for each of the 16 
#     different xMax values (upper-bound x-values)
for (iteration in iterations) {
  paretoIntegralValuesPartB[iteration] = 
    paretoint(0.0, xMaxSeq[iteration], nSampleIncrements, 12, 3.5, 0.0)
} 

print(paretoIntegralValuesPartB)

# Place the Pareto integral values for Part (B) into a tibble. 
paretoIntegralValuesPartBTibble =
  tibble(iterations = iterations,
         xMaxSeq = xMaxSeq,
         paretoIntegralValuesPartB = paretoIntegralValuesPartB)

# Create a Point Plot for the Pareto Integral Values for Part (B).
paretoIntegralValuesPartBTibble %>% ggplot() + 
  geom_point(aes(x = xMaxSeq, y = paretoIntegralValuesPartB)) +
  labs(x = expression(x["max"]),
       y = 
         expression(
           " Pareto Density Integrations paretoint("*x["max"]* 
             ", c = 12, p = 3.5)"))

print("Finished")