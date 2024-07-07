#loading dataset 
setwd("F:\\vit\\YEAR 3\\SEM 5\\DATA 
ANAL\\lab\\DATASET") 
data=read.csv("Sleep_health_and_lifestyle_dataset.csv") 
n=nrow(data) 
n 
library(missForest) 
library(Hmisc) 
library(dplyr) 
# Remove a column by specifying its name 
data <- subset(data, select = -Person.ID) 
# inding data types of each column 
print(class(data$Gender)) 
print(class(data$Age)) 
print( class(data$Occupation)) 
print(class(data$Sleep.Duration)) 
print(class(data$Quality.of.Sleep)) 
print(class(data$Physical.Activity.Level)) 
print(class(data$Stress.Level)) 
print(class(data$BMI.Category)) 
print(class(data$Blood.Pressure)) 
#ANOMALIES 
#structural : normal and normal weight , overweight and obese , blood pressure - sistolic and diastolic in same column (character data type) 
data=replace(data, data=="Normal Weight","Normal") 
data=replace(data, data=="Overweight","Obese") 
data$systolic=substring(data$Blood.Pressure,1,3) 
data$diastolic=substring(data$Blood.Pressure,5,6) 
data$systolic=as.integer(data$systolic) 
data$diastolic=as.integer(data$diastolic)
13 
print(class(data$systolic)) 
print(class(data$diastolic)) 
#create new dataframe 
data=select(data,-9) 
data  
data$Quality.of.Sleep=as.integer(data$Quality.of.Sleep) #data encoding 
library(caret) 
columns_to_encode <- c('Gender', 'Occupation', 'BMI.Category', 'Sleep.Disorder') 
for (col in columns_to_encode) { 
data[[col]] <- as.numeric(factor(data[[col]])) 
} 
View(data) 
#data normalisation 
# Function to normalize dataset using min-max scaling normalize <- function(data) { 
normalized_data <- data  
for (col in colnames(data)) { 
column <- data[[col]] 
normalized_column <- (column - min(column)) / (max(column) - min(column)) 
normalized_data[[col]] <- normalized_column 
} 
return(normalized_data) 
} 
data <- normalize(data) 
print(data) 
#checking for outliers 
Q <-quantile(data$Daily.Steps, probs=c(.25, .75), na.rm = FALSE) 
iqr <-IQR(data$Daily.Steps) 
up <-Q[2]+1.5*iqr # Upper Range 
low<-Q[1]-1.5*iqr # Lower Range 
eliminated<-subset(data,data$Daily.Steps > (Q[1] -1.5*iqr) &data$Daily.Steps < (Q[2]+1.5*iqr)) 
print(eliminated) 
#increase rows in data set 
eliminated=rbind(eliminated,eliminated,eliminated,eliminated, eliminated,eliminated)
14 
View(eliminated) 
#AIM:SLEEP QUALITY PREDICTION 
# Install the 'caret' package if not already installed # install.packages("caret") 
#test data and train data  
library(caret) 
# Set the seed for reproducibility 
set.seed(123) 
# Specify the proportion of data to use for training (e.g., 80%) train_prop <- 0.8 
# Create the train and test datasets 
train_data <- createDataPartition(eliminated$Sleep.Disorder, p = train_prop, list = FALSE) 
train_dataset <- eliminated[train_data, ] 
test_dataset <- eliminated[-train_data, ] 
View(train_dataset) 
View(test_dataset) 
#logistic regression 
#install.packages("nnet") 
library(nnet) 
# Fit a logistic regression model 
model <- lm(Quality.of.Sleep ~ Gender + Age + Occupation + Sleep.Duration + Physical.Activity.Level + Stress.Level + BMI.Category + Heart.Rate + Daily.Steps +Sleep.Disorder + systolic + diastolic, data = train_dataset) 
# Print the model summary 
summary(model) 
#making predictions using the trained model 
predictions <- predict(model, newdata = test_dataset, type = "response") 
View(predictions) 
new_data <- data.frame(predictor1 = c(1, 2), predictor2 = c(3, 4)) 
predictions <- predict(model, newdata = test_dataset, type = "response")
data=read.csv("Sleep_health_and_lifestyle_dataset.csv") n=nrow(data) 
n 
library(missForest) 
library(Hmisc) 
library(dplyr) 
data <- subset(data, select = -Person.ID) 
# inding data types of each column 
print(class(data$Person.ID)) 
print(class(data$Gender)) 
print(class(data$Age)) 
print( class(data$Occupation)) 
print(class(data$Sleep.Duration)) 
print(class(data$Quality.of.Sleep)) 
print(class(data$Physical.Activity.Level)) 
print(class(data$Stress.Level)) 
print(class(data$BMI.Category)) 
print(class(data$Blood.Pressure)) 
#ANOMALIES 
#structural : normal and normal weight , overweight and obese , blood pressure - sistolic and diastolic in same column (character data type) 
data=replace(data, data=="Normal Weight","Normal") data=replace(data, data=="Overweight","Obese") 
data$systolic=substring(data$Blood.Pressure,1,3) 
data$diastolic=substring(data$Blood.Pressure,5,6) 
data$systolic=as.integer(data$systolic) 
data$diastolic=as.integer(data$diastolic) 
print(class(data$systolic)) 
print(class(data$diastolic)) 
#create new dataframe 
dataclean=select(data,-9) 
dataclean 
data$Quality.of.Sleep=is.numeric(data$Quality.of.Sleep) #checking for outliers 
Q <-quantile(dataclean$Daily.Steps, probs=c(.25, .75), na.rm = FALSE)
16 
iqr <-IQR(dataclean$Daily.Steps) 
up <-Q[2]+1.5*iqr # Upper Range 
low<-Q[1]-1.5*iqr # Lower Range 
eliminated<-subset(dataclean,dataclean$Daily.Steps > (Q[1] -1.5*iqr) &dataclean$Daily.Steps < (Q[2]+1.5*iqr)) print(eliminated) 
#AIM:AUTOMATIC SLEEP DISORDER PREDICTION library(caret) 
View(eliminated) 
columns_to_encode <- c('Gender', 'Occupation', 'BMI.Category', 'Sleep.Disorder') 
for (col in columns_to_encode) { 
eliminated[[col]] <- as.numeric(factor(eliminated[[col]])) } 
View(eliminated) 
# Install the 'caret' package if not already installed # install.packages("caret") 
library(caret) 
set.seed(123) 
train_prop <- 0.8 
# Create the train and test datasets 
train_data <- createDataPartition(eliminated$Sleep.Disorder, p = train_prop, list = FALSE) 
train_dataset <- eliminated[train_data, ] 
test_dataset <- eliminated[-train_data, ] 
View(train_dataset) 
View(test_dataset) 
#logistic regression 
install.packages("nnet") 
library(nnet) 
#gaussian 
# Fit a logistic regression model 
model <- glm(Sleep.Disorder ~ Gender + Age + Occupation + Sleep.Duration + Quality.of.Sleep + Physical.Activity.Level + Stress.Level + BMI.Category + Heart.Rate + Daily.Steps + systolic + diastolic, data = train_dataset, family= gaussian) # Print the model summary 
summary(model) 
#making predictions using the trained model
17 
predictions1 <- predict(model, newdata = test_dataset, type = "response") 
View(predictions1) 
#poisson 
# Fit a logistic regression model 
model <- glm(Sleep.Disorder ~ Gender + Age + Occupation + Sleep.Duration + Quality.of.Sleep + Physical.Activity.Level + Stress.Level + BMI.Category + Heart.Rate + Daily.Steps + systolic + diastolic, data = train_dataset, family= poisson) # Print the model summary 
summary(model) 
#making predictions using the trained model 
predictions2 <- predict(model, newdata = test_dataset, type = "response") 
View(predictions2) 
#gamma  
# Fit a logistic regression model 
model <- glm(Sleep.Disorder ~ Gender + Age + Occupation + Sleep.Duration + Quality.of.Sleep + Physical.Activity.Level + Stress.Level + BMI.Category + Heart.Rate + Daily.Steps + systolic + diastolic, data = train_dataset, family= gamma) # Print the model summary 
summary(model) 
#making predictions using the trained model 
predictions3 <- predict(model, newdata = test_dataset, type = "response") 
View(predictions3)
