#loading requaried libraries 
library(dplyr)

#checking if data directory exists
if(!file.exists("./data")){dir.create("./data")}

#dowload and extract data files to data/UCI directory
if(!file.exists("./data/UCI.zip")){
  fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl1,destfile="./data/UCI.zip")
  unzip("./data/UCI.zip", exdir = "./data")
}

#reading test data
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
activity_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#reading train data
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

#reading dictionaries
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)

#features names cleaning
features$V2 <- gsub("^t", "Time", features$V2)
features$V2 <- gsub("^f", "Frequency", features$V2)
features$V2 <- gsub("^angle", "Angle", features$V2)
features$V2 <- gsub("\\(tB", "\\(TimeB", features$V2)
features$V2 <- gsub("BodyBody", "Body", features$V2)
features$V2 <- gsub("\\(\\)", "", features$V2)

#adding deduplicated features names 
names(test) <- paste(paste(features$V1,":", sep=""), features$V2)
names(train) <- paste(paste(features$V1,":", sep=""), features$V2)

#test set preparing
test_temp <- subject_test
test_temp$activity_id = activity_test$V1
test_temp <- merge(test_temp, activity_labels, by.x="activity_id", by.y="V1", all=TRUE)
test_temp <- cbind(test_temp, test)

#train set preparing
train_temp <- subject_train
train_temp$activity_id = activity_train$V1
train_temp<- merge(train_temp, activity_labels, by.x="activity_id", by.y="V1", all=TRUE)
train_temp <- cbind(train_temp, train)

#union of test and train sets
full_set <- rbind(test_temp,train_temp)

#adding columns names
names(full_set)[2:3] <- c("subject_id", "activity_descr")

#selection of mean and std metrics
full_set <- select(tbl_df(full_set), 2:3, contains("mean"), contains("std"))

#aggregation with mean by subject_id and activity_descr
agr<-arrange(aggregate(. ~  subject_id:activity_descr ,data=full_set,FUN=mean,na.rm=T), subject_id, activity_descr)

write.table(agr,"./data/UCI HAR Dataset/tidy.txt",row.name=FALSE)
