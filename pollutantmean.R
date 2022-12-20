---
title: "Air Pollution Assignment"
output: html_document
date: "2022-12-20"
---

pollutantmean <- function(directory, pollutant, id = 1:332) {
  directory <- setwd("C:/Users/sinhe/Desktop/Course/specdata")
  file_list <- list.files(directory)
  data <- NA
  
  for(x in id) {
    file_dir <- paste(file_list[x], sep="")
    file_data <- read.csv(file_dir)
    data <- rbind(data, file_data)
  }
  
  mean(data[[pollutant]],na.rm = TRUE)
}


#Test for pollutantmean
pollutantmean("specdata", "nitrate")


