# Load useful libraries
library(dplyr)

# Load my helper function
source('~/Dropbox/Coursera/GettingAndCleaningData/helper.R')

# Record this working directory
working_dir <- getwd()

# get UCI HAR dataset (from helper.R) in the current tempdir()
data_file <- downloadDataset()

# Unpack dataset (if needed) and getting the file list (from helper.R)
file_list <- unpackDataset(data_file)

# get train files names with their position
train <- list()

# get the relative X_train path in archive. getFilePath is defined in helper.r
train$data <- getFilePath("X_train", file_list)

# get the relative y_train path in archive
train$activity <- getFilePath("/y_train.txt", file_list)

# get the relative train subject list in archive
train$subjects <- getFilePath("subject_train.txt", file_list)

# get test files names with their position
test <- list()

# get the relative X_test path in archive
test$data <- getFilePath("X_test", file_list)

# get the relative y_test path in archive
test$activity <- getFilePath("/y_test.txt", file_list)

# get the relative test subject list in archive
test$subjects <- getFilePath("subject_test.txt", file_list)

# get features list (data headers)
features_path <- getFilePath("features.txt", file_list)

# get activity labels
activity_labels_path <- getFilePath("activity_labels.txt", file_list)

# Set test and train activity labels and column names
train$columns <- features_path
train$labels <- activity_labels_path

test$columns <- features_path
test$labels <- activity_labels_path

# read the training set (function defined in helper.R)
training_set <- read_handy(train)

# Select only useful columns
training_set <- select(training_set, Subject, Activity, contains("mean"), contains("std"), -contains("meanFreq"), -contains("gravityMean"), -starts_with("Angle"))

# read the test set (function defined in helper.R)
test_set <- read_handy(test)

# Select only useful columns
test_set <- select(test_set, Subject, Activity, contains("mean"), contains("std"), -contains("meanFreq"), -contains("gravityMean"), -starts_with("Angle"))

# Put the two test together (since names are the same)
merged_set <- bind_rows(training_set, test_set)

# remove un used data frames
rm(training_set)
rm(test_set)

# creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.

# dplyr summarize_each apply one or more functions to one or more columns.
# Grouping variables are always excluded from modification.
tidy_dataset <- merged_set %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

# Write tidy_dataset for submission
write.table(tidy_dataset, "tidy_dataset.txt", row.name=FALSE)