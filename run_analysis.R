#Peer assessment for the Coursera course "Getting and cleaning data"

#This script  prepares tidy data that can be used for later analysis.
#It works with data collected from the accelerometers from the Samsung Galaxy S smartphone,
#that can be obtained by next link
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#What this script does (according to the given task, but not in the given order):
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names. 
#Creates a second, independent tidy data set with the average of each variable for 
# each activity and each subject. 

#Working dir for this script should be the directory containing the directory with
# samsung data "UCI HAR Dataset", but not "UCI HAR Dataset" itself.
#As a result of running this script, the file named "result.csv" must appear in
# the current working directory.

#global variables

#filename of the file containing list of features
features_file <- NULL
#loaded dataframe containing list of features
features <- NULL
#indices og the features that we need
#containing either "mean()" or "std()" in our case
good_features_ind <- NULL
#list of "good features", we need it in order to set headers
good_features <- NULL
#filename of the file containing list of activities
activities_file <- NULL
#loaded dataframe with activities
activities <- NULL

#initializes and loads global variables
load_features_activities <- function()
{
  #setting the name of the features file and loading it
  features_file <<- "UCI HAR Dataset/features.txt"
  features <<- read.table(features_file, stringsAsFactors = FALSE)
  
  #getting the features that we need with the help of regular expression
  #vector of indices
  good_features_ind <<- grep("mean\\(\\)|std\\(\\)", features[,2])
  #and vector of good features
  good_features <<- features[good_features_ind, 2] 
  
  #now loading activities
  activities_file <<- "UCI HAR Dataset/activity_labels.txt"
  activities <<- read.table( activities_file, stringsAsFactors = FALSE) 
}

#loads data of one folder and creates dataframe according to requirements of the task
#the only argument "folder" is either "test" or "train" in our case
load_folder <- function( folder )
{
  #loading and creating list of subjects
  subj_file <- sprintf("UCI HAR Dataset/%s/subject_%s.txt", folder, folder)
  subjects <- read.table(subj_file)
  names(subjects) <- "subject"
  
  #loading the y-file, list of activities indices
  y_file <- sprintf("UCI HAR Dataset/%s/y_%s.txt",folder, folder)
  y_data <- read.table(y_file)
  
  #next step is to get list of activities labels
  #I use "merge" to juxtapose labels of dataframe "activities" with indices of "y_data"
  #but for some reason, the result is always get sorted, even if I use "sort = FALSE"
  #so, at first I enumerate all indices, then merge data,
  #then sort result according to initial enumeration
  
  #enumerating indices
  activities_numbered <- data.frame( y_data, num = c(1:length(y_data[,1])))
  #merging indices with labels
  activities_lnum <- merge( activities_numbered, activities, by.x = "V1", by.y = "V1", sort = FALSE)
  #reodering back, selecting only labels (3rd column)
  activities_labels <- activities_lnum[order(activities_lnum$num), 3]
  names(activities_labels) <- "activities"
  
  #setting name of the x-file, containing measurements
  x_file <- sprintf("UCI HAR Dataset/%s/X_%s.txt", folder, folder)
  #loading file and subsetting columns so that we have only those that we need
  x_data <- read.table(x_file)[, good_features_ind]
  #naming columns
  names(x_data) <- good_features
  
  #creating data frame of data extracted from all files in current folder
  data_frame <- data.frame( subject = subjects, activities = activities_labels, x_data )
  
  #data in columns 3:68 (selected features) is grouped by columns 2 and 1 (subject and activity)
  #then function "mean" is applied to all the groups
  #so that we have mean of ecach activity of each subject
  aggregate( data_frame[3:68], data_frame[c(2,1)], mean )
}

run_analysis <- function()
{
  #initializing global vars
  load_features_activities()
  #folders to process
  folders <- c("test","train")
  
  #here will be stored the final result
  result <- data.frame()
  
  #processing each folder
  for( folder in folders)
  {
    #appending the result of current folder to overall result
    result <- rbind( result, load_folder( folder ) )
  }
  #sorting the result by subject
  result <- result[order(result$subject),]
  row.names(result) <- 1:length(result$subject)
  #storing result in file "result.csv"
  write.csv(result, "result.csv")
  #returnin result
  #result
}