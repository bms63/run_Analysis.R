#Introduction

##Welcome to my 1st ever CodeBook!

This codebook is for the Course Project from __Getting and Cleaning Data__ from Coursera.

The __Goal__ of the Course Project was to __Prepare a Tidy Data Set for later anaylsis.*__

I attempted to create a temporary folder for those wishing to run the script.  Sadly, it was proving problematic, but I left the code in anyways.  If you are attempting to investigate the script process, then you will need to download the data manually at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip."  You will need to unzip it and set your working directory
to match the path names.

It was accomplished by doing the following:

##1.  Merges the training and the test sets to create one data set.
-.  Read the following files into R:
-.  activity_labels.txt, features.txt, subject_train.txt, X_train.txt, y_train.txt, subject_test.txt, X_test.txt, y_test.txt
··2.  Merge the X files, Y files and Subject files togther by using rbind	

2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##1.  Merges the training and the test sets to create one data set.

##2.  Extracts only the measurements on the mean and standard deviation for each measurement. 

##3.  Uses descriptive activity names to name the activities in the data set

##4.  Appropriately labels the data set with descriptive variable names. 

##5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

