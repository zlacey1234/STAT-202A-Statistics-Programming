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

hist(earthquakeMag, nclass = 100, prob = TRUE)

b2 = bw.nrd(earthquakeMag)

lines(density(earthquakeMag,bw=b2),col="red")
lines(density(earthquakeMag,bw=10*b2),col="blue")
lines(density(earthquakeMag,bw=.1*b2),col="brown")

print(b2)

##    c. Simulate 35 earthquake magnitudes drawn independently from 
##       your kernel density estimate $\hat{f}$ in part (b). Kernel 
##       smooth these 35 simulated magnitudes, to produce new kernel 
##       density estimates $\tilde{f}(m_{1}), \tilde{f}(m_{1}), \dots, 
##       \tilde{f}(m_{100})$, using the same kernel and bandwidth you 
##       used in part (b).

##    d. Repeat step (c) 200 times. For each value of m, find the 
##       2.5th and 97.5th, percentiles (i.e., the 5th largest and the 
##       195th largest) of your 200 simulated kernel density estimates, 
##       $\tilde{f}(m_{i})$

##    e. Extract the longitudes and latitudes of the earthquake origin 
##       locations from part (a), and make a 2-dimensional kernel 
##       smoothing of these locations. Overlay the actual locations as 
##       points on the plot. Include a legend. Show the 
##       kernel-smoothing and locations with a map of (part of) 
##       California counties in the background. This might be kind of 
##       difficult, especially making the axes of the map agree with 
##       the rest of your plot, so do not worry if it does not look 
##       perfect.


