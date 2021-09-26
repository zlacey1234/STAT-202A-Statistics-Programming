## Exercises 3.6

library(dslabs)
library(purrr)
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


## 3. The function nchar() tell you how many characters long a character vector 
##    is. Write a line of code that assigns the object 'new_names' the state 
##    abbreviation when the state name is longer than 8 characters.

states <- murders$state
print(states)

n_char <- nchar(states)

new_names <- ifelse(n_char > 8, murders$abb, states)

print(new_names)

# One-line version
new_names <- ifelse(nchar(murders$state) > 8, murders$abb, murders$state)
print(new_names)

## 4. Create a function sum_n() that for any given value, say 'n', computes the 
##    sum of the integers from 1 to n (inclusive). Use the function to determine 
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
##
##    First Answer Guess: x maintains the value 3
##    Result: Correct. Since 'x <-5' is within the function my_func(), the 
##            assignment value is done within the function but does not impact
##            the work-space.

x <- 3

my_func <- function(y) {
  x <- 5
  y + 5
}


## 7. Write a function compute_s_n() that for any given 'n' computes the sum:
##
##    S_n = 1^2 + 2^2 + 3^2 + ... + n^2
##
##    Report the value of the sum when n = 10.

compute_s_n <- function(n) {
  n <- 1:n
  sum(n^2)
}

compute_s_n(10)


## 8. Define an empty numerical vector 's_n' of size 25 using
##
##    s_n <- vector("numeric", 25)
##
##    and store the results of S_1, S_2, ..., S_25 using a for loop.

n_iterations <- 20000

# Start the clock!
ptm <- proc.time()

s_n <- vector("numeric", n_iterations)

for(n_i in 1:n_iterations) {
  s_n[n_i] <- compute_s_n(n_i)
}

# Stop the clock
proc.time() - ptm

print(s_n)


## 9. Repeat question 8, but this time use sapply().

# Start the clock!
ptm <- proc.time()

n_i <- 1:n_iterations
s_n_9 <- sapply(n_i, compute_s_n)

# Stop the clock
proc.time() - ptm

print(s_n_9)

## 10. Repeat question 8, but this time use map_dbl().

# Start the clock!
ptm <- proc.time()

n_i <- 1:n_iterations
s_n_10 <- map_dbl(n_i, compute_s_n)

# Stop the clock
proc.time() - ptm

print(s_n_10)


## 11. Plot S_n versus n. Use points defined by n = 1, ..., 25

plot(n_i, s_n)


## 12. Confirm that the formula for this sum is S_n = n(n + 1)(2n + 1)/6

compute_s_n_check <- function(n) {
  n * (n + 1) * (2 * n + 1) / 6
}
# Start the clock!
ptm <- proc.time()

s_n_check <- sapply(n_i, compute_s_n_check)

# Stop the clock
proc.time() - ptm

identical(s_n, s_n_check)

