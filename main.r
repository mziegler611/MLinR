#--------------------------------------
#Author: Lei Chen, Morgan Ziegler
#Date: December 3,2020
#Comp321 project MLinR
#--------------------------------------
#install.packages("")
library(readxl)
library(tidyselect)
library(dplyr)
library(readxl)
library(tidyr)
library(tidyselect)
library(magrittr)
library(readr)
library(tidyverse)
#--------------------------------------
#Import table
myData <- read_excel("/Users/leianna/Documents/321F20/MLinR/catsvdogs.xlsx")
list_header<-names(myData)

#--------------------------------------
#print list of headers
printHeader <-function(dataEnter){
  list_header<-names(dataEnter)
  for(val in 1:length(list_header)){
    print(list_header[val])
  }
}
#call the function
printHeader(myData)
#--------------------------------------
#https://rstudio-conf-2020.github.io/r-for-excel/ggplot2.html

#print out line graphs
ggplot(data = myData, aes(x = `Dog Owning Households (1000s)`, y = `Cat Population`)) +
  geom_line(color = "purple",linetype = "dashed")
#print out point graphs, pch is the point shape
ggplot(data = myData, aes(x = `Dog Owning Households (1000s)`, y = `Cat Population`)) +
  geom_point(color = "blue",pch = 18,size = 4, alpha = 0.5)
#print out rectangle graphs
ggplot(data = myData, aes(x = `Dog Owning Households (1000s)`, y = `Cat Population`)) +
  geom_col(aes(fill = `Cat Population`))
