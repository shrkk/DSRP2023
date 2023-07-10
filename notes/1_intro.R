number <- 5
number
number <- number + 1
#this is a comment
# R Objects ####
ls() #prints all objects in environment ---> 
number <- 1
decimal <- 1.5
letter <- "a"
word <- "hey"
logic <- TRUE
logic2 <- T


#types of variables ####
class(number)
class(decimal)
class(letter)
class(word)
class(logic)
class(logic2)

#there is more variation in type
typeof(number)
typeof(decimal)

#we can change the type of an object 
as.character(number)


#how to round numbers ####
round(decimal)
decimal
#original values are retained in the environment
round(22/7, 3)
?round

#ceiling vs floor
ceiling(22/7)
floor(22/7)

#manipulation ####

#good naming conventions:
camelCase <- "start with capital letters"
snake_case <- "underscores between words"

##
name <- "Shreyank"
paste(name, "is", "coding")
paste0(name, "GUPTA")

logic <- T
paste0("so",logic)

food <- "Watermelon"
grepl("me", food)
sub("me", "you", food)

  
#vectors ####
#make a vector of numerics
numbers <- c(2,4,6,8,10)
range_vals <- 1:5
range_vals
seq(2,10,2) #"from" 2 "to" 10 "by" 2
#these parameters can be reversed in the code; non-sequential


#make a vector of characters
letters <- c("a", "b", "c", "d")
#paste is different from printing a vector
letters <- c("x", letters, "y")
letters

#sequences
rep(3,5)
rep(c(1,2,3),5)
#can set an each parameter to do each in a sequence by the specified quantity

new_vec <- c(rep(1,3), rep(2,3))
new_vec

numbers <- 1:20
five_nums <- sample(numbers, 5)
?sample
#sample takes a sample of the specified size 
# from the elements of x using either with or without replacement.

sort(five_nums, F)
fifteen_nums <- sample(numbers, 15, replace = T)
fifteen_nums <- sort(fifteen_nums)
length(fifteen_nums)
unique(fifteen_nums)
length(unique(fifteen_nums))
table(fifteen_nums)
?table

nums1 <- c(1,2,3)
nums2 <- c(4,5,6)
nums3 <- c(nums1, nums2)
nums3 + nums1 +1

#Vector indexing
numbers <- rev(numbers)
numbers
numbers[1]

numbers[c(1,2,3,4,5)]
numbers[1:5]
numbers[c(1,2,3,13,5)]

#datasets ####
?mtcars
mtcars
View(mtcars) #view entire dataset in new tab
summary(mtcars) #basic stats about the dataset + spread by variable
str(mtcars) #structure + first few values in dataset

names(mtcars)
head(mtcars, 5)

##pull out individual values as vectors
mpg <- mtcars[,1] #all rows, 1st column
mtcars[2,2] #2nd row, 2nd column
mtcars[3,] #third row, all columns
mtcars[,1:3]

#use names to pull rows
mtcars$gear
mtcars[,c("gear", "mpg")]

sum(mtcars$gear)

iris
iris[1:5,1]
first5 <- iris$Sepal.Length[1:5]
mean(first5)
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
range(iris$Sepal.Length)
var(first5)
var(iris$Sepal.Length)

IQR(first5)
quantile(first5, 0.25)
quantile(first5, 0.75)

##outliers
sl <- iris$Sepal.Length
lower<- mean(sl) - 3*sd(sl)
upper<- mean(sl) + 3*sd(sl)

as.numeric(quantile(sl, 0.25) - 1.5*IQR(sl))
quantile(sl,0.75) + 1.5*IQR(sl)

#subsetting vectors
first5
first5 < 4.75 | first5 > 5
first5[first5 < 4.75]

values <- c(first5, 3, 9)
first5[first5 > lower & first5 < upper]







##read in data 
getwd()
super_data <- read.csv("data/super_hero_powers.csv")
super_data