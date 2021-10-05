## Homework 1 Question 2
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: September 24th, 2021
## 
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 1
## Due Date: October 6th, 2021 (Wednesday), 2:00 PM PST
##
## Question 2
##

## 2. Functions to approximate pi.

## a. Write a function called pi2(n) that approximates pi as a function of 'n', 
##    using the approximation:
##
##    pi2(n) = lim sqrt(6 * summation (k^-2))
##
##    Evaluate pi2(10^j) for j = 0, 1, 2, ..., 6.

pi2 <- function(n) {
  summation <- rep(1, n)
  
  for (k in 2:n) {
    summation[k] <- 1 / k^2
  }
  
  cumulative_summation <- (6 * cumsum(summation))
  pi2_estimates <- sqrt(cumulative_summation)
  
  pi2_estimates[n]
}


# Start the clock!
ptm <- proc.time()

pi2_0 <- pi2(10^0)
pi2_1 <- pi2(10^1)
pi2_2 <- pi2(10^2)
pi2_3 <- pi2(10^3)
pi2_4 <- pi2(10^4)
pi2_5 <- pi2(10^5)
pi2_6 <- pi2(10^6)

# Stop the clock
proc.time() - ptm


## b. Write a function pi3(n) that approximates pi as a function of 'n', by 
##    simulating random points in the square with vertices (-1, 1), (-1, 1), 
##    (1, 1), and (1, -1), seeing what fraction of them are in the unit circle 
##    [the circle with radius 1 centered at the origin], and then convert the 
##    fraction into an estimate of pi. Evaluate pi3(10^j) for 
##    j = 0, 1, 2, ..., 6. For j = 6, plot your simulated points, using 
##    different plotting symbols for simulated points inside and outside the 
##    unit circle. There is no need for you to plot the unit circle also. 

pi3 <- function(n, plot_bool) {
  x <- runif(n) * 2 - 1
  y <- runif(n) * 2 - 1
  
  is_in_unit_circle <- (x^2 + y^2 <= 1)
  if (plot_bool) {
    plot(c(-1.1, 1.1), c(-1.1, 1.1), type = "n", 
         xlab = "X-Component", ylab = "Y-Component")
    
    points(x[which(is_in_unit_circle)], 
           y[which(is_in_unit_circle)], 
           cex = 0.8,
           pch=".", col="green")
    points(x[which(!is_in_unit_circle)], 
           y[which(!is_in_unit_circle)], 
           cex = 0.8,
           pch=".", col="red")
  }
  
  
  pi_estimate <- 4 * sum(is_in_unit_circle) / n
}

plot_pi3 <- function(n) {
  plot(x[is_in_unit], y)
}

pi3_0 <- pi3(10^0, FALSE)
pi3_1 <- pi3(10^1, FALSE)
pi3_2 <- pi3(10^2, FALSE)
pi3_3 <- pi3(10^3, FALSE)
pi3_4 <- pi3(10^4, FALSE)
pi3_5 <- pi3(10^5, FALSE)
pi3_6 <- pi3(10^6, TRUE)