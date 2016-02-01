setwd("~/projects/coursera/Getting and Cleaning Data/project/tidydataproject/")

library(tidyr)
ifelse(!dir.exists(file.path("./data/")), dir.create(file.path("./data/")), FALSE)

source_data <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(source_data, "./data/data.zip", method = "curl")

unzip("./data/data.zip", exdir = "./data/")

# read data into data frames
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
featureNames <- read.table("./data/UCI HAR Dataset/features.txt")

names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"
names(y_train) <- "activity"
names(y_test) <- "activity"
names(X_train) <- featureNames[[2]]
names(X_test) <- featureNames[[2]]

train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
joined <- rbind(train, test)

keepcol <- grepl("mean", names(joined)) | grepl("std", names(joined))
keepcol[1:2] <- T
joined <- joined[, keepcol]

joined$activity <- factor(joined$activity, labels=c("Walking","Walking Upstairs",
                          "Walking Downstairs", "Sitting", "Standing", "Laying"))


