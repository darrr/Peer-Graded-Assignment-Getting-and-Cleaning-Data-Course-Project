# Peer-Graded-Assignment-Getting-and-Cleaning-Data-Course-Project Code Book

This code book modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.

After, the run_analysis.R script performs the following steps to clean the data:

3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.

Then:

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. and writes it into tidy_result.txt.
