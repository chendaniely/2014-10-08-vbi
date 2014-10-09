# setwd() is used to 'set your working directory'
# the same thing can be achieved in RStudio by going to
# Session > Set working directory > ...
# from there you can pick to set the working directory to where the R script is saved
# or where you are in your file pannel on the bottom right.
setwd("~/git/swc/2014-10-08-vbi/novice/r")

# the read.csv() function is used to read in CSV files, by default 'header' is
# set to TRUE
# note, in R the boolean TRUE and FALSE are all in upper case
# you will see the font change color
# you can also use T and F, but it is good not too because you can accidently
# assign vales to T and F with a T <- 3
# TRUE and FALSE will yell at you if you try to assign something to it
read.csv(file = "inflammation-01.csv", header = FALSE)

# assigning values to variables
my_variable <- 5
my_variable <- 6
my_variable = 7

# more ways to name variables:
# my_variable
# myVariable
# thisIsAVariable
# this.is.a.variable
# although you can you periods as variable names in R, just know when you
# start mixing different languages, this may be a place where things will not work
# if you're only working in R, then as long as you pick a style and stay consistent
# you're good

# assign csv to variable
inflammation <- read.csv(file = "inflammation-01.csv", header = FALSE)
# <- or ->, either works, you'll see the former more when searching for help
read.csv(file = "inflammation-01.csv", header = FALSE) -> inflmmation

# look at the first 6 lines
head(inflammation)
# look at the bottom 6 lines
tail(inflammation)
# note, if you want to look at more lines, there's a parameter in head() and tail()

# class() is used to tell you what is this thing?
# in this case, class(inflammation) is a 'data.frame'
class(inflammation)

# dim is used to give you number of observations (rows) and variables (columns)
dim(inflammation)

# subsectioning/slicing dataframes or matrix
# 15th row, 4th coloum
inflammation[15, 4]

# rows 1-4, and columns 1- 10
inflammation[1:4, 1:10]
# rows 1-4, and all columns
inflammation[1:4, ]
# all rows, and only columns 4-6
inflammation[, 4:6]

# to drop a row or column, it is the same syntax, but with a '-' in front
# here we drop the 4th column
inflammation[, -4]
# or drop a range of columns
inflammation[, -c(4:5)]
# note the orinal inflammation has not changed
# this is because we haven't assigned the new dataframe with dropped columns
# to a variable yet
inflammation_drop <- inflammation[, -c(4:5)]

# a vector of numbers
my_vector <- c(4, 5, 6)
# use vectors of numbers to subset dataframes
inflammation[my_vector, my_vector]

# look at the 4th column
inflammation[, 4]
# max() gives you the max number in a vector
# here we look at the max value in the 4th column of our data
max(inflammation[, 4])

# we can assign the columns to a variable just like anything else
fourth <- inflammation[, 4]
# and take the max of this newly defined variable
max(fourth)
# we can also look at other basic stuff
min(fourth)
mean(fourth)
median(fourth)

# apply will 'apply' a function to either all the rows, or all the columns
# here we want to see the max values among all the rows
# that is for each row of our data, what is the max value
# it returns a fector of values
apply(X = inflmmation, MARGIN = 1, FUN = max)

# we can assign this vector of values to a variable
t1_max <- apply(X = inflmmation, MARGIN = 2, FUN = max)
t1_max

# we can subset the vector of values as well, using the [] subset notation
# here we get all the max values for each column, and get the max values for
# column 1 and column 3
t1_max <- apply(X = inflmmation, MARGIN = 2, FUN = max)[c(1, 3)]

apply(X = inflmmation, MARGIN = 1, FUN = mean)
apply()

# vectors do not just have to be numbers, they can contain anyhting
# it's similar to a 'list' in other languages
# this is a vector of letters
element <- c("o", "x", "y", "g", "e", "n")
element[1:3]

