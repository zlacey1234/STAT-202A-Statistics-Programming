## Exercises 2.16

## 1. We made a plot of total murders versus population and noted a strong 
##    relationship. Not surprisingly, states with larger populations had more 
##    more murders.
##
##    library(dslabs)
##    data(murders)
##    population_in_millions <- murders$population/10^6
##    total_gun_murders <- murders$total
##    plot(population_in_millions, total_gun_murders)
##
##    Keep in mind that many states have populations below 5 million and are 
##    bunched up. We may gain further insights from making this plot in the log 
##    scale. Transform the variables using the log10() transofmation and then 
##    plot them. 

library(dslabs)
data(murders)
population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total

population_in_millions_log10 <- log10(population_in_millions)
total_gun_murders_log10 <- log10(total_gun_murders)

plot(population_in_millions_log10, total_gun_murders_log10)


## 2. Create a histogram of the state populations.

state_populations <- with(murders, population_in_millions)
hist(state_populations)


## 3. Generate box-plots of the state populations by region

murders$pop <- with(murders, population_in_millions)
boxplot(pop~region, data = murders)