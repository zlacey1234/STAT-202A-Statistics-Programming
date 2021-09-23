## Exercises 2.14

## Start by loading the library and data.
##
## library(dslabs)
## data(murders)

library(dslabs)
data(murders)


## 1. Compute the per 100,000 murder rate for each state and store it in an 
##    object called 'murder_rate'. Then use logical operators to create a 
##    logical vector named 'low' that tells us which entries of 'murder_rate' 
##    are lower than 1.

murder_rate <- murders$total / murders$population * 100000
low <- murder_rate < 1.0
print(low)


## 2. Now use the results from the previous question and the function which() 
##    to determine the indices of 'murder_rate' associated with the values 
##    lower than 1. 

low_ind <- which(low)
print(low_ind)


## 3. Use the results from the previous question to report the names of the 
##    states with murder rates lower than 1.

low_states <- murders$state[low_ind]
print(low_states)


## 4. Now extend the code from question 2 and 3 to report the states in the 
##    Northeast with murder rates lower than 1. Hint =: use the previously 
##    defined logical vector 'low' and the logical operator '&'.

northeast <- murders$region == "Northeast"

low_northeast_ind <- which(low & northeast)
low_northeast_states <- murders$state[low_northeast_ind]
print(low_northeast_states)


## 5. In a previous question, we computed the murder rate for each state and 
##    the average of these numbers. How many states are below average?

avg_murder_rate <- mean(murder_rate)
print(avg_murder_rate)    # Average Murder Rate per 100,000 people in the US

below_avg <- murder_rate < avg_murder_rate

sum(below_avg)            # Number of states below average


## 6. Use the match() function to identify the states with abbreviations AK, MI,
##    and IA. Hint: start by defining an index of the entries of 'murders$abb'
##    that match the three abbreviations, then use the [ operator to extract 
##    the states.

match_abb_ind <- match(c("AK", "MI", "IA"), murders$abb)
match_abb_ind

print(murders$state[match_abb_ind])


## 7. Use the '%in%' operator to create a logical vector that answers the 
##    question: which of the following are actual abbreviations: MA, ME, MI, MO, 
##    MU?

abbreviations <- c("MA", "ME", "MI", "MO", "MU") 
actual_abb_bool <- abbreviations %in% murders$abb
print(actual_abb_bool)


## 8. Extend the code you used in question 7 to report the one entry that is 
##    not an actual abbreviation. Hint: use the '!' operator, which turns 
##    'FALSE' into 'TRUE' and vice versa, then which() to obtain an index.

not_actual_abb <- abbreviations[which(!actual_abb_bool)]     
print(not_actual_abb)    # Not an actual abbreviation
