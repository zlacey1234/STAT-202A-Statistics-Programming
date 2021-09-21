## Exercises 2.5

## 1. Load the US murders dataset. 
##
##    library(dslabs)
##    data(murders)
##
##    Use the fuction str() to examine the structure of the murders 
##    object. Which of the following best describes the variables 
##    represented in this data frame?
##
##    a. The 51 states.
##    b. The murder rates for all 50 states and DC.
##    c. The state name, the abbreviation of the state name, the state’s region, 
##       and the state’s population and total number of murders for 2010.
##    d. str shows no relevant information.
##
##    First Answer Guess: c
##    Results: Correct

library(dslabs)
data(murders)

str(murders)


## 2. What are the column names used be the data frame for these five variables?
##
##    Answer: 
##    1. state
##    2. abbreviations
##    3. region
##    4. population
##    5. total


## 3. Use the accessor $ to extract the state abbreviations and assign them to 
##    the object a. What is tht class of this object? 

a <- murders$abb
print(a)


## 4. Now use the square brackets to extract the state abbreviations and assign 
##    them to the object b. Use the identical() function to determine if a and 
##    b are the same. 

b <- murders[["abb"]]
print(b)

identical(a, b)


## 5. We saw that the region column stores a factor. You can corroborate this 
##    by typing: 
##
##    class(murders$region)
##
##    With one line of code, use the function leves() and length() to determine 
##    the number of regions defined be this dataset. 

class(murders$region)

length(levels(murders$region))


## 6. The function table() takes a vector and returns the frequency of each 
##    element. You can quickly see how many states are in each region by 
##    applying this function. Use this function in one line of code to create
##    a table of states per region. 

table(murders$region)