library(plyr)


##Merge the training and test sets to create one data set

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## load x train and y train data
x_data <- rbind(x_train, x_test)

y_data <- rbind(y_train, y_test)

## create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

##Extract only the measurements on the mean and standard deviation for each measurement


features <- read.table("./UCI HAR Dataset/features.txt")

## get only columns with mean() or std() in their names
mean_and_std_features <- grepl("mean|std", features[, 2])

## subset the desired columns
x_data <- x_data[, mean_and_std_features]

## correct the column names
names(x_data) <- features[mean_and_std_features, 2]

## Use descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

## update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

## correct column name
names(y_data) <- "activity"

## Appropriately label the data set with descriptive variable names

## correct column name
names(subject_data) <- "subject"

## bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

## Create a second, independent tidy data set with the average of each variable
# for each activity and each subject


## 66 <- 68 columns but last two (activity & subject)
tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidy_data, "./tidy_data.txt", row.name=FALSE)