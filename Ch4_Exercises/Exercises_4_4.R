## Exercises 4.4

## 1. Load the 'dplyr' package and the murders dataset.
##
##    library(dplyr)
##    library(dslabs)
##    data(murders)
##
##    You can add columns using the 'dplyr' function mutate(). This function is 
##    aware of the column names and inside the function you can call them 
##    unquoted:
##
##    murders <- mutate(murders, population_in_millions = population / 10^6)
##
##    We can write 'population' rather than 'murders$population'. The function
##    mutate() knows we are grabbing columns from 'murders'.
##
##    Use the function mutate() to add a murders column named 'rate' with the 
##    per 100,000 murder rate as in the example code above. Make sure you 
##    redefine 'murders' as done in the example code above 
##    (murders <- [your code]) so we can keep using this variable. 

library(dplyr)
library(dslabs)
data(murders)

murders <- mutate(murders, rate = total / population * 100000)


## 2. If rank(x) gives you the ranks of 'x' from lowest to highest, rank(-x) 
##    gives you the ranks from highest to lowest. Use the fucntion mutate() to 
##    add a column 'rank' containing the rank, from highest to lowest murder 
##    rate. Make sure you redefine 'murders' so we can keep using this variable.

murders <- mutate(murders, rank = rank(-rate))


## 3. With 'dplyr', we can use select() to show only certain columns. For 
##    example, with this code we would only show the states and population 
##    sizes:
##
##    select(murders, state, population) %>% head()
##
##    Use select() to show the state names and abbreviations in 'murders'. Do 
##    not redefine 'murders', just show the results.

select(murders, state, abb) %>% head()


## 4. The 'dplyr' function filter() is used to choose specific rows of the data
##    frame to keep. Unlike select() which is for columns, filter() is for rows. 
##    For example, you can show just the New York row like this: 
##
##    filter(murders, state == "New York")
##
##    You can use other logical vectors to filter rows. 
##
##    Use filter() to show the top 5 states with the highest murder rates. After
##    we add the murder rate and rank, do not change the murders dataset, just
##    show the result. Remember that you can filter based on the 'rank' column.

filter(murders, rank <= 5)


## 5. We can remove rows using the '!=' operator. For example, to remove 
##    Florida, we would do this:
## 
##    no_florida <- filter(murders, state != "Florida")
##
##    Create a new data frame called 'no_south' that removes states from the 
##    South region. How many states are in this category? You can us the 
##    function nrow() for this. 

no_south <- filter(murders, region != "South")

num_states_south <- nrow(murders) - nrow(no_south)


## 6. We can also use %in% to filter with 'dplyr'. You can therefore see the 
##    data from New York and Texas like this:
##
##    filter(murders, state %in% c("New York", "Texas"))
##
##    Create a new data frame called 'murders_nw' with only the states from the 
##    Northeast and the West. How many states are in this category?

murders_nw <- filter(murders, region %in% c("Northeast", "West"))

 
## 7. Suppose you want to live in the Northeast or West and want the murder 
##    rate to be less than 1. We want to see the data for the states satisfying 
##    these options. Note you can use logical operators with filter(). Here is 
##    an example in which we filter to keep only small states in the Northeast 
##    region.
##
##    filter(murders, population < 5000000 & region == "Northeast")
##
##    Make sure 'murders' has been defined with 'rate' and 'rank' and still has 
##    all states. Create a table called 'my_states' that contatins the rows for 
##    states satisfying both the conditions: it is in the Northeast or West and 
##    the murder rate is less than 1. Use select() to show only the state name, 
##    the rate, and the rank.

my_states <- filter(murders, (rate <= 1) & (region == "West" | 
                                            region == "Northeast"))

## Alternative method
my_states_alternative <- filter(murders, 
                                (rate <= 1) & region %in% c("Northeast", 
                                                            "West"))

select(my_states, state, rate, rank)
