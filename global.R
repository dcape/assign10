#Model
library(xgboost)
library(tidyverse)

Iris <- iris

y1 <- Iris$Species
var.levels <- levels(y1)
y = as.integer(y1) - 1


noOutcome <- Iris[,-5]
x = noOutcome[,c('Sepal.Width', 'Sepal.Length', 'Petal.Width', 'Petal.Length')]
var.names <- names(x)
x = as.matrix(x)

params <- list(
  "objective" = "multi:softprob"
  ,"eval_metric" = "mlogloss"
  ,"num_class" = length(table(y))
  ,"eta" = .25
  ,"max_depth" = 3
  ,"nthread" = 8
)

cv.nround = 17

bst.cv <- xgb.cv(param = params, data = x, label = y
                 , nfold = 5, nrounds = cv.nround
                 , missing = NA, prediction = TRUE
)

nrounds = which.min(bst.cv$evaluation_log$test_mlogloss_mean)
bst.cv$evaluation_log[nrounds,]


IrisSpecies <- xgboost(param = params, data = x, label = y
                       ,nrounds = nrounds, missing = NA)


xgb.importance(var.names, model = IrisSpecies)

xgb.save(IrisSpecies, "iris.model")

IrisSpeciesInfo <- list(
  var.names = var.names
  ,var.levels = var.levels
)

save(IrisSpeciesInfo, file = 'IrisSpeciesInfo.rda')





#Global proper

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
