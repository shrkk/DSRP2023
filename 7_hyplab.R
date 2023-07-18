library(ggplot2)
library(dplyr)
library(corrplot)

heart_data <- read.csv("data/heart.csv")


hchol <- heart_data |>
  filter(chol>200)

hchol_male <- hchol |>
  filter(sex == 1) |>
  select(sex, chol)

hchol_fem <- hchol |>
  filter(sex == 0) |>
  select(sex, chol)
## do males or females have more unhealthy serum cholestrol levels
## null: they both have the same serum cholestrol levels.


t.test(hchol_male, hchol_fem, paired = F, alternative = "two.sided")

##p value is 0.1332, so non-significant results.

## null: there is a neutral relationship between sex and resting bp levels.
sigtrestbps <- aov(data = heart_data, trestbps ~ sex)
summary(sigtrestbps)
##0.0114 *, non-significant relationship between resting bp and sex.

## null: there is a neutral relationship between sex and serum cholestrol levels.
sigchol <- aov(data = heart_data, chol ~ sex)
summary(sigchol)
##1.52e-10 ***, significant relationship between serum cholesterol levels and sex.

heart_data |>
  filter(heart_data$oldpeak > 1.5) ##filtered for severe st depression level
## null: there is a neutral relationship between sex and st depression levels.
sigoldpeak <- aov(data = heart_data, oldpeak ~ sex)
summary(sigoldpeak)

##0.00667 **, semi-significant relationship between st depression levels and sex.

##null hyp: there is a neutral relationship between sex and chest pain
hd_clean <- heart_data |>
  filter(sex != "-",
         cp != "0")

t <- table(hd_clean$cp, hd_clean$sex)
chi <- chisq.test(t)
chi

corrplot(chi$residuals, is.cor = F)

##p-value = 0.001932, there is a semi-significant relationship between sex and chest pain.






