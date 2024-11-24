# Load required libraries
library(dplyr)

# 1. Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

# Define file paths
data_path <- "UCI HAR Dataset"
features_path <- file.path(data_path, "features.txt")
activity_labels_path <- file.path(data_path, "activity_labels.txt")
train_path <- file.path(data_path, "train")
test_path <- file.path(data_path, "test")

# Load data
features <- read.table(features_path, col.names = c("index", "feature"))
activities <- read.table(activity_labels_path, col.names = c("id", "activity"))
x_train <- read.table(file.path(train_path, "X_train.txt"))
y_train <- read.table(file.path(train_path, "y_train.txt"), col.names = "activity")
subject_train <- read.table(file.path(train_path, "subject_train.txt"), col.names = "subject")
x_test <- read.table(file.path(test_path, "X_test.txt"))
y_test <- read.table(file.path(test_path, "y_test.txt"), col.names = "activity")
subject_test <- read.table(file.path(test_path, "subject_test.txt"), col.names = "subject")

# 2. Merge the datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 3. Extract measurements of mean and standard deviation
mean_std_columns <- grep("-(mean|std)\\(\\)", features$feature)
x_data <- x_data[, mean_std_columns]
colnames(x_data) <- features$feature[mean_std_columns]

# 4. Apply descriptive activity names
y_data$activity <- activities[y_data$activity, 2]

# 5. Create the tidy dataset
merged_data <- cbind(subject_data, y_data, x_data)
tidy_data <- merged_data %>%
  group_by(subject, activity) %>%
  summarize_all(mean)

# Save the tidy dataset to a file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
