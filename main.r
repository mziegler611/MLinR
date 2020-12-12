#--------------------------------------
#Author: Lei Chen, Morgan Ziegler
#Date: December 3,2020
#Comp321 project MLinR
#--------------------------------------
#install.packages("caret")
#install.packages("caret", dependencies=c("Depends", "Suggests"))

#source("/Users/leianna/Documents/321F20/MLinR/functions.R", chdir = TRUE)
source("/Users/morganziegler/Desktop/MLinR-main/functions.R")
	
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
validation_index <- getValidationIndex(dataset, .80)

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


#feature plots for the features according to species
print(featurePlot(x, y, "ellipse"))
print(featurePlot(x, y, "box"))

#differnce in distribution of each feature by species
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)




# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)

# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
print(summary(results))

# compare accuracy of models
print(dotplot(results))

print(fit.lda)

# estimate skill of LDA on the validation dataset
predictions <- predict(fit.lda, validation)
print("Confusion Matrix")
print(confusionMatrix(predictions, validation$Species))
