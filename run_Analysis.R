#The following script is designed to take a messy collection of data from smartphone 
#devices and make it into a clean and readable tidy data set.  The data was collected 
#from smartphones that were on 30 human subjects who were performing six daily activities
#(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).'  The data
#can be manually downloaded along with other information at the following address:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####################################################################
# CHECKS: Checks for directory, UCH dataset and packages
####################################################################

# Checks for the directory the files will downloaded into
if(!file.exists("Temp_Project")){
  message("Creating Temp_Project File")
  dir.create("Temp_Project")
}
# Checks to see if the Dataset has been downloaded and unzipped
if(!file.exists("Temp_Project/UCI HAR Dataset")){
  file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile <- "Temp_Project/UCI HAR Dataset.zip"
  download.file(file_URL, destfile=zipfile)
  unzip(zipfile, exdir="Temp Project")
}
# Checks to see if data.table and dplyr are loaded and if not loads
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
#STEP 1: Merges the training and the test files to create one data set.
####################################################################
#Reads into R the labels and features files
labels <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/activity_labels.txt")
#features_Info <- read.table("features_info.txt")
features <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/features.txt")

#reads Train text files into tables
subject_Train <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_Train <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_Train <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/train/y_train.txt", header = FALSE)

#reads Test text files into tables
subject_Test <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_Test <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_Test <- read.table("C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/test/y_test.txt", header = FALSE)

####################################################################
#STEP 1.5 Merges the data files together
####################################################################
# Creates a merged data table of the X files.
x_Data <- rbind(x_Train, x_Test)

# Creates a merged data table of the Y files.
y_Data <- rbind(y_Train, y_Test)

# Creates a merged data table of the subject files
subject_Data <- rbind(subject_Train, subject_Test)

# names(y-Data) <- "Activities"
# full_Merge <- cbind(subject_Data, y_Data, x_Data, ??)

####################################################################
# STEP 2: Extracts only the measurements on the mean and standard 
# deviation for each measurement.
####################################################################

#Assigns readable names to columns 
names(features) <- c('Subject', 'Activity')
#Extracts any matching mean or std in features table
index_Features <- grep("-mean\\(\\)|-std\\(\\)", features$Feature_Name)
#Pulls out relevant Data based on indices of features
mean_Std_Dataset <- x_Data[ , index_Features]
View(mean_Std_Dataset)

####################################################################
# STEP 3: Uses descriptive activity names to name the activities in 
# the data set and Appropriately labels the data set with descriptive 
# variable names. 
####################################################################
names(labels) <- c('Subject', 'Activity')
y-Data[, 1] = labels[y_Data[, 1], 2]

#Assigns Names to columns of y and subject Data
names(y_Data) <- "Activity"
names(subject_Data) <- "Subject"

# Combines data table by columns
complete_Data_Set <- cbind(subject_Data, y_Data, x_Data)
#View(complete_Data_Set)

# Changes the variables V1, V2, V3...to their corresposing name provided in
# features file
colnames(complete_Data_Set) <- c("Subject","Activity",as.vector(features[,2]))

#Changes the integer to the word associated with the integer
complete_Data_Set$Activity[complete_Data_Set$Activity == 1] = "WALKING"
complete_Data_Set$Activity[complete_Data_Set$Activity == 2] = "WALKING_UPSTAIRS"
complete_Data_Set$Activity[complete_Data_Set$Activity == 3] = "WALKING_DOWNSTAIRS"
complete_Data_Set$Activity[complete_Data_Set$Activity == 4] = "SITTING"
complete_Data_Set$Activity[complete_Data_Set$Activity == 5] = "STANDING"
complete_Data_Set$Activity[complete_Data_Set$Activity == 6] = "LAYING"

View(complete_Data_Set)
####################################################################
# STEP 4: From the data set created in STEP 3 create a second, independent 
# tidy data set with the average of each variable for each activity and 
# each subject.
####################################################################

# Takes appropriate section of complete Data Set
reset_Data_Set <- complete_Data_Set[, 3:dim(complete_Data_Set)[2]]
# Takes the average of each variable and puts it into a new table
avg_Tidy_Data_Set <- aggregate(reset_Data_Set, list(complete_Data_Set$Subject, complete_Data_Set$Activity), mean)
View(avg_Tidy_Data_Set)
# Assigns Variable names to the first two columns
names(avg_Tidy_Data_Set)[1] <- "Subject"
names(avg_Tidy_Data_Set)[2] <- "Activity"

View(avg_Tidy_Data_Set)

# Writes tidy data set as a file into directory
write.csv(avg_Tidy_Data_Set, "C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/UCI HAR Tidy Data Set.csv", row.names = FALSE)

write.table(avg_Tidy_Data_Set, "C:/Users/Owner/Documents/Temp_Project/UCI HAR Dataset/UCI HAR Tidy Data Set.txt", row.names = FALSE)

