#Introduction

##Welcome to my 1st ever CodeBook!

This codebook is for the Course Project from __Getting and Cleaning Data__ from Coursera.  

The __Goal__ of the Course Project was to __Prepare a Tidy Data Set for later anaylsis from a Data Set of human activity and smartphones.*__

#Caveat/Assumption
I attempted to create a temporary folder for those wishing to run the script.  Sadly, it was proving problematic, but I left the code in anyways.  If you are attempting to investigate the script process, then you will need to download the data manually at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip."  You will need to unzip it and set your working directory
to match the path names.

#Getting and Cleaning the Data

It was accomplished by doing the following:

##1.  Merging the training and the test sets to create one data set.
- The Script starts by reading the following files into R:
- `activity_labels.txt, features.txt, subject_train.txt, X_train.txt, y_train.txt, subject_test.txt, X_test.txt, y_test.txt`
- Merge the X files, Y files and Subject files togther by using `rbind`	
- In the next steps the X, Y and Subject files will be merged together into one data set called `mean_Std_Dataset`

##2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
-  The script assigns readable names to features table: `Subject and Measurement`
-  Using the `grep function` the scipts takes out any variable name with std dev. or mean in it from the features files
-  Usings the `index_Features`, indexes over the `x-Data` set and finds all the relevant data
-  It then returns a data table with all the mean and standard deviation measurements totaling 10, 299 observations of 66 variables

##3.  Uses descriptive activity names to name the activities in the data set and  appropriately labels the data set with descriptive variable names. 
-  The Script assigns `Subject and Activity` names to the label file
-  The `y-Data` is changed from its integers into its corresponding names
-  `y_Data` and `subject_Data` are given appropriate names
-  Using `cbind` ong the subject, y and x Data tables are merged into `complete_Data_Set`, which is almost a tidy data set

##4.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-  The Script uses function `aggregate` on the `complete_Data_Set` to take the Average of each variable
-  I had to reassign the names to the columns...giving me issues
-  The Data Set is now a Tidy Data Set.
