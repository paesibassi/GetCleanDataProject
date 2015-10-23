# One of the most exciting areas in all of data science right now is wearable
# computing - see for example this article . Companies like Fitbit, Nike, and
# Jawbone Up are racing to develop the most advanced algorithms to attract new
# users. The data linked to from the course website represent data collected
# from the accelerometers from the Samsung Galaxy S smartphone. A full
# description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(readr)
library(data.table)
library(dplyr)

# 0. download file and unzip in local folder
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "dataset.zip", method = "curl")
unzip(zipfile = "dataset.zip")

# import the fixed width files (using readr package, MUCH faster)
subject_test <- read_table("./UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
y_test <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
X_test <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
X_test <- data.table(subject_test, y_test, X_test) # merge subject, label and data tables

subject_train <- read_table("./UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
y_train <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
X_train <- read_table("./UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
X_train <- data.table(subject_train, y_train, X_train) # merge subject, label and data tables

# 1. merge the datasets (using data.table package for faster performance)
X_merge <- rbindlist(list(X_test, X_train))

# extract and filter column names (features)
features <- read_delim("./UCI HAR Dataset/features.txt", delim = " ", col_names = FALSE)
columns <- as.character(unlist(c("subject", "label", features[, 2])))
colnames(X_merge) <- columns

# 2. select only mean() and std() columns into a new data.table
X_merge_meanstd <- X_merge[, grep("subject|label|mean\\(\\)|std\\(\\)", columns),
                           with = FALSE] # option "with = FALSE" allows for logical vector selection

# 3. add activity names to labels
labels <- as.data.table(read_delim("./UCI HAR Dataset/activity_labels.txt", delim = " ", col_names = FALSE))
colnames(labels) <- c("label", "activity")
X_merge_meanstd <- merge(labels, X_merge_meanstd, by = "label", all.y = TRUE)

# 4. clean descriptive column names
colnames(X_merge_meanstd) <- gsub("\\.", "", # trim dots
                                  make.names( # removes special characters from column names
                                    colnames(X_merge_meanstd),
                                    unique = TRUE
                                    )
                                  )

# 5. calculate the mean for each variable for each activity and each subject
setkey(X_merge_meanstd, activity, subject)
X_summary <- X_merge_meanstd[, lapply(.SD, sum), by = list(activity, subject), .SDcols = 4:69]

# 6. export resulting data.table to X_summary.txt
write.table(X_summary, file = "X_summary.txt", row.name=FALSE)
