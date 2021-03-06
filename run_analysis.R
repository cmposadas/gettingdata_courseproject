#Load in necessary packages
library(dplyr)
library(reshape2)

#Download Galaxy data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="galaxy.zip")

#Load in Galaxy Data
#Load in headers
head <- read.table(unz("galaxy.zip", "UCI HAR Dataset/features.txt"), header=F)
headers <- head[ , 2]
#Load in training and test data sets
train <- read.table(unz("galaxy.zip", "UCI HAR Dataset/train/X_train.txt"), header=F, col.names = headers)
test <- read.table(unz("galaxy.zip", "UCI HAR Dataset/test/X_test.txt"), header=F, col.names = headers)

#Append activity labels with descriptive names
activity_labels <- read.table(unz("galaxy.zip", "UCI HAR Dataset/activity_labels.txt"), header=F)

seq <- seq(1, nrow(train))
train_activity <- read.table(unz("galaxy.zip", "UCI HAR Dataset/train/y_train.txt"), header=F)
train_activity$seq <- seq

train_activity_label <- merge(train_activity, activity_labels, by.x="V1", by.y="V1", all.x=TRUE, sort = FALSE)
activity <- train_activity_label[order(train_activity_label$seq), ]$V2
train <- cbind(activity, train)

seq <- seq(1, nrow(test))
test_activity <- read.table(unz("galaxy.zip", "UCI HAR Dataset/test/y_test.txt"), header=F)
test_activity$seq <- seq

test_activity_label <- merge(test_activity, activity_labels, by.x="V1", by.y="V1", all.x=TRUE, sort = FALSE)
activity <- test_activity_label[order(test_activity_label$seq), ]$V2
test <- cbind(activity, test)

#Append subject identity
train_id <- read.table(unz("galaxy.zip", "UCI HAR Dataset/train/subject_train.txt"), header=F)
subject_id <- train_id$V1
train <- cbind(subject_id, train)

test_id <- read.table(unz("galaxy.zip", "UCI HAR Dataset/test/subject_test.txt"), header=F)
subject_id <- test_id$V1
test <- cbind(subject_id, test)

#merge data
merged <- rbind(train, test)

#keep only subject_id, activity and standard deviation / mean fields
keep_index <- grep("subject_id|activity|std|mean[^(Freq)]", names(merged))
trimmed <- merged[ , keep_index]

#edit variable names to make them more intuitive
newnames <- gsub("[.]","",names(trimmed)) ##remove extra periods
newnames <- gsub("mean","_mean_", newnames) ##add underscores to measurement type
newnames <- gsub("std","_std_", newnames) ##add underscores to measurement type
newnames <- gsub("[_]$","", newnames) ##remove redudant underscores
newnames <- gsub("^t","time_", newnames) ##replace 't' prefix with 'time'
newnames <- gsub("^f","freq_", newnames) ##replace 'f' prefix with 'freq'
newnames <- gsub("BodyBody","Body", newnames) ##remove redundancy
names(trimmed) <- newnames

#summarize the data by taking the mean of each  variable for each activity and each subject
mean_cols <- names(trimmed)[3:68]
trimMelt <- melt(trimmed, id = c("subject_id", "activity"), measure.vars = mean_cols)
mean_trim <- dcast(trimMelt, subject_id + activity ~ variable, mean)

#write final table to .txt file
write.table(mean_trim, file = "galaxy_summary.txt", row.names = FALSE)