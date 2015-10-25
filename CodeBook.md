# Codebook

## Introduction
One of the most exciting areas in all of data science right now is wearable
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and
Jawbone Up are racing to develop the most advanced algorithms to attract new
users.

## Dataset information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen [here](http://www.youtube.com/watch?v=XOEN9W05_4A).

The original dataset of the experiment results can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Goal of the course assignment
Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Selects only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R script and data manipulation
### run_analysis.R:
This script will download and unpack the data folder (if it doesn't exist already), then will select the relevant columns and perform the requested aggregations, exporting the resulting X_summary.txt dataset file.
Hereby the processing steps:

0. download file and unzip in local folder, then import the fixed width files (using readr package, MUCH faster)
1. merge the datasets (using data.table functions for faster performance), then extract and filter column names (features)
2. select only mean() and std() columns into a new data.table
3. add activity names to labels
4. clean descriptive column names
5. calculate the mean for each variable for each activity and each subject
6. export resulting data.table to X_summary.txt

## Variable Descriptions

#### Activity labels
- walking
- walking_upstairs
- walking_downstairs
- sitting
- standing
- laying

Observations from the original dataset have been averaged for each activity and subject.

| Column | Variable | Description |
|--------|-------------|-----------------------------------------------------------------------|
| 1. | activity | Type of activity |
| 2. | subject | Subject ID, in the range 1 - 30. |
| 3. | tBodyAccmeanX | Mean time for acceleration of body for X direction |
| 4. | tBodyAccmeanY | Mean time for acceleration of body for Y direction |
| 5. | tBodyAccmeanZ | Mean time for acceleration of body for Z direction |
| 6. | tBodyAccstdX | Standard deviation of time for acceleration of body for X direction |
| 7. | tBodyAccstdY | Standard deviation of time for acceleration of body for Y direction |
| 8. | tBodyAccstdZ | Standard deviation of time for acceleration of body for Z direction |
| 9. | tGravityAccmeanX | Mean time of acceleration of gravity for X direction |
| 10. | tGravityAccmeanY | Mean time of acceleration of gravity for Y direction |
| 11. | tGravityAccmeanZ | Mean time of acceleration of gravity for Z direction |
| 12. | tGravityAccstdX | Standard deviation of time of acceleration of gravity for X direction |
| 13. | tGravityAccstdY | Standard deviation of time of acceleration of gravity for Y direction |
| 14. | tGravityAccstdZ | Standard deviation of time of acceleration of gravity for Z direction |
| 15. | tBodyAccJerkmeanX | Mean time of body acceleration jerk for X direction |
| 16. | tBodyAccJerkmeanY | Mean time of body acceleration jerk for Y direction |
| 17. | tBodyAccJerkmeanZ | Mean time of body acceleration jerk for Z direction |
| 18. | tBodyAccJerkstdX | Standard deviation of time of body acceleration jerk for X direction |
| 19. | tBodyAccJerkstdY | Standard deviation of time of body acceleration jerk for Y direction |
| 20. | tBodyAccJerkstdZ | Standard deviation of time of body acceleration jerk for Z direction |
| 21. | tBodyGyromeanX | Mean body gyroscope measurement for X direction |
| 22. | tBodyGyromeanY | Mean body gyroscope measurement for Y direction |
| 23. | tBodyGyromeanZ | Mean body gyroscope measurement for Z direction |
| 24. | tBodyGyrostdX | Standard deviation of body gyroscope measurement for X direction |
| 25. | tBodyGyrostdY | Standard deviation of body gyroscope measurement for Y direction |
| 26. | tBodyGyrostdZ | Standard deviation of body gyroscope measurement for Z direction |
| 27. | tBodyGyroJerkmeanX | Mean jerk signal of body for X direction |
| 28. | tBodyGyroJerkmeanY | Mean jerk signal of body for Y direction |
| 29. | tBodyGyroJerkmeanZ | Mean jerk signal of body for Z direction |
| 30. | tBodyGyroJerkstdX | Standard deviation of jerk signal of body for X direction |
| 31. | tBodyGyroJerkstdY | Standard deviation of jerk signal of body for Y direction |
| 32. | tBodyGyroJerkstdZ | Standard deviation of jerk signal of body for Z direction |
| 33. | tBodyAccMagmean | Mean magnitude of body Acc |
| 34. | tBodyAccMagstd | Standard deviation of magnitude of body Acc |
| 35. | tGravityAccMagmean | Mean gravity acceleration magnitude |
| 36. | tGravityAccMagstd | Standard deviation of gravity acceleration magnitude |
| 37. | tBodyAccJerkMagmean | Mean magnitude of body acceleration jerk |
| 38. | tBodyAccJerkMagstd | Standard deviation of magnitude of body acceleration jerk |
| 39. | tBodyGyroMagmean | Mean magnitude of body gyroscope measurement |
| 40. | tBodyGyroMagstd | Standard deviation of magnitude of body gyroscope measurement |
| 41. | tBodyGyroJerkMagmean | Mean magnitude of body body gyroscope jerk measurement |
| 42. | tBodyGyroJerkMagstd | Standard deviation of magnitude of body body gyroscope jerk measurement |
| 43. | fBodyAccmeanX | Mean frequency of body acceleration for X direction |
| 44. | fBodyAccmeanY | Mean frequency of body acceleration for Y direction |
| 45. | fBodyAccmeanZ | Mean frequency of body acceleration for Z direction |
| 46. | fBodyAccstdX | Standard deviation of frequency of body acceleration for X direction |
| 47. | fBodyAccstdY | Standard deviation of frequency of body acceleration for Y direction |
| 48. | fBodyAccstdZ | Standard deviation of frequency of body acceleration for Z direction |
| 49. | fBodyAccJerkmeanX | Mean frequency of body accerlation jerk for X direction |
| 50. | fBodyAccJerkmeanY | Mean frequency of body accerlation jerk for Y direction |
| 51. | fBodyAccJerkmeanZ | Mean frequency of body accerlation jerk for Z direction |
| 52. | fBodyAccJerkstdX | Standard deviation frequency of body accerlation jerk for X direction |
| 53. | fBodyAccJerkstdY | Standard deviation frequency of body accerlation jerk for Y direction |
| 54. | fBodyAccJerkstdZ | Standard deviation frequency of body accerlation jerk for Z direction |
| 55. | fBodyGyromeanX | Mean frequency of body gyroscope measurement for X direction |
| 56. | fBodyGyromeanY | Mean frequency of body gyroscope measurement for Y direction |
| 57. | fBodyGyromeanZ | Mean frequency of body gyroscope measurement for Z direction |
| 58. | fBodyGyrostdX | Standard deviation frequency of body gyroscope measurement for X direction |
| 59. | fBodyGyrostdY | Standard deviation frequency of body gyroscope measurement for Y direction |
| 60. | fBodyGyrostdZ | Standard deviation frequency of body gyroscope measurement for Z direction |
| 61. | fBodyAccMagmean | Mean frequency of body acceleration magnitude |
| 62. | fBodyAccMagstd | Standard deviation of frequency of body acceleration magnitude |
| 63. | fBodyBodyAccJerkMagmean | Mean frequency of body acceleration jerk magnitude |
| 64. | fBodyBodyAccJerkMagstd | Standard deviation of frequency of body acceleration jerk magnitude |
| 65. | fBodyBodyGyroMagmean | Mean frequency of magnitude of body gyroscope measurement |
| 66. | fBodyBodyGyroMagstd | Standard deviation of frequency of magnitude of body gyroscope measurement |
| 67. | fBodyBodyGyroJerkMagmean | Mean frequency of magnitude of body gyroscope jerk measurement |
| 68. | fBodyBodyGyroJerkMagstd | Standard deviation frequency of magnitude of body gyroscope jerk measurement |
