## Exercises 7.15

## Start by loading the dplyr and ggplot2 library as well as the 'murders'
## and 'heights' data. 
##
## library(dplyr)
## library(ggplot2)
## library(dslabs)
## data(heights)
## data(murders)

library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
data(murders)

## 1. With the ggplot2 R package, plots can be saved as objects. For 
##    example we can associate a dataset with a plot object like this
##
##    p <- ggplot(data = murders)
##
##    Because 'data' is the first argument we don't need to spell it out
##
##    p <- ggplot(murders)
##
##    and we can also use the pipe: 
##   
##    p <- murders %>% ggplot()
##
##    What is class of the object 'p'?
##
##    Result: "gg" and "ggplot"

p = murders %>% ggplot()

class(p)



## 2. Remember that to print an object you can use the command print() or 
##    simply type the object. Print the object 'p' defined in Question 1
##    and describe what you see.
##
##    a. Nothing happens.
##    b. A blank slate plot.
##    c. A scatter plot.
##    d. A histogram.
##
##    Result: b

print(p)


## 3. Using the pipe %>%, create an object 'p' but this time associated 
##    with the 'heights' dataset instead of the 'murders' dataset. 

p = heights %>% ggplot()


## 4. What is the class of the object 'p' you have just created?
##
##    Result: "gg" and "ggplot"

class(p)


## 5. Now we are going to add a layer and the corresponding aesthetic 
##    mappings. For the murders data we plotted total murders versus 
##    population sizes. Explore the 'murders' data frame to remind 
##    yourself what are the names for these two variables and select the 
##    correct answer. Hint: Look at ?murders.
##
##    a. 'state' and 'abb'
##    b. 'total_murders' and 'population_size'
##    c. 'total' and 'population'
##    d. 'murders' and 'size'
##  
##    Result: c

?murders


## 6. To create the scatterplot we add a layer with geom_point(). The 
##    aesthetic mappings require us to define the x-axis and y-axis 
##    variables, respectively. So the code looks like this: 
##
##    murders %>% ggplot(aes(x = , y = )) + 
##      geom_point()
##
##    except for that we have to define the two variables 'x' and 'y'. 
##    Fill this out with the correct variable names. 

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point()


## 7. Note that if we don't use argument names, we can obtain the same 
##    plot by making sure we enter the variable names in the right order 
##    like this:
##
##    murders %>% ggplot(aes(population, total)) +
##      geom_point()
##
##    Remake the plot but now with 'total' in the x-axis and 'population' 
##    in the y-axis. 

murders %>% ggplot(aes(total, population)) + 
  geom_point()


## 8. If instead of points we want to add text, we can use the geom_text() 
##    or geom_label() geometries. The following code:
##
##    murders %>% ggplot(aes(population, total)) + geom_label()
##
##    will give us the error message: Error: geom_label requires the 
##    following missing aesthetics: label
## 
##    Why is this?
##
##    a. We need to map a character to each point through the label 
##       argument in aes.
##    b. We need to let geom_label() know what character to use in the 
##       plot.
##    c. The geom_label() geometry does not require x-axis and y-axis 
##       values.
##    d. geom_label() is not a ggplot2 command.
##
##    Result: a


## 9. Rewrite the code above to use abbreviations as the label through 
##    aes().

murders %>% ggplot(aes(total, population)) + 
  geom_label(aes(label = abb))


## 10. Change the color of the label to blue. How will we do this?
##
##     a. Adding a column called 'blue' to 'murders'.
##     b. Because each label needs a different color we map the colors 
##        through aes().
##     c. Use the 'color' argument in ggplot().
##     d. Because we want all colors to be blue, we do not need to map 
##        colors, just use the color argument in geom_label().
##
##     Result: d


## 11. Rewrite the code above to make the labels blue.

murders %>% ggplot(aes(total, population,label = abb)) + 
  geom_label(color = "blue")


## 12. Now suppose we want to use color to represent the different regions. 
##     In this case which of the following is most appropriate:
##
##     a. Adding a column called 'color' to 'murders' with the color we 
##        want to use.
##     b. Because each label needs a different color we map the colors 
##        through the color argument of aes().
##     c. Use the 'color' argument in ggplot().
##     d. Because we want all colors to be blue, we do not need to map 
##        colors, just use the color argument in geom_label().
##
##     Result: b


## 13. Rewrite the code above to make the labels' color be determined by 
##     the the state's region.

murders %>% ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()


## 14. Now we are going to change the x-axis to a log scale to account for 
##     the fact the distribution of population is skewed. Let’s start by 
##     defining an object 'p' holding the plot we have made up to now
##
##     p <- murders %>% 
##       ggplot(aes(population, total, label = abb, color = region)) +
##       geom_label()
##
##     To change the x-axis log scale we learned that about the 
##     scale_x_log10() function. Add this layer to the object 'p' to 
##     change the scale and render the plot. 

p = murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label() + 
  scale_x_log10() + 
  xlab("Population (log scale)") +
  ylab("Total number of murders")

print(p)


## 15. Repreat the previous Question but not change both axes to be in the 
##     log scale. 

p = murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label() + 
  scale_x_log10() + 
  scale_y_log10() +
  xlab("Population (log scale)") +
  ylab("Total number of murders (log scale)")

print(p)


## 16. Now edit the code above to add the title "Gun Murder Data" to the 
##     plot. Hint: use the ggtitle() function

p = murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label() + 
  scale_x_log10() + 
  scale_y_log10() +
  xlab("Population (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("Gun Murder Data")

print(p)