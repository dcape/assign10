library(xgboost)
library(tidyverse)
library(shiny)
library(DT)
library(ggplot2)


Iris <- xgb.load("iris.model")
load("IrisSpeciesInfo.rda")


generatePreds <- function(
  Petal.Width = 1, Petal.Length = 3.5
  , Sepal.Width = 3, Sepal.Length = 6){
  
  testDF <- as.matrix(
    Petal.Width, Petal.Length, Sepal.Width, Sepal.Length 
  )
  
  preds <- predict(IrisSpecies, testDF)
  
  data.frame(
    Species = IrisSpeciesInfo$var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
  
}
