## Exercises 2.8

## 1. Use the function c() to create a vector with the average high temperatures 
##    in January for Beijing, Lagos, Paris, Rio de Janeiro, San Juan, and 
##    Toronto, which are 35, 88, 42, 84, 81, and 30 degrees Fahrenheit. Call 
##    the object temp.

temp <- c(35, 88, 42, 84, 81, 30)


## 2. Now create a vector with the city names and call the object city

city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")


## 3. Use the names() function and the objects defined in the previous questions
##    to associate the temperature data with the corresponding city.

names(temp) <- city

print(temp)


## 4. Use the [ and : operators to access the temperature of the first three 
##    cities in the list. 

temp[1:3]


## 5. Use the [ operator to access the temperature of Paris and San Juan

temp[c("Paris", "San Juan")]


## 6. Use the : operator to create a sequence of numbers 12, 13, 14, ..., 73. 

12:73


## 7. Create a vector containing all the positive odd numbers smaller than 100. 

seq(1, 100, 2)


## 8. Create a vector of numbers that starts at 6, does not pass 55, and adds 
##    numbers in increments of 4/7: 6, 6 + 4/7, 6 + 8/7,.... How many numbers 
##    does the list have? Hint: use seq and length

q_8 <- seq(6, 55, 4/7)
print(q_8)

length(q_8)


## 9. What is the class of the following object?
## 
##    a <- seq(1, 10, 0.5)
##
##    First Answer Guess: Numeric
##    Result: Correct

a <- seq(1, 10, 0.5)
class(a)


## 10. What is the class of the following object?
##
##     a <- seq(1, 10)
##
##     First Answer Guess: Integer
##     Result: Correct 

a <- seq(1, 10)
class(a)


## 11. The class of class(a<-1) is numeric, not integer. R defaults to numeric 
##     and to force an integer, you need to add the letter L. Confirm that the 
##     class of 1L is integer

class(a <- 1)    ## Numeric
class(a <- 1L)   ## Integer


## 12. Define the following vector: 
##
##     x <- c("1", "3", "5")
## 
##     and coerce it to get interges

x <- c("1", "3", "5")

as.integer(x)