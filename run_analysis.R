###Stage one, read in data
# Read training data
trainingData <- read.table("./data/train/X_train.txt")
trainingLabels <- read.table("./data/train/y_train.txt")
trainingSubjects <- read.table("./data/train/subject_train.txt")

# Read test data
testData <- read.table("./data/test/X_test.txt")
testLabels <- read.table("./data/test/y_test.txt")
testSubjects <- read.table("./data/test/subject_test.txt")

### Stage two, merge the data
allData <- rbind(trainingData,testData)
allLabels <- rbind(trainingLabels,testLabels)
allSubjects <- rbind(trainingSubjects,testSubjects)

### Stage three, extract mean and SD data for each measurement
dataFeatures <- read.table("./data/features.txt")
sdmean <- grep("mean\\(\\)|std\\(\\)",dataFeatures[,2], ignore.case = F)
requiredData <- allData[,sdmean]

### Stage four, import names from dataFeatures and re-format to be easier to read
colnames(requiredData) <- dataFeatures[sdmean,2]
colnames(requiredData) <- gsub("-","",colnames(requiredData))
colnames(requiredData) <- gsub("mean","Mean",colnames(requiredData))
colnames(requiredData) <- gsub("std","STD",colnames(requiredData))
colnames(requiredData) <- gsub("\\(\\)","",colnames(requiredData))
colnames(requiredData) <- gsub("BodyBody","Body",colnames(requiredData))

### Stage five, Read in activity labels, re format and use to update allLabels
activityLabels <- read.table("./data/activity_labels.txt")
activityLabels[,2] <- gsub("_","",activityLabels[,2])
activityLabels[,2] <- tolower(activityLabels[,2])
substr(activityLabels[c(2,3),2],8,8) <- toupper(substr(activityLabels[c(2,3),2],8,8))
substr(activityLabels[,2],1,1) <- toupper(substr(activityLabels[,2],1,1))

# use activityLabels to label allLabels and rename column "activity"
activLab <- activityLabels[allLabels[,1],2]
allLabels[,1] <- activLab
colnames(allLabels) <- "activity"

# rename allSubjects collumn "subject"
colnames(allSubjects) <- "subject"

### Stage 6 Bind the formated objects together to one data set and output it.
outputData <- cbind(requiredData,allLabels,allSubjects)

# Write the data to tidydata.txt
write.table(outputData, file = "tidydata.txt", row.names = F)

### Create second data set with average for each variable and participant
meanData <- data.frame()

for (i in 1:30){
  for ( j in activityLabels[,2]){
    singleSubject <- outputData[outputData$subject %in% i,]
    singleSubjectActivity <- singleSubject[singleSubject$activity %in% j,]
    singleSubjectActivity <- singleSubjectActivity[,1:66]
    singleSubjectMeans <- colMeans(singleSubjectActivity)
    singleSubjectMeans$participant <- i
    meanData <- rbind(meanData, singleSubjectMeans)
  }
}
meanData$activity <- rep(activityLabels[,2])

### Write out the data set with the mean values

write.table(meanData, file = "meanData.txt", row.names = F)
