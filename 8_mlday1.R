##Unsupervised Learning
##Principal Component Analysis 
head(iris)

##remove any non-numeric variables
irisNum <- select(iris, -Species)

## do PCA
pcas <- prcomp(irisNum, scale. = T)
summary(pcas)
pcas$rotation

##get the x values of pcas and make a data frame
pcaval <- as.data.frame(pcas$x)
pcaval$Species <- iris$Species

ggplot(pcaval, aes(PC1, PC2, color = Species)) +
  geom_point() +
  theme_gray()
##mpg 

table(mpg$manufacturer, mpg$class)
table(mpg$cyl, mpg$displ)

t <- table(mpg$year, mpg$drv)

chires <- chisq.test(t)
chires

#install.packages("corrplot")
library(corrplot)

corrplot(chires$residuals)

heroes <- read.csv("data/heroes_information.csv")
head(heroes)

heroes_clean <- heroes |>
  filter(Alignment!= "-",
         Gender != "-")
ggplot(heroes_clean, aes(x = Gender, y = Alignment)) + 
  geom_count() + 
  theme_minimal()

t <- table(heroes_clean$Alignment, heroes_clean$Gender)
chi <- chisq.test(t)

corrplot(chi$residuals, is.cor = F)

### Supervised Machine Learning Models ####

##load required packages
library(dplyr)

## Step 1: Collect data
head(iris)

## Step 2: Clean and Process Data
##n/a for iris dataset

noNas <- filter(starwars, !is.na(mass), is.na(height))

replaceMeans <- mutate(starwars, 
                       mass = ifelse(is.na(mass),
                                     mean(mass),
                                     mass))


## Encoding categories as factors or integers
#if categorical variable is a character, make it a factor
intSpecies <- mutate(starwars, 
                     species = as.integer(as.factor(species)))

# if cat variable is already a factor, make it an integer
irisAllNum <- mutate(iris,
                     Species = as.integer(Species))

## Step 3: Visualize Data
#Make a PCA
# Calculate correlations
#install.packages("reshape2")

library(ggplot2)
library(reshape2)

irisCors <- cor(irisAllNum) |>
  melt() |>
  as.data.frame()

ggplot(irisCors, aes(x=Var1, y = Var2, fill = value)) +
  geom_tile()+
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", 
                       midpoint = 0)

ggplot(irisAllNum, aes(x=Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

#set seed for reproducability
set.seed(71723)
#install.packages("tidymodels")
#install.packages("rsample")
library(rsample)

#regression dataset splits
#create a split
reg_split <- initial_split(irisAllNum, prop = 0.75) #use 75% of data for training

#use the split to form testing and training sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

##classification dataset splits (use iris instead of irisallnum)
class_split <- initial_split(iris, prop = 0.75)

class_train <- training(class_split)
class_test <- testing(class_split)

#Steps 6 &7: Choose an ML model and train it
#Lin regression

#install.packages("parsnip")
library(parsnip)

lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)

lm_fit$fit

## Sepal.Length = 2.3 + Petal.Length*0.7967 + Petal.Width*-0.4067 + Species * - 0.3312 + Sepal.Width *0.5501

summary(lm_fit$fit)

bin_test <- filter(class_test, Species %in% c("setosa", "versicolor"))
bin_train <- filter(class_test, Species %in% c("setosa", "versicolor"))

##Logistical Regression
log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length +.,
      data = bin_train)
log_fit$fit
summary(log_fit$fit)


## Boosted decision trees
#install.packages("xgboost")
boost_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

boost_fit$fit$evaluation_log

boost_class_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = class_train)
boost_class_fit$fit$evaluation_log

##Random forest
#regression
#install.packages("ranger")
forest_reg_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Species ~ ., data = reg_train)

forest_reg_fit$fit

forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Species ~ ., data = class_train)

forest_class_fit$fit

#step 8: evaluate model performance on test set
#calculate errors for regression
library(yardstick)
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_reg_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

yardstick::mae(reg_results, Sepal.length, lm_pred)
yardstick::mae(reg_results, Sepal.length, boost_pred)
yardstick::mae(reg_results, Sepal.length, forest_pred)

yardstick::rmse(reg_results, Sepal.length, lm_pred)
yardstick::rmse(reg_results, Sepal.length, boost_pred)
yardstick::rmse(reg_results, Sepal.length, forest_pred)

#
install.packages("Metrics")
library(Metrics)
class_results <- class_test

class_results$lm_pred <- predict(log_fit, class_test)$.pred_class
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit, class_test)$.pred_class

f1_Score(class_results$Species, class_results$log_pred)
f1_Score(class_results$Species, class_results$boost_pred)
f1_Score(class_results$Species, class_results$forest_pred)