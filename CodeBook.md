#CodeBook

 This code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.
 
 Next steps were undertaken to get final result:
 * File "features.txt" was loaded, then data was filtered using regular expression, so that we get the features that interest us (mean and standard deviation), containing *mean()* and *std()*. As a result two lists were formed: 1) good_features_ind - indices of those features; 2) good_features - just list of these features, we need it to set headers.
 * File "activities.txt" was loaded. This file contains activity labels corresponding to their respective indices.
 * Then two directories (test and train) were processed, in both cases same algorithm was used.
     * Subject file was loaded.
     * y-file containing indices of activities for each subject was loaded
     * Next step was to merge the y-file with activities-file by index in order to get labeled each activity index for each measurement. But for some reason merged data always got sorted, even if I used paremeter "sort = FALSE", so that it became impossible to know to which measurement each row of resulting data was corresponding. So several substeps were made:
         * Additional column with row numbers was added to data frame containing activity indices.
         * Then the data was merged by activity indices as was planned.
         * Finally, original order was restored by sorting the merged data by the column with original row numbers; and only column containing activity labels was stored
     * File containing measurements was loaded, and the subset of columns that we are interested in was taken. All columns were named according their respective features.
     * Then the dataframe was formed, containing subject and activity as first two columns, and measurements of features as rest.
     * In the end of processing of each directory, the abovecreated dataframe was aggregated (grouped by) first two columns, and function "mean" was applied to all grouped measurements.
 * Dataframes for both directories was concatenated, ordered by subject, and stored in file "result.csv".
 
 ##Columns of resulting data:
 Due to limitations of csv-format the names of feature-columns are sligthly distorted after being saved.
 1. "X" - automatically added ordinal number of each row
 2. "activity"
 3. "subject"
 4. List af all features (mean of measurements grouped by subject and activity): tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z, tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z, tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z, tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z, tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y, tBodyAccJerk-std()-Z, tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z, tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z, tBodyGyroJerk-mean()-X, tBodyGyroJerk-mean()-Y, tBodyGyroJerk-mean()-Z, tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z, tBodyAccMag-mean(), tBodyAccMag-std(), tGravityAccMag-mean(), tGravityAccMag-std(), tBodyAccJerkMag-mean(), tBodyAccJerkMag-std(), tBodyGyroMag-mean(), tBodyGyroMag-std(), tBodyGyroJerkMag-mean(), tBodyGyroJerkMag-std(), fBodyAcc-mean()-X, fBodyAcc-mean()-Y, fBodyAcc-mean()-Z, fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z, fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z, fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z, fBodyGyro-mean()-X, fBodyGyro-mean()-Y, fBodyGyro-mean()-Z, fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z, fBodyAccMag-mean(), fBodyAccMag-std(), fBodyBodyAccJerkMag-mean(), fBodyBodyAccJerkMag-std(), fBodyBodyGyroMag-mean(), fBodyBodyGyroMag-std(), fBodyBodyGyroJerkMag-mean(), fBodyBodyGyroJerkMag-std()