# 0. download file and unzip in local folder, then import the fixed width files
#    (using readr package, MUCH faster)
# 1. merge the datasets (using data.table # functions for faster performance),
#    then extract and filter column names (features)
# 2. select only mean() and std() columns into a new data.table
# 3. add activity names to labels
# 4. clean descriptive column names
# 5. calculate the mean for each variable for each activity and each subject
# 6. export resulting data.table to X_summary.txt

# loads necessary libraries
library(readr)
library(data.table)
library(dplyr)

# 0. download file and unzip in local folder
if (!file.exists("dataset.zip")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    destfile = "dataset.zip", method = "curl"
  )
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(zipfile = "dataset.zip")
}

# import the fixed width files (using readr package, MUCH faster)
subject_test <-
  read_table("./UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
y_test <-
  read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
X_test <-
  read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
X_test <-
  data.table(subject_test, y_test, X_test) # merge subject, label and data tables

subject_train <-
  read_table("./UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
y_train <-
  read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
X_train <-
  read_table("./UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
X_train <-
  data.table(subject_train, y_train, X_train) # merge subject, label and data tables

# 1. merge the test and train datasets (using data.table functions for faster performance)
X_merge <- rbindlist(list(X_test, X_train))

# extract and filter column names (features)
features <-
  read_delim("./UCI HAR Dataset/features.txt", delim = " ", col_names = FALSE)
columns <-
  as.character(unlist(c("subject", "label", features[, 2])))
colnames(X_merge) <- columns

# 2. select only mean() and std() columns into a new data.table
X_merge_meanstd <-
  X_merge[, grep("subject|label|mean\\(\\)|std\\(\\)", columns),
          with = FALSE] # option "with = FALSE" allows for logical vector selection

# 3. add activity names to labels
labels <-
  read_delim("./UCI HAR Dataset/activity_labels.txt", delim = " ", col_names = FALSE)
colnames(labels) <- c("label", "activity")
labels[, "activity"] <- sapply(labels[, "activity"], FUN = tolower)
labels <- as.data.table(labels)
X_merge_meanstd <-
  merge(labels, X_merge_meanstd, by = "label", all.y = TRUE)

# 4. clean descriptive column names
colnames(X_merge_meanstd) <- gsub("\\.", "",          # trim dots
                                  make.names(# removes special characters from column names
                                    colnames(X_merge_meanstd),
                                    unique = TRUE))

# 5. calculate the mean for each variable for each activity and each subject
setkey(X_merge_meanstd, activity, subject)
X_summary <-
  X_merge_meanstd[, lapply(.SD, sum), by = list(activity, subject), .SDcols = 4:69]

# 6. export resulting data.table to X_summary.txt
write.table(X_summary, file = "X_summary.txt", row.name = FALSE)
