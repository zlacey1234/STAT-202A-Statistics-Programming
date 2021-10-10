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
##    interpolation method in order to estimate a particular quantile, such as the 90th 
##    percentile. We will compare the estimate in quantile() with simpler 
##    estimates. 

## a. Write a function that takes as input a vector of length 100 and outputs
##    the 90th of the 100 values sorted from smallest to largest. Note that the 
##    input vector may not be sorted.

## Function that sorts the sample vector and returns the nth element of the 
## sorted vector. 
compute_n_sample <- function(sample_vector, n) {
  sorted_sample_vector <- sort(sample_vector)
  
  sorted_sample_vector[n]
}

## Function which returns the 90th element of the sorted vector.
compute_90th <- function(sample_vector) {
  compute_n_sample(sample_vector, 90)
}


## b. Write a function to find the 91st of the sorted vector of 100 values. 

## Function which returns the 91st element of the sorted vector.
compute_91st <- function(sample_vector) {
  compute_n_sample(sample_vector, 91)
}


## c. Write a function that outputs the average of the 90th and 91st of the 
##    sorted vector of 100 values.

## Function which returns the average of the 90th and 91st element of the 
## sorted vector.
compute_avg_90th_91st <- function(sample_90th_current_calculation, 
                                  sample_91st_current_calculation) {
  (sample_90th_current_calculation + sample_91st_current_calculation) / 2
}


## d. For each of your function in part a - c, as well as the function 
##    quantile(x, 0.9), do the following:
##
##    (i).   Generate 100 independent, identically-distributed (iid) uniform 
##           (0, 1) random variables, and calculate your estimates of the 90th
##           percentile. 
##
##    (ii).  Repeat step (i) 100,000 times.
##
##    (iii). Plot the sample mean of the first 'm' of your estimates, as a 
##           function of m.

n_iterations <- 100000

m_iterations <- 100000

computed_sample_data  <- matrix(nrow = 4, ncol = n_iterations)

iterations <- 1:n_iterations

compute_sample_n <- function(iterations_idx) {
  sample_iid_data <- runif(100)
  
  c1 <- compute_90th(sample_iid_data)
  c2 <- compute_91st(sample_iid_data)
  c3 <- compute_avg_90th_91st(c1, c2)
  c4 <- quantile(sample_iid_data, 0.9)
  
  return(c(c1, c2, c3, c4))
}

# Start the clock!
ptm <- proc.time()

computed_sample_data <- sapply(iterations, compute_sample_n)

# Stop the clock
proc.time() - ptm


sample_mean_90th_n <- vector("numeric", m_iterations)
sample_mean_91st_n <- vector("numeric", m_iterations)
sample_mean_90th_91st_n <- vector("numeric", m_iterations)
sample_mean_90th_quantile_n <- vector("numeric", m_iterations)

sourceCpp("sample_mean_c.cpp")


# Start the clock!
ptm <- proc.time()

sample_mean_90th_n = sample_mean_c(
  as.double(computed_sample_data[1, ]),
  m_iterations)

sample_mean_91st_n = sample_mean_c(
  as.double(computed_sample_data[2, ]),
  m_iterations)

sample_mean_90th_91st_n = sample_mean_c(
  as.double(computed_sample_data[3, ]),
  m_iterations)

sample_mean_90th_quantile_n = sample_mean_c(
  as.double(computed_sample_data[4, ]),
  m_iterations)
# Stop the clock
proc.time() - ptm



plot_sample_mean <- function(m_iter) {
  plot(1:m_iter, sample_mean_91st_n, pch=".", col="red", 
       xlab="First m iterations", ylab="Sample Mean")
  
  points(1:m_iter, sample_mean_90th_n, pch=".", col="blue")
  points(1:m_iter, sample_mean_90th_91st_n, pch=".", col="green")
  points(1:m_iter, sample_mean_90th_quantile_n, pch=".")
}

plot_sample_mean(m_iterations)


## e. Report the ultimate sample mean of your 100,000 estimates, for each of 
##    the four estimates. In 1-2 sentences, indicate which of the 4 estimates 
##    appears to be the best, and why.

print(c("Computed 90th of Sorted:",
        sample_mean(computed_sample_data[1, ],
                    n_iterations)))
print(c("Computed 91st of Sorted:",
        sample_mean(computed_sample_data[2, ],
                    n_iterations)))
print(c("Computed Average 90th and 91st:",
        sample_mean(computed_sample_data[3, ],
                    n_iterations)))
print(c("Computed 90th from Quantile:",
        sample_mean(computed_sample_data[4, ],
                    n_iterations)))

print("Finished")

