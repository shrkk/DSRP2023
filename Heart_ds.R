library(ggplot2)
ggplot()

#assignment related values
getwd()
heart_data <- read.csv("data/heart.csv")
hda <- heart_data["age"]
meanval <- mean(heart_data$age)
medval <- median(heart_data$age)
rangeval <- range(heart_data$age)
varval <- var(heart_data$age)
standard <- sd(heart_data$age)
iqr <- IQR(heart_data$age)



ggplot(data=heart_data, aes(x=age))+
  geom_histogram(bins=10, color="red") +
  labs (x = "Age Group", y = "Number of People")
  
ggplot(data = heart_data, aes(x=age, y=trestbps)) +
  geom_point() +
  labs (x = "Age", y = "Average Resting Blood Pressure")

#legend key
Density <- c(5,10,20)

ggplot(data = heart_data, aes(x=age, y=cp, color = cp, size = stat(Density))) +
  geom_count() + 
  labs (x = "Age", y = "Type of Chest Pain (With Age Density)") +
  guides(color = guide_legend(title = "CPI"))
  
  
