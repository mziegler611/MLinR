#--------------------------------------
#Author: Lei Chen, Morgan Ziegler
#Date: December 3,2020
#Comp321 project MLinR
#--------------------------------------

source("/Users/morganziegler/Desktop/MLinR-main/functions.R")
#source("/Users/leianna/Documents/321F20/MLinR/functions.R", chdir = TRUE)

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
library(testthat)



timing <-function(dataset, percent){
    
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

timingTest <-function(){
    data(iris)
    dataset <- iris
    print(".3 Percent ", quote = FALSE)
    timing(dataset, .3)
    print(".4 Percent ", quote = FALSE)
    timing(dataset, .4)
    print(".5 Percent ", quote = FALSE)
    timing(dataset, .5)
    print(".8 Percent ", quote = FALSE)
    timing(dataset, .8)
    print(".9 Percent ", quote = FALSE)
    timing(dataset, .9)

}


timingTest()


