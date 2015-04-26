test_x_file = ".\\test\\X_test.txt"
test_y_file = ".\\test\\Y_test.txt"
test_subject_file = ".\\test\\subject_test.txt"

train_x_file = ".\\train\\X_train.txt"
train_y_file = ".\\train\\Y_train.txt"
train_subject_file = ".\\train\\subject_train.txt"

activity_labels_file = ".\\activity_labels.txt"
features_file = ".\\features.txt"

# read in the data
test_x = read.table(test_x_file)
test_y = read.table(test_y_file)
test_subject = read.table(test_subject_file)
train_x = read.table(train_x_file)
train_y = read.table(train_y_file)
train_subject = read.table(train_subject_file)
activity_labels = read.table(activity_labels_file)
features = read.table(features_file)

# 1) Merge the training and the test sets to create one data set
test_set = cbind(test_x, test_y, test_subject)
train_set = cbind(train_x, train_y, train_subject)
dataset = rbind(test_set, train_set)

# 2) Extract only the measurements on the mean and standard deviation for each measurement
mean_std_col_idx = features[grepl("mean[()]", features[,2])|grepl("std[()]", features[,2]),1]
mean_std_dataset = dataset[, mean_std_col_idx] 


# 3) Use descriptive activity names to name the activities in the data set 
# add the y back
mean_std_dataset = cbind(mean_std_dataset, factor(dataset[,562], level = activity_labels[,1], labels = activity_labels[,2]))
# add the subject back
mean_std_dataset = cbind(mean_std_dataset, factor(dataset[,563]))

# 4) Appropriately label the data set with descriptive variable names
names(mean_std_dataset) = c(as.character(features[mean_std_col_idx,2]), "activityLabels", "subjects")
    
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
#    activity and each subject
ave_activity_per_subject = aggregate(mean_std_dataset[,c(-67,-68)], list(subjects = mean_std_dataset$subjects, 
                                                            activityLabels = mean_std_dataset$activityLabels), mean)

# rename the columns by getting rid of the "()" symbols
cnames = names(ave_activity_per_subject)
cnames = sub("[(]", "", cnames)
cnames = sub("[)]", "", cnames)
names(ave_activity_per_subject) = cnames

# output tidy dataset as a text file
write.table(ave_activity_per_subject, file="tidy_dataset.txt", row.name=FALSE)

# manually verify the result in ave_activity_per_subject
# test = subset(mean_std_dataset, subset = (subjects == 2 & activity_labels == "WALKING"))
# ave_test = colMeans(test[,c(-67, -68)])

# example code for reading the tidy data set generated in step 5
tidy_data = read.table("tidy_dataset.txt", header = TRUE)

