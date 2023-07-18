#Step 1
library(ggplot2)
library(dplyr)
library(parsnip)
#install.packages("ggcorrplot")
library(ggcorrplot)

#Step 2
heart_data <- read.csv("data/heart.csv")

#Step 3
#noNas <- filter(heart_data, !is.na(trestbps), !is.na(chol), !is.na(thalach))
repMean <- mutate(heart_data,
                  trestbps = ifelse(is.na(trestbps),
                                    mean(trestbps),
                                    trestbps),
                  chol = ifelse(is.na(chol),
                                    mean(chol),
                                    chol),
                  thalach = ifelse(is.na(thalach),
                                    mean(thalach),
                                    thalach))

#Step 4
library(reshape2)


hdCor <- cor(heart_data) |>
  melt() |>
  as.data.frame()

ggplot(hdCor, aes(x= Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "seagreen", mid = "white", high = "coral", midpoint = 0)

corr <- round(cor(heart_data), 1)
ggcorrplot(corr, method = "circle")

#Step 5
library(rsample)
set.seed(423789)

data_reg_split <- initial_split(heart_data, prop = 0.75)
train_reg_data <- training(data_reg_split)
test_reg_data <- testing(data_reg_split)

lin_reg_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(trestbps ~ age + oldpeak + chol, data = train_reg_data)

summary(lin_reg_fit$fit)

bt_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(trestbps ~ age + oldpeak + chol, data = train_reg_data)
summary(bt_fit$fit)

rf_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(trestbps ~ age + oldpeak + chol, data = train_reg_data)
summary(rf_fit$fit)

#Step 6
library(MLmetrics)

hdPred <- test_reg_data
hdPred$linReg <- predict(lin_reg_fit, test_reg_data)$.pred
hdPred$logReg <- predict(bt_fit, test_reg_data)$.pred
hdPred$rfReg <- predict(rf_fit, test_reg_data)$.pred

yardstick::mae(hdPred, trestbps, linReg)
yardstick::rmse(hdPred, trestbps, linReg)

yardstick::mae(hdPred, trestbps, logReg)
yardstick::rmse(hdPred, trestbps, logReg)

yardstick::mae(hdPred, trestbps, rfReg)
yardstick::rmse(hdPred, trestbps, rfReg)

