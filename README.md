# getdata
# Getting and Cleaning Data - Course Project

This is repository created for the course project for the Data Science's track course "Getting and Cleaning data" available in coursera.

## Data Source
The dataset used here is: [Human Activity Recognition Using Smartphones] available on (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files
This repository contains the following files:
- `run_analysis.R`– contains all the code to perform the analyses described in the 5 steps specified in the project instructions (below).
- `Code_book.md` – the code book for the resulting dataset, indicates all the variables and summaries calculated, along with units, and any other relevant information

## Package dependencies:

- `reshape2`

## Project instructions:
The R script, `run_analysis.R`, does the following:
    
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The end result is shown in the file `tidy.txt`.
