setwd("D:\\Coursera\\Material\\03. Getting and Cleaning Data\\CourseProject\\UCI HAR Dataset")

###Load data
#Load the featues labels
features <- read.table("features.txt",col.names = c("ID","Features"))
head(features);names(features);dim(features);
activity_labels <- read.table("activity_labels.txt",col.names = c("activity","Activity_Label"))
activity_labels

#Load X, y & subject data, and assign the col name from features data (training)
x_train <- read.table("train\\X_train.txt",col.names = features[,2])
head(x_train); dim(x_train);

y_train <- read.table("train\\Y_train.txt",col.names = "activity")
head(y_train); dim(y_train);

subject_train <- read.table("train\\subject_train.txt",col.names = "subject_id")

#Load X, y & subject data, and assign the col name from features data (testing)
x_test <- read.table("test\\X_test.txt",col.names = features[,2])
head(x_test); dim(x_test);

y_test <- read.table("test\\Y_test.txt",col.names = "activity")
head(y_test); dim(y_test);

subject_test <- read.table("test\\subject_test.txt",col.names = "subject_id")


###Merge data from train & test
x <- rbind(x_train,x_test);  dim(x);
y <- rbind(y_train,y_test);  dim(y);
subject <- rbind(subject_train,subject_test);  dim(subject);


###Assign the activity label
y_activity <- merge(y,activity_labels,by.x = "activity", by.y = "activity")
head(y_activity);head(y);

###Extract the mean/std column only, and combine x/y data
colIdx <- (grepl("mean",features[,2]) |  grepl("std",features[,2]))
colIdx; 
activity_data <- cbind(y_activity$Activity_Label,subject, x[,colIdx]);
head(activity_data)

###Write the tidy data
write.table(activity_data,file="activity_data.txt",row.names = FALSE)

names(activity_data)




