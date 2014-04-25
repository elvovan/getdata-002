# Peer assessment for the Coursera course "Getting and cleaning data"

This repository contains the script run_analysis.R that prepares tidy data that can be used for later analysis. Ths script works with data collected from the accelerometers from the Samsung Galaxy S smartphone, that can be obtained by next link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

What this script does (according to the given task, but not in the given order):
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Working directory for this script should be the directory containing the directory with samsung data "UCI HAR Dataset", but not "UCI HAR Dataset" itself. Just run the script without any arguments and wait until it finishes its work. As a result of running this script, the file named "result.csv" must appear in the current working directory.