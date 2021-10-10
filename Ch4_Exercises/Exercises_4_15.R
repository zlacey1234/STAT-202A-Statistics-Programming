## Exercises 4.15

library(dplyr)
library(dslabs)
library(purrr)
data(murders)

## 1. Load the 'murders' dataset. Which of the following is true?
##
##    a. 'murders' is in tidy format and is stored in a tibble.
##    b. 'murders' is in tidy format and is stored in a data frame.
##    c. 'murders' is not in tidy format and is stored in a tibble.
##    d. 'murders' is not in tidy format and is stored in a data frame.
##
##    First Answer Guess: b
##    Result: Correct

murders 



## 2. Use as_tibble() to convert the 'murders' data table into a tibble and 
##    save it in an object called 'murders_tibble'.

murders_tibble <- as_tibble(murders)

print(murders_tibble)


## 3. Use the group_by() function to convert 'murders' into a tibble that is 
##    grouped by region.

murders %>% 
  group_by(region)


## 4. Write tidyverse code that is equivalent to this code:
##
##    exp(mean(log(murders$population)))
##
##    Write it using the pipe so that each function is called without arguments. 
##    Use the dot operator to access the population. Hint: The code should start
##    with 'murders %>%'

exp(mean(log(murders$population)))

## Note: When doing operations in piping series, operations are done from left 
##       to right (done in the order of the piping)
murders %>% 
  .$population %>% 
  log() %>%
  mean() %>%
  exp()


## 5. Use the map_df() to create a data frame with three columns named 'n', 
##    's_n', and 's_n_2'. The first column should contain the numbers 1 through
##    100. The second and third columns should contain the sum of 1 through n 
##    with n representing the row number.

n = 1:100

compute_s_n = function(n) {
  x = 1:n
  tibble(s_n = sum(x), s_n_2 = sum(x))
}
  
map_df(n, compute_s_n)
