# Getting and Cleaning Data Course Project
Submission for the Course Project for the Getting and Cleaning Data course on Coursera by Johns Hopkins University.

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:
> 1) a tidy data set as described below,
> 2) a link to a Github repository with your script for performing the analysis, and
> 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## Content of the repository:
#### README.md
This file.

#### [run_analysis.R](https://github.com/paesibassi/GetCleanDataProject/blob/master/run_analysis.R)
The script will download and unzip the data folder (if it doesn't exist already), then will select the relevant columns (only mean() and std()) and finally perform the requested aggregations, exporting the results into space delimited *X_summary.txt*.  
Hereby the steps of the code in the script:

0. download file and unzip in local folder, then import the fixed width files (using readr package, MUCH faster)
1. merge the datasets (using data.table functions for faster performance), then extract and filter column names (features)
2. select only mean() and std() columns into a new data.table
3. add activity names to labels
4. clean descriptive column names
5. calculate the mean for each variable for each activity and each subject
6. export resulting data.table to X_summary.txt

#### [CodeBook.md](https://github.com/paesibassi/GetCleanDataProject/blob/master/CodeBook.md)
The codebook explaining the data manipulation steps and resulting variables.

#### [X_summary.txt](https://github.com/paesibassi/GetCleanDataProject/blob/master/X_summary.txt)
Exported resulting dataset (wide format, one variable per column), space separated values format.
