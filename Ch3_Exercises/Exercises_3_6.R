## Exercises 3.6

library(dslabs)
data(murders)

## 1. What will this conditional expression return?
##
##    x <- c(1, 2, -3, 4)
##    
##    if(all(x > 0)){
##      print("All Positives")
##    } else {
##      print("Not All Positives")
##    }
## 
##    First Answer Guess: Not All Positives
##    Result: Correct

x <- c(1, 2, -3, 4)

if(all(x > 0)){
  print("All Positives")
} else {
  print("Not All Positives")
}


## 2. Which of the following expressions is always 'FALSE' when at least one 
##    entry of a logical vector 'x' is 'TRUE'?
##
##    a. all(x)
##    b. any(x)
##    c. any(!x)
##    d. all(!x)
##
##    First Answer Guess: d
##    Result: Correct


## 3. The function nchar() tell you how many charactes long a character vector 
##    is. Write a line of code that assigns the object 'new_names' the state 
##    abbreviation when the state name is longer than 8 characters.

states <- murders$state
print(states)

n_char <- nchar(states)

new_names <- states[which(n_char > 8)] <- murders$abb[which(n_char > 8)]

print(new_names)

# One-line version
new_names <- murders$state[nchar(murders$state) > 8] <- murders$abb[nchar(murders$state) > 8]


## 4. Create a function sum_n() that for any given value, say 'n', computes the 
##    sum of the integers frim 1 to n (inclusive). Use the function to determine 
##    the sum of the integers from 1 to 5,000.

sum_n <- function(n) {
  x <- 1:n
  sum(x)
}

sum_n(5000)


## 5. Create a functions altman_plot() that takes two arguments, 'x' and 'y', 
##    and plots the difference against the sum. 




## 6. After running the code below, what is the value of 'x'?
##
##    x <- 3
##    my_func <- function(y) {
##      x <- 5
##      y+5
##    }




## 7. Write a function compute_s_n() that for any given 'n' computes the sum:
##
##    S_n = 1^2 + 2^2 + 3^2 + ... + n^2
##
##    Report the value of the sum when n = 10.




## 8. Define an empty numerical vector 's_n' of size 25 using
##
##    s_n <- vector("numeric", 25)
##
##    and store the results of S_1, S_2, ..., S_25 using a for loop.




## 9. Repeat question 8, but this time use sapply().




## 10. Repeat question 8, but this time use map_dbl().




## 11. Plot S_n versus n. Use points defined by n = 1, ..., 25




## 12. Confirm that the formula for this sum is S_n = n(n + 1)(2n + 1)/6



