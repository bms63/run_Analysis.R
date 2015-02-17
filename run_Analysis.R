####################################################################
# Prologue: Checks for directory, UCH dataset and packages
####################################################################

# Checks for the directory the files will downloaded into
if(!file.exists("Course Project")){
  message("Creating Course Project File")
  dir.create("Course_Project")
}

# Checks to see if the Dataset has been downloaded and unzipped
if(!file.exists("UCI_HAR_Dataset")){
  file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile <- "Course_Project/UCI_HAR_Dataset.zip"
  download.file(file_URL, destfile=zipfile)
  unzip(zipfile, exdir="Course_Project")
}

# Checks to see if data.table and dplyr is loaded and if not loads
# and/or installs 
if(!require(data.table)){
  install.packages("data.table")
  library(data.table)
}

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

####################################################################
#Act 1: Merges the training and the test files to create one data set.
####################################################################
#Reads into R the labels and features files
setwd("C:/Users/Owner/Desktop/G&CData/UCI HAR Dataset")
labels <- read.table("activity_labels.txt")
#features_Info <- read.table("features_info.txt")
features <- read.table("features.txt")

#sets the directory for train files
setwd("C:/Users/Owner/Desktop/G&CData/UCI HAR Dataset")
setwd(paste(getwd(),"/train",sep=""))

#reads Train text files into tables
subject_Train <- read.table("subject_train.txt")
x_Train <- read.table("X_train.txt")
y_Train <- read.table("y_train.txt")

#sets directory for test files
setwd("C:/Users/Owner/Desktop/G&CData/UCI HAR Dataset")
setwd(paste(getwd(),"/test",sep=""))

#reads Test text files into tables
subject_Test <- read.table("subject_test.txt")
x_Test <- read.table("X_test.txt")
y_Test <- read.table("y_test.txt")

####################################################################
#Act 1.5 Merges the data files together
####################################################################
# Creates a merged data table of the Train files.
train_Data <- cbind(as.data.table(subject_Train), y_Train, x_Train)

# Creates a merged data table of the Test files.
test_Data <- cbind(as.data.table(subject_Test), y_Test, x_Test)

#binds them all together (Train and Test files) to rule them all
the_Ring <- rbind(train_Data, test_Data)

####################################################################
# Act 2: Extracts only the measurements on the mean and standard 
# deviation for each measurement.
####################################################################

#Assigns names to columns and extracts any matching mean or std in columns
names(features) <- c('Feature_ID', 'Feature_Name')
index_Features <- grep("-mean\\(\\)|-std\\(\\)", features$Feature_Name)
#index_Features_Names <- grep("mean\\(\\)|std\\(\\)", features$Feature_Name, value = TRUE)
mean_Std_Dataset <- select(the_Ring, index_features)

####################################################################
# Act 3: Uses descriptive activity names to name the activities in 
# the data set
####################################################################

####################################################################
# Act 4: Appropriately labels the data set with descriptive variable names. 
####################################################################

####################################################################
# Act 5: From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity and each subject.
####################################################################

