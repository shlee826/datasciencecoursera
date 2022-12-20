---
title: "Air Pollution Assignment"
output: html_document
date: "2022-12-20"
---

complete <- function(directory, id = 1:332) {
  directory = setwd("C:/Users/sinhe/Desktop/Course/specdata")
  file_list <- list.files(directory)
  ids <- vector()
  nobs <- vector()
  
  for(x in id) {
    file_dir <- paste(file_list[x], sep="")
    file_data <- read.csv(file_dir)
    
    ids = c(ids, x)
    nobs = c(nobs, sum(complete.cases(file_data)))
  }
  
  data.frame(id = ids, nobs = nobs)
  
}


#Test
complete("specdata", c(2, 4, 8, 10, 12))
