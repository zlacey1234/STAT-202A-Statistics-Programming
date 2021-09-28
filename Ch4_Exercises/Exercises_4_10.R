## Exercises 4.10

## For these exercises, we will be using the data from the survey collected by
## the United States National Center of Health Statistics (NCHS). This center 
## has conducted a series of health and nutrition survets since the 1960's.
## Starting in 1999, about 5,000 individuals of all ages have been interviewed 
## every year and they complete the health examination component of the survey. 
## Part of the data is made available via the NHANES package. Once you install 
## the NHANES package, you can load the data like this:
##
## library(NHANES)
## data(NHANES)
##
## The NHANES data has many missing values. The mean() and sd() functions in R 
## will return 'NA' if any of the entries of the input vector is an 'NA'. Here 
## is an example:
##
## library(dslabs)
## data(na_example)
## mean(na_example)
## > [1] NA
## sd(na_example)
## > [1] NA
##
## To ignore the NAs, we can use the 'na.rm' argument: 
##
## mean(na_example, na.rm = TRUE)
## > [1] 2.3
## sd(na_example, na.rm = TRUE)
## > [1] 1.22
##
## Let's ow explore the NHANES data.

## 1. We will provide some basic facts about blood pressure. First let’s select 
##    a group to set the standard. We will use 20-to-29-year-old females.