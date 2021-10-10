## Exercises 4.6

library(dplyr)
library(dslabs)
data(murders)

## 1. The pipe %>% can be used to perform operations sequentially without having
##    to define intermediate objects. Start by redefining murders to include 
##    rate and rank. 
##
##    murder <- mutate(murders, rate = total, population * 100000, 
##                     rank = rank(-rate))
##    
##    In the solution to the previous exercises, we did the following:
##
##    my_states <- filter(murders, regions %in% c("Northeast", "West") & 
##                                 rate < 1)
##    select(mystates, state, rate, rank)
##
##    The pipe %>% permits us to perforn both operations sequentially withot 
##    having to define an intermediate variable 'my_states'. We therefore could 
##    have mutated and selected in the same line like this: 
##
##    mutate(murders, rate = total / population * 100000,
##           rank = rank(-rate)) %>% 
##      select(state, rate, rank)
##
##    Notice that select() no longer has a data frame as the first argument. 
##    The first argument is assumed to be the result of the operation conducted
##    right before the %>%.
##
##    Repeat the previous exercise, but now instead of creating a new object, 
##    show the result and only include the state, rate, and rank columns. Use a
##    pipe %>% to do this in just one line.

mutate(murders, rate = total / population * 100000,
       rank = rank(-rate)) %>%
  select(state, rate, rank)


## 2. Reset 'murders' to the original table by using data(murders). Use a pipe
##    to crate a new data frame called 'my_states' that considers only states 
##    in the Northeast and West which have murder rate lower than 1, and 
##    contains only the state, rate, and rank columns. The pipe should also 
##    have four components separated by three %>%. The code should look like 
##    this:
##
##    my_states <- murders %>%
##      mutate SOMETHING %>%
##      filter SOMETHING %>%
##      select SOMETHING

data(murders)

my_states <- murders %>%
  mutate(rate = total / population * 100000,
         rank = rank(-rate)) %>%
  filter(region %in% c("Northeast", "West") & rate < 1) %>%
  select(state, rate, rank)

my_states