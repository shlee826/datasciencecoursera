---
title: "run_analysis.R"
output: html_document
date: "2022-12-23"
---

```{r}
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```

```{r}
library(dplyr)
setwd("C:/Users/sinhe/Desktop/Course/UCI HAR Dataset")
```

```{r}
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("n", "functions"))
subject_test <- read.table("test/subject_test.txt", col.names = c("subjects"))
x_test <- read.table("test/X_test.txt", col.names = features$functions)
y_test <- read.table("test/Y_test.txt", col.names = c("code"))
subject_train <- read.table("train/subject_train.txt", col.names = c("subjects"))
x_train <- read.table("train/X_train.txt", col.names = features$functions)
y_train <- read.table("train/Y_train.txt", col.names = c("code"))
```

Step 1: Merges the training and the test sets to create one data set.
```{r}
X <- rbind(x_test, x_train)
Y <- rbind(y_test, y_train)
Subject <- rbind(subject_test, subject_train)
Merged_Data <- cbind(X, Y, Subject)
```

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
```{r}
Mean_SD_Extract <- Merged_Data %>% select(subjects, code, contains("mean"), contains("std"))
```

Step 3: Uses descriptive activity names to name the activities in the data set
```{r}
colnames(Mean_SD_Extract)[2] <- "Activity"
```

Step 4: Appropriately labels the data set with descriptive variable names. 
```{r}
names(Mean_SD_Extract) <- gsub("ACC", "Accelerometer", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("gravity", "Gravity", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("Gyro", "Gyroscope", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("Mag", "Magnitute", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("BodyBody", "Body", names(Mean_SD_Extract)) 
names(Mean_SD_Extract) <- gsub("^t", "Time", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("^f", "Frequency", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("tBody", "TimeBody", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("angle", "Angle", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("-std", "std", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("-freq()", "Frequency", names(Mean_SD_Extract))
names(Mean_SD_Extract) <- gsub("-mean()", "Mean", names(Mean_SD_Extract))
```

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```{r}
Final_Data <- Mean_SD_Extract %>% group_by(Activity, subjects) %>% summarise_all(funs(mean))
write.table(Final_Data, "Final Data.txt", row.names = F)
```


