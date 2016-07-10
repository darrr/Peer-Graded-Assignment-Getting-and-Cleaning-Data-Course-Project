### run_analysis.R does the following:

### 1. Merges the training and the test sets to create one data set.

trainSet<-read.table("./peergradedassignment/UCIHARDataset/train/X_train.txt")
trainLabel<-read.table("./peergradedassignment/UCIHARDataset/train/y_train.txt")
trainSubject<-read.table("./peergradedassignment/UCIHARDataset/train/subject_train.txt")

testSet<-read.table("./peergradedassignment/UCIHARDataset/test/X_test.txt")
testLabel<-read.table("./peergradedassignment/UCIHARDataset/test/y_test.txt")
testSubject<-read.table("./peergradedassignment/UCIHARDataset/test/subject_test.txt")

mergedSets<-rbind(trainSet,testSet)
mergedLabels<-rbind(trainLabel,testLabel)
mergedSubjects<-rbind(trainSubject,testSubject)

### 2.Extracts only the measurements on the mean and standard deviation for each measurement

features<-read.table("./peergradedassignment/UCIHARDataset/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
mergedSets <- mergedSets[, meanStdIndices]

### 3.Uses descriptive activity names to name the activities in the data set

activity<-read.table("./peergradedassignment/UCIHARDataset/activity_labels.txt")
activity[,2]<-tolower(gsub("_"," ",activity[,2]))
activityLabel <- activity[mergedLabels[, 1], 2]
mergedLabels[,1]<-activityLabel
names(mergedLabels) <- "activity"

### 4. Appropriately labels the data set with descriptive variable names.

names(mergedSets) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(mergedSets) <- gsub("mean", "Mean", names(mergedSets)) # capitalize M
names(mergedSets) <- gsub("std", "Std", names(mergedSets)) # capitalize S
names(mergedSets) <- gsub("-", "", names(mergedSets)) # remove "-" in column names 

names(mergedSubjects) <- "subject"
cleanedData <- cbind(mergedSubjects,mergedLabels,mergedSets)

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subjectLen <- length(table(mergedSubjects)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(mergedSubjects)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}

head(result)
write.table(result, "tidy_result.txt")

