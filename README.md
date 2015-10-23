# Getting and Cleaning Data Course Project
Submission for the Course Project for the Getting and Cleaning Data course on Coursera by Johns Hopkins University

## Content of the repository:
#### README.md
#### <a href="https://github.com/paesibassi/GetCleanDataProject/blob/master/run_analysis.R">run_analysis.R</a>:

0. download file and unzip in local folder, then import the fixed width files (using readr package, MUCH faster)
1. merge the datasets (using data.table package for faster performance), and extract and filter column names (features)
2. select only mean() and std() columns into a new data.table
3. add activity names to labels
4. clean descriptive column names
5. calculate the mean for each variable for each activity and each subject
6. export resulting data.table to X_summary.txt

#### <a href="https://github.com/paesibassi/GetCleanDataProject/blob/master/CodeBook.md">CodeBook</a>
#### <a href="https://github.com/paesibassi/GetCleanDataProject/blob/master/X_summary.txt">X_summary</a> data file
