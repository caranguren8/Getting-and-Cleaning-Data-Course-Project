## Merges the training and the test sets to create one data set.

#read data
activitylabels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")
subjecttest <- read.table("./test/subject_test.txt")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/Y_test.txt")
subjecttrain <- read.table("./train/subject_train.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/Y_train.t")

#merge data test and train data and label "subject"
subject <- rbind(subjecttest,subjecttrain)
names(subject) <- "Subject"

xt <- rbind(xtest,xtrain)
yt <- rbind(ytest,ytrain)

##Extracts only the measurements on the mean and standard deviation for each measurement

featuresmsd <- grep("mean|std",features[,2])

#extract the desired data from the merged data and label it
xtms <- xt[,featuresmsd]
names(xtms) <- features[featuresmsd,2]

##Uses descriptive activity names to name the activities in the data set

#assign names to the merged data of "y" and label it
ytwn <- activitylabels[yt[,1],2]
names(ytwn) <- "Activity"

##Appropriately labels the data set with descriptive variable names

#merge all the data in one data set(it was already labeled)
data <- cbind(subject,ytwn,xtms)
names(data)[2] <- "Activity"

##creates a second, independent tidy data set with the average of each variable for each activity and each subject.

summarizeddata <- ddply(data, .(Subject, Activity), function(x) colMeans(x[, 3:81]))

