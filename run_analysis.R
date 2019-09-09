library(plyr)

#Reading feature/variable names
feature <- read.table("./UCI HAR Dataset/features.txt")

#Reading the test and train subject and activity label datasets
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")

#Reading train and test records
train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = feature[[2]])
test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = feature[[2]])

#Reading the activity labels 
actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Combining train and test subject (and activity) records as a single column and then combining these columns
subAndAct <- cbind(rbind(trainSubject, testSubject), rbind(trainActivity, testActivity))

# replace activity column with corresponding text labels from the activity label dataframe
subAndAct$activity <- actLabels[match(subAndAct$activity, actLabels[[1]]), 2]

#Creating a vector of indexes of all column names that contain "mean" or "std"
meanAndStd <- grep("mean|std", feature[[2]])

#Combining train/test datasets, subset to mean/std variables, combined with subject and activity columns
mergedData <- cbind(subAndAct, rbind(train, test)[,meanAndStd])

#Replacing column names of mergedData that are too much abbreviated with a more understandable version
names(mergedData) <- sub("^f", "freq", names(mergedData))
names(mergedData) <- sub("^t", "time", names(mergedData)) 

#Creating an independent data set with the average of each variable for each activity and each subject
avgData <- ddply(mergedData, .(subject, activity), function(x) colMeans(x[, 3:length(mergedData)]))

#Writing avgData to output txt file
write.table(avgData, file = "UCI HAR Averages DataSet.txt", row.name = FALSE)