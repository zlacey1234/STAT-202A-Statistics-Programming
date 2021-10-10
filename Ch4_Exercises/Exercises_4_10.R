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

library(dplyr)
library(dslabs)
library(NHANES)
data(NHANES)

## 1. We will provide some basic facts about blood pressure. First let’s select 
##    a group to set the standard. We will use 20-to-29-year-old females. 
##    'AgeDecade' is a categorical variable with these ages. Note that the 
##    category is coded like " 20-29", with a space in front! What is the 
##    average and standard deviation of systolic blood pressure as saved in the
##    'BPSysAve' variable? Save it to a variable called 'ref'.
##
##    Hint: Use filter() and summarize() and use the na.rm = TRUE argument when 
##    computing the average and standard deviation. You can also filter the NA
##    values using filter().
NHANES

ref <- NHANES %>%
  filter(Gender == "female" & AgeDecade == " 20-29") %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            sd = sd(BPSysAve, na.rm = TRUE))

print(ref)


## 2. Using a pipe, assign the average to a numeric variable 'ref_avg'. Hint: 
##    Use the code similar to above and the pull().

ref_avg <- NHANES %>%
  filter(Gender == "female" & AgeDecade == " 20-29") %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            sd = sd(BPSysAve, na.rm = TRUE)) %>%
  pull(average)

print(ref_avg)


## 3. Now report the min and max values for the same group.

ref_min_max <- NHANES %>%
  filter(Gender == "female" & AgeDecade == " 20-29") %>%
  summarize(min = min(BPSysAve, na.rm = TRUE),
            max = max(BPSysAve, na.rm = TRUE)) 

print(ref_min_max)


## 4. Compute the average and standard deviation for females, but for each age 
##    group separately rather than a selected decade as in question 1. Note that
##    the age groups are defined by 'AgeDecade'. Hint: rather than filtering by 
##    age and gender, filter by 'Gender' and then use group_by().

ref_female <- NHANES %>%
  filter(Gender == "female") %>%
  group_by(AgeDecade) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            sd = sd(BPSysAve, na.rm = TRUE))

print(ref_female)


## 5. Repeat question 4 for males.

ref_male <- NHANES %>%
  filter(Gender == "male") %>%
  group_by(AgeDecade) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            sd = sd(BPSysAve, na.rm = TRUE))

print(ref_male)


## 6. We can actually combine both summaries for question 4 and 5 into one line
##    of code. This is because group_by() permits us to group by more than one 
##    variable. Obtain one big summary table using group_by(AgeDecade, Gender).

ref_female_male <- NHANES %>%
  group_by(AgeDecade, Gender) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            sd = sd(BPSysAve, na.rm = TRUE))

print(ref_female_male)


## 7. For males between the ages of 40-49, compare systolic blood pressure 
##    across race as reported in the 'Race1' variable. Order the resulting 
##    table from lowest to highest average systolic blood pressure. 

ref_male_40_49 <- NHANES %>%
  filter(Gender == "male" & AgeDecade == " 40-49" & !is.na(BPSysAve)) %>%
  arrange(desc(BPSysAve)) %>%
  select(Gender, AgeDecade, Race1, BPSysAve)

ref_male_40_49