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
## Question 2
##

library(Rcpp)
library(tidyverse)

## 2. Kernel density estimation in C and plotted in R.
##
##    Write a C function to compute a Gaussian kernel density estimate for 
##    uni-variate data. The inputs to the function should be two integers, $m$ 
##    and $n$, a vector $g$ of $m$ gridpoints at which to calculate the 
##    estimates, a vector $x$ consisting of the $n$ observed data points, and 
##    a vector $y$ of length $m$ which will contain the resulting density 
##    estimates.
##
##    Gather data on all earthquakes of magnitude at least 3.0 in the longitude 
##    range -122.0 to -118.0 and latitude range 34.0 to 38.0, from Jan 1, 1960 
##    to Oct 1, 2021, from 
##
##    https://service.scedc.caltech.edu/eq-catalogs/date\_mag\_loc.php. 
##
##    Input the data into R. (Use minimum magnitude = 3.0, maximum magnitude 
##    = 9.0, min depth = -5km, max depth = 100km, event type = earthquake, 
##    geographic type = local). Take this vector of earthquake magnitudes, 
##    and use your C function to make a kernel density estimate of the 
##    earthquake magnitudes, using a Gaussian kernel with bandwidth selected 
##    using the rule of thumb suggested by Scott (1992). You may calculate 
##    this bandwidth in R. Let $m_{1}, m_{2}, \dots, m_{100}$ = a vector of 
##    100 equally spaced magnitudes spanning the observed range of magnitudes 
##    in your dataset, and plot your kernel density estimate $\hat{f}(m_{1}), 
##    \hat{f}(m_{1}), \dots, \hat{f}(m_{100})$.

# Loading the Earthquake Data
earthquakeData = read.table("SearchResults.txt")

print(earthquakeData)

# Extracting the Earthquake Magnitude Data
earthquakeMag = as.numeric(as.vector(earthquakeData[, 5]))

print(earthquakeMag)

# Bandwidth of the Earthquake Magnitude data using Scott's Rule of Thumb
b2 = bw.nrd(earthquakeMag)

# Range of the Earthquake Magnitude data 
earthquakeMagRange = range(earthquakeMag)

# Vector 'm': vector of equally spaced earthquake magnitudes spanning the 
# range of the Earthquake Magnitude data (vector of length 100).
m = seq(earthquakeMagRange[1], earthquakeMagRange[2], length = 100)

# Sourcing the C function
sourceCpp("gaussianKernelDensity.cpp")

# Number of elements in vector m
numVectorM = length(m)

# Number of observations in the data (earthquake magnitude data)
numEarthquakeMag = length(earthquakeMag)

# Kernel density estimates results vector 
kernelDensityEstimate = vector("numeric", numVectorM)

# Estimation of the Gaussian kernel density 
kernelDensityEstimate = 
  gaussianKernelDensity(numVectorM, numEarthquakeMag, 
                        m, earthquakeMag, kernelDensityEstimate, b2)

# Place the resulting Gaussian kernel density estimates into a Tibble.
kernelDensityEstimateTibble = tibble(m = m, 
                                     kernelDensityEstimate = 
                                       kernelDensityEstimate)

# Plot the results
kernelDensityEstimateTibble %>% ggplot() + 
  geom_line(aes(x = m, y = kernelDensityEstimate)) + 
  labs(x = expression(m[i]*", i = 1, ..., 100"),
       y = "Kernel Density Estimate")

print("Finished")