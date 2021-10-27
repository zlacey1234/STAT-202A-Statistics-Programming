## Homework 2 Question 1
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: October 20th, 2021
##
## Course: STAT 202A - Statistics Programming
## Assignment: Homework 2
## Due Date: October 26th, 2021 (Tuesday), 11:59 PM PST
##
## Question 1
##

library(maps)
library(RgoogleMaps)
library(splancs)
library(tidyverse)

## 1. Kernel density estimates with simulation based 95% confidence 
##    bands, applied to earthquake magnitudes and locations.
##
##    a. Gather data on earthquakes of magnitude at least 4.0 in the 
##       longitude range -118.0 to -117.0 and latitude range 34.0 to 
##       35.0, from Jan 1, 1965 to Oct 11, 2021, from 
##
##       https://service.scedc.caltech.edu/eq-catalogs/date_mag_loc.php.
##     
##       Input the data into R. (Use minimum magnitude = 4.0, maximum 
##       magnitude = 9.0, min depth = 0, max depth = 100km, event 
##       type = earthquake, geographic type = local). You will have to 
##       input "01" for January and "01" for the day as well. You should 
##       have 35 events.

earthquakeData = read.table("SearchResults.txt")

print(earthquakeData)

earthquakeMag = as.numeric(as.vector(earthquakeData[, 5]))

print(earthquakeMag)

##    b. Take the vector of the earthquake magnitudes, and use it to 
##       make a kernel density estimate of the earthquake magnitudes, 
##       using a Gaussian kernel with bandwidth selected using the 
##       rule of thumb suggested by Scott (1992). Let $m_{1}, m_{2}, 
##       \dots, m_{100}$ = a vector of 100 equally spaced magnitudes 
##       spanning the observed range of magnitudes in your dataset, 
##       and plot your kernel density estimate $\hat{f}(m_{1}), 
##       \hat{f}(m_{1}), \dots, \hat{f}(m_{100})$. Use these same 
##       values $m_{1}, m_{2}, \dots, m_{100}$ for parts (c) and (d) 
##       below.

# Kernel Density Estimate Function
density2 = function(x1, xgrid, bw2) {
## x1 = data
## xgrid = vector of values where we compute the kernel estimate.
## bw2 = bandwidth
  
  n = length(xgrid)
  y = rep(0, n)
  
  for(i in 1:n) {
    y[i] = sum(dnorm(x1 - xgrid[i], sd = bw2)) / length(x1)
  }
  y
}

# Bandwidth of the Earthquake Magnitude data using Scott's Rule of Thumb
b2 = bw.nrd(earthquakeMag)

# Range of the Earthquake Magnitude data 
earthquakeMagRange = range(earthquakeMag)

# Vector 'm': vector of equally spaced earthquake magnitudes spanning the 
# range of the Earthquake Magnitude data (vector of length 100).
m = seq(earthquakeMagRange[1], earthquakeMagRange[2], length = 100)

# Kernel Density Estimate resulting from vector 'm'.
kernelDensityEstimate = density2(earthquakeMag, m, b2)

# Plot the Kernel Density Estimate
plot(m, kernelDensityEstimate, type = "l", 
     xlab = "m_i, i = 1, ..., 100", 
     ylab = "Kernel Density Estimate")

##    c. Simulate 35 earthquake magnitudes drawn independently from 
##       your kernel density estimate $\hat{f}$ in part (b). Kernel 
##       smooth these 35 simulated magnitudes, to produce new kernel 
##       density estimates $\tilde{f}(m_{1}), \tilde{f}(m_{1}), \dots, 
##       \tilde{f}(m_{100})$, using the same kernel and bandwidth you 
##       used in part (b).

simulateEarthquakeMag = function(x1, m, bw2) {
  ## x1 = data
  ## m = vector of equally spaced earthquake magnitudes spanning the 
  ##     range of the Earthquake Magnitude data (vector of length 100).
  ## bw2 = bandwidth
  
  # c = 1.25 : Density is always less than 1.25
  # d = 1.80 : Span of the Earthquake Magnitudes (5.80 - 4.00)
  # b = cd = 2.25 : (1.25)(1.80) = 2.25
  b = 2.25
  
  # g(x) = uniform on (4.00, 5.80)
  g = 1 / (1.80)
  
  n = 35
  x = c()
  i = 0
  
  while(i < n) {
    # Simulate the Uniform g(x) on (4.00, 5.80)
    x0 = runif(1)*1.80 + 4.00
    
    fx0 = density2(earthquakeMag, x0, b2)
    
    # If the f(x0) / (1.25) is greater than uniform (0, 1) then we keep 
    # the x0 value
    if(runif(1) < fx0 / (b*g)) {
      # increment
      i = i + 1
      
      # Store current x0
      x[i] = x0
      
      if(i/100 == floor(i/100)) cat(i, " ")
    }
  }
  newKernelDensityEstimate = density2(x, m, b2) 
}

##    d. Repeat step (c) 200 times. For each value of m, find the 
##       2.5th and 97.5th, percentiles (i.e., the 5th largest and the 
##       195th largest) of your 200 simulated kernel density estimates, 
##       $\tilde{f}(m_{i})$

# Number of Simulations
numSimulations = 200

# Computed Simulated Kernel Density Estimates
computedSimulatedKernelDensityEstimates =
  matrix(nrow = 100, ncol = numSimulations)

# Matrix to store the 95% confidence band values
confidenceBandValues = matrix(nrow = 100, ncol = 2)

simulationIterations = 1:numSimulations

# Computed Simulated Kernel Density Estimates (200 Simulations)
for (iteration in simulationIterations) {
  computedSimulatedKernelDensityEstimates[, iteration] = 
    simulateEarthquakeMag(earthquakeMag, m, b2)
}

# Find the 95% confidence band value for each m_i, i = 1, ..., 100.
for (i in 1:100) {
  mDataFori =  computedSimulatedKernelDensityEstimates[i, ]
  
  sortedmDataFori = sort(mDataFori, decreasing = TRUE)
  
  confidenceBandValues[i, 1] = sortedmDataFori[5]
  confidenceBandValues[i, 2] = sortedmDataFori[195]
}

# Made a tibble for the simulated results
simulatedEarthquakeDataTibble = tibble(i = 1:100, 
                                       mi = m,
                                       f_mi = kernelDensityEstimate, 
                                       confidence5th = 
                                         confidenceBandValues[, 1],
                                       confidence195th = 
                                         confidenceBandValues[, 2])

simulatedEarthquakeDataTibble %>% ggplot(aes(x = mi, y = f_mi)) +
  geom_line() + geom_ribbon(aes(ymin = confidence195th, 
                                ymax = confidence5th), alpha = 0.3) +
  labs(x = expression(m[i]*", i = 1, 2, ..., 100"), 
       y = expression("Kernel Density Estimate f(m)"))

##    e. Extract the longitudes and latitudes of the earthquake origin 
##       locations from part (a), and make a 2-dimensional kernel 
##       smoothing of these locations. Overlay the actual locations as 
##       points on the plot. Include a legend. Show the 
##       kernel-smoothing and locations with a map of (part of) 
##       California counties in the background. This might be kind of 
##       difficult, especially making the axes of the map agree with 
##       the rest of your plot, so do not worry if it does not look 
##       perfect.

# Longitude and Latitude values
earthquakeLat = as.numeric(as.vector(earthquakeData[, 7]))
earthquakeLong = as.numeric(as.vector(earthquakeData[, 8]))

bandwidth = sqrt(bw.nrd(earthquakeLong)^2 + bw.nrd(earthquakeLat)^2)


earthquakeLocations= as.points(earthquakeLong, earthquakeLat)

kernelBoundary = matrix(c(-118.5, 33, 
                          -116, 33, 
                          -116, 35, 
                          -118.5, 35, 
                          -118.5, 33), 
                        ncol = 2, byrow = T)

z = kernel2d(earthquakeLocations, kernelBoundary, bandwidth, 
             nx = 100, ny = 100)

attributes(z)
par(mfrow=c(1,2))

# Default grey scale image
image(z,col=gray((64:20)/64), 
      xlab="Longitude", ylab="Latitude")

# Place the Earthquake Location Points on the Plot
points(earthquakeLocations)

# Add the California (Los Angeles County Region) on the Plot 
map('county', 'California', add=T)

# Scaling of the density (scaling of grey scale shading)
x4 = seq(min(z$z),max(z$z),length=100)

# Legend 
plot(c(0,10),c(.8*min(x4),1.2*max(x4)),type="n",axes=F,xlab="",ylab="")
image(c(-1:1),x4,matrix(rep(x4,2),ncol=100,byrow=T),add=T,col=gray((64:20)/64))
text(2,min(x4),as.character(signif(min(x4),2)),cex=1)
text(2,(max(x4)+min(x4))/2,as.character(signif((max(x4)+min(x4))/2,2)),cex=1)
text(2,max(x4),as.character(signif(max(x4),2)),cex=1)
mtext(s=3,l=-3,at=1,"Density (Earthquakes/Geographic area)")

print("Finished")