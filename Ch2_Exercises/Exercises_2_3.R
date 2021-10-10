## Exercises 2.3

## 1. What is the sum of the first 100 positive integers? The formula for the 
##    sum of integers 1 through n is:
##
##    n(n + 1)/2
##
##    Define n = 100 and then use R to compute the sum of 1 through 100 using 
##    the formula. What is the sum?

n <- 100

n * (n + 1) / 2


## 2. Now use the same formula to compute the sum of the integers from 1 through
##    1,000.

n <- 1000

n * (n + 1) / 2


## 3. Look at the result of typing the following code into R:
##    
##    n <- 1000
##    x <- seq(1, n)
##    sum(x)

n <- 1000
x <- seq(1, n)
sum(x)

##    Based on the rusults, I believe that the seq() creates a sequenced list 
##    of integers from 1 to n (which is assigned the value 1000) and then sum()
##    calculates the summation of all the values within the object (which for 
##    us is the object sequenced list 'x')


## 4. In math and programming, we say that we evaluate a fuction when we 
##    replace the argument with a given number. So if we type sqrt(4), we 
##    evaluate the sqrt() function. In R, you can evaluate a fuction inside 
##    another function. The evaluations happen form the inside out. Use one 
##    line of code to compute the log, in base 10, of the square root of 100

log10(sqrt(100))


## 5. Which of the following will always return the numeric value stored in x? 
##    You can try out examples and use the help system if you want.
##
##    a. log(10^x)
##    b. log10(x^10)
##    c. log(exp(x))
##    d. exp(log(x, base = 2))
## 
##    First Answer Guess: c
##    Result: Correct 

x <- 34
log(exp(x))
