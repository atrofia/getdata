# You should create one R script called run_analysis.R that does the following. 
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for 
#       each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject.

# Order of steps 1 and 2 are swapped

# cleare the workspace
rm(list=ls())

# set working directory to the location where the UCI HAR Dataset files are
setwd("/Users/atrofia/Data_Science/Getting_and_clearing _data/UCI HAR Dataset")

## Step 2: Extracts only the measurements on the mean and standard deviation for 
## each measurement.
features <- read.table("features.txt")
head(features)   # two variables
str(features)    # interesting variable is a factor
features[,2] <- as.character(features[,2])  # save factor as character for searching purposes

features_extract <- grep(".*mean.*|.*std.*", features[,2])   # search for mean and std. dev.
features_extract_names <- features[features_extract,2]
features_extract_names <- gsub('-mean', 'Mean', features_extract_names) # tyding - nice name
features_extract_names <- gsub('-std', 'Std', features_extract_names)   # tyding - nice name
features_extract_names <- gsub('[-()]', '', features_extract_names)     # tyding - removing brackets

## Step 1: Merge the training and test sets to create one data set
# Load the datasets: training and test
train <- read.table("train/X_train.txt")[features_extract]
train_activities <- read.table("train/Y_train.txt")
train_subjects <- read.table("train/subject_train.txt")
# cbind subjects and their activities into one training dataset
train <- cbind(train_subjects, train_activities, train) 

test <- read.table("test/X_test.txt")[features_extract]
test_activities <- read.table("test/Y_test.txt")
test_subjects <- read.table("test/subject_test.txt")
# cbind subjects and their activities into one test dataset
test <- cbind(test_subjects, test_activities, test)  

# Merge both datasets into one
big_data_set <- rbind(train, test)

## Step 3: Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
head(activity_labels)  # two variables
str(activity_labels)   # interesting variable is a factor
activity_labels[,2] <- as.character(activity_labels[,2]) 

## Step 4: Appropriately labels the data set with descriptive variable names. 
# Add labels to columns for subjects and activity
colnames(big_data_set) <- c("subject", "activity", features_extract_names)
str(big_data_set[,1:3])    # two first columns are integers

# Change class of variables subject and activity into factors, give them labels if needed
big_data_set$activity <- factor(big_data_set$activity, levels = activity_labels[,1], labels = activity_labels[,2])
big_data_set$subject <- as.factor(big_data_set$subject)

## Step 5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
# load reshape package
library(reshape2)

big_data_set_melt <- melt(big_data_set, id = c("subject", "activity"))
big_data_set_mean <- dcast(big_data_set_melt, subject + activity ~ variable, mean)

# create a tidy data set
write.table(big_data_set_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