# this is a vector of random things
# note that when I have mixed types, they all get converted to a common type
# most of the time it will be a 'string'
# 'strings' are a fancy way of saying multiple characters 'stringed' together
random_things <- c("hello", 3, 3.14, TRUE)
random_things


avg_inf_day <- apply(X = inflammation, MARGIN = 2, FUN = mean)
avg_inf_day
plot(avg_inf_day)

max_inf_day <- apply(X = inflammation, MARGIN = 2, FUN = max)
max_inf_day
plot(max_inf_day)


###############################################################################
# Functions
###############################################################################
# function that calulates fahr to kelvin
fahr_to_kelvin <- function(temp){
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

fahr_to_kelvin(32)
temp

# function that converts fahr to celsius
fahr_to_celsius <- function(temp){
  # instead of re-doing the fahr to celsius conversion again,
  # we can reuse the function we just made
  celsius <- fahr_to_kelvin(temp) - 273.15
  celsius
}
# as long as we pass a number into the function, it will do the calculation
# it can be a bare number, or some calculated number
fahr_to_celsius(fourth[5])

# apply our function to a dataset
# why does this act weird?
apply(X = inflammation, MARGIN = 2, FUN = fahr_to_celsius)
# because for mean, min, max, median, they take a vector of numbers and
# calculate a summary statistic for that
# our function we just made only takes in a single number
# so that's why it returns a matrix of 60x40 values

# let's look at apply() on mean() again
apply(inflammation, 2, mean)

# defining multiple parameters in a function
my_sum <- function(num1, num2, num3){
  num1 + num2 + num3
}
my_sum(1, 2, 3)

# defining multiple parameters in a function with a default value
my_sum <- function(num1, num2, num3=100){
  num1 + num2 + num3
}
# same value as above
my_sum(1, 2, 3)
# when a third parameter is not given, it will calculate it using the
# default value you give it
# you will see many default paraments when you read documentation
my_sum(1, 2)

# strings that stand for file names, are regular strings
# these strings can be saved into a variable, like any other
my_data <- "inflammation-02.csv"
# and variables can be passed around into other functions
read.csv(file = my_data, header = FALSE)

# let's write a function that retuns some summary stats for us
analyze <- function(filename){
  # we will use the print function to print out things to the screen
  print(filename)
  data <- read.csv(file = filename, header = FALSE)
  print('min of dataset')
  print(min(data))
  print('max of dataset')
  print(max(data))
  print('mean of dataset')
  print(mean(data))
  print('columnwise means')
  data_mean <- apply(data, 2, mean)
  print(data_mean)
  plot(data_mean)
}

# now with our analyse function we can give it a filename and it will give us
# some summart stats
analyze("inflammation-01.csv")
analyze("inflammation-02.csv")
analyze("inflammation-03.csv")

# if there was only a few files... ok
# but what if there were 100s?
# you wouldn't want to start typing all that out just to change 1 number...


# loading in excel sheets into R
library(XLConnect) # use this package
# you can install packages using the packages tab on the bottom right
# and clicking install
# and then type in the package name
# find an excel file
dciFile <- '/home/dchen/Dropbox-columbia/Dropbox/NSF Data folder/DCI/dcirecoded_091114.xls'
wkbk <- loadWorkbook(dciFile)
xlsfile <- readWorksheet(wkbk, sheet=1)
class(xlsfile)
# now we have an R data.frame from an excel file
# we can write dataframes to csv using the write.csv funciton
write.csv(xlsfile, 'csvFileFromExcelFile.csv')
# note where your working directory is, it will save it there
# the write.csv will overwrite the file if it already exists, so make sure your
# stuff is always backed so just in case you accidently write over something
# then again, the good thing about using R (or some programming language)
# is that you should always be able to re-run your script and get things back

################################################################################
# LOOPS
################################################################################
words <- c("hello", "everyone", "this", "is", "a", "vector")
words[1]
words[2]

