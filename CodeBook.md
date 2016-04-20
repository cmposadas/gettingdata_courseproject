---
title: "Getting and Cleaning Data Course Project"
author: "Christian Posadas"
date: "April 13, 2016"
output: html_document
---

OVERALL SUMMARY
========================================================
The data set is a transformation of the 'Human Activity Recognition Using Smartphones' Dataset v1.0. 
A description of the original data set is provided where the data set was also obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data set contains a summary of the activities of 30 individuals within the ages of 19 and 48. Each individual performed activities which were recorded by a Samsung Galaxy S II on their waist. The 3-axial linear acceleration and 3-axial angular velocity were recorded using the Galaxy's embedded accelerometer and gyroscope.

Essentially, in this project, the training and test set were combined, where only the mean and standard deviation measurements of each signal were extracted. The data was then summarized by taking the average of each measurement for each activity and subject.


VARIABLE DESCRIPTIONS
========================================================
The time domain signals (prefix 'time') were recorded at a rate of 50Hz. They were then filtered with a corner frequency of 20 Hz to isolate noise.

The acceleration signal was split into body and gravity acceleration signals with a corner frequency of 0.3 Hz. As such, the following variables are provided:

time_BodyAcc-XYZ

time_GravityAcc-XYZ

time_BodyGyro-XYZ

Then, the body linear acceleration and angular velocity were taken to derive the jerk signals:

time_BodyAccJerk-XYZ

time_BodyGyroJerk-XYZ

Using the Euclidean norm, the magnitude were derived for these signals: 

time_BodyAccMag

time_GravityAccMag

time_BodyAccJerkMag

time_BodyGyroMag

time_BodyGyroJerkMag. 

A Fast Fourier Transform (FFT) was then applied providing the following variables (prefix 'freq' to denote frequency domain signals): 

freq_BodyAcc-XYZ

freq_BodyAccJerk-XYZ

freq_BodyAccMag

freq_BodyGyro-XYZ

freq_BodyAccJerkMag

freq_BodyGyroMag

freq_BodyGyroJerkMag

Note: '-XYZ' denotes the signals in the X, Y and Z directions.

Next, the following measurements were peformed on each of the signals:

mean: Mean value

std: Standard deviation

Lastly, each record in this project's data set represents the average of these aforementioned measurements for each subject by activity. The subject and activity features for each record are denoted in the data set by:

subject_id: identifies the subject who performed the exercise.

activity: identifies the activity performed (Walking, walking upstairs, walking downstairs, sitting, standing, laying)


SUMMARY OF UPDATES MADE TO THE ORIGINAL DATA SET
========================================================
1) Combined the training and test data sets into one data set.

2) Appended the subject id labels and activity labels to the merged data set. Also used more descriptive activity labels such as "walking", "walking upstairs, etc. instead of numerical labels.

3) Extracted only the mean and standard deviation measurements for each signal.

4) Cleaned up the variable names to make them more intuitive.

5) Summarized the resulting data set by taking the mean of each measurement for each activity and each subject.
