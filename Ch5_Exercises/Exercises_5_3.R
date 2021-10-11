## Exercises 5.3

library(dslabs)
library(tidyverse)

## 1. Use the read_csv() function to read each of the files that the 
##    following code saves in the 'files' object:
##
##    path <- system.file("extdata", package = "dslabs")
##    files <- list.files(path)
##    files

path = system.file("extdata", package = "dslabs")
files = list.files(path)
files

fullpaths = file.path(path, files)

# Copy all the files from the package full path 'path' to the working 
# directory and give them the same names as prior.
file.copy(fullpaths, files)

# List the files in the current working directory
list.files()

co2 = read_csv("carbon_emissions.csv")
murders = read_csv("murders.csv")
olive = read_csv("olive.csv")


## 2. Note that the last one, the 'olive' file, gives us a warning. This 
##    is because the first line of the file is missing a header for tht 
##    first column. 
##
##    Read the help file for read_csv() to figure out how to read in files 
##    without reading this header. If you skip the header, you should not 
##    get this warning. Save the result to an object called 'dat'.

dat = read_csv("olive.csv", col_names = FALSE)


## 3. A problem with the previous approach is that we don't know what the
##    columns represent. Type:
##
##   > names(dat)
##   [1] "X1"  "X2"  "X3"  "X4"  "X5"  "X6"  "X7"  "X8"  "X9"  "X10" "X11"
##
##   We can see that the names are not informative anymore. 
##
##   Use the read_lines() function to read in just the first lines (we 
##   later learn how to extract values from the output).

readLines("olive.csv", n = 1)

read_lines("olive.csv", n_max = 1)