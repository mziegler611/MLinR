#--------------------------------------
#Author: Lei Chen, Morgan Ziegler
#Date: December 3,2020
#Comp321 project MLinR
#--------------------------------------
#install.packages("caret")
#install.packages("caret", dependencies=c("Depends", "Suggests"))

source("/Users/leianna/Documents/321F20/MLinR/functions.R", chdir = TRUE)
#source("/Users/morganziegler/Desktop/MLinR-main/functions.R")
	
library(caret)
library(readxl)
library(tidyselect)
library(dplyr)
library(readxl)
library(tidyr)
library(tidyselect)
library(magrittr)
library(readr)
library(tidyverse)



data(iris)
dataset <- iris

#get 80% of the data to train the model on
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)

validation <- dataset[-validation_index,]

dataset <- dataset[validation_index,]


print(dim(dataset))
sapply(dataset, class)

#print the first 5 rows of the data to see what it looks like
print(head(dataset))

levels(dataset$Species)
percentage <- prop.table(table(dataset$Species)) * 100
print(cbind(freq=table(dataset$Species), percentage=percentage))

print(summary(dataset))

x <- dataset[,1:4]
y <- dataset[,5]



par(mfrow=c(1,4))

#plot the distribution of the features
for(i in 1:4) {
  boxplot(x[,i], main=names(iris)[i])
}

#plot the distribution of the species
plot(y)


#not runnin yet
print(featurePlot(x, y, "ellipse"))
print(featurePlot(x, y, "box"))
print("done")