---
title: "Air Pollution Assignment"
output: html_document
date: "2022-12-20"
---

corr <- function(directory, threshold = 0) {
  directory <- setwd("C:/Users/sinhe/Desktop/Course/specdata")
  file_list <- list.files(directory)
  obvs <- complete(directory)
  filter_obvs = subset(obvs, obvs$nobs > threshold)
  corr <- vector()
  
  for(x in filter_obvs$id) {
    file_dir <- paste(file_list[x], sep="")
    file_data <- read.csv(file_dir)
    file_data <- subset(file_data, complete.cases(file_data))
    corr <- c(corr, cor(file_data$nitrate, file_data$sulfate))
  }
  
  corr
}


#Test
cr <- corr("specdata", 400)
head(cr)


