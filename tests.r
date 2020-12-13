#--------------------------------------
#Author: Lei Chen, Morgan Ziegler
#Date: December 3,2020
#Comp321 project MLinR
#--------------------------------------

source("/Users/morganziegler/Desktop/MLinR-main/functions.R")

#devtools::install_github("collectivemedia/tictoc")

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
library(tictoc)

timing <-function(percent){
    
    tic("Training:")
    validation_index <- getValidationIndex(dataset, percent)
    validation <- dataset[-validation_index,]
    dataset <- dataset[validation_index,]

    sapply(dataset, class)
    levels(dataset$Species)
    control <- trainControl(method="cv", number=10)
    metric <- "Accuracy"
    set.seed(7)
    print(" ", quote = FALSE)
    
    fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
    toc()
    print(" ", quote = FALSE)
    #print(fit.lda)
   
    
}
data(iris)
dataset <- iris

print(".8 Percent ", quote = FALSE)
timing(.8)
print(".9 Percent ", quote = FALSE)
timing(.9)
print(".5 Percent ", quote = FALSE)
timing(.5)
print("1 Percent ", quote = FALSE)
timing(1)

