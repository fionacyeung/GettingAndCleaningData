---
title: "ReadMe"
author: "Fiona Yeung"
date: "Sunday, April 26, 2015"
output: html_document
---

run_analysis.R included in the repo assumes that the "UCI HAR Dataset" data folder as downloaded from the class project website is the current working directory. For example, the current working directory can be set by typing the following command at the console on Windows machine:

setwd("C:\\classes\\Coursera\\Data_Science_Specialization\\Getting_And_Cleaning_Data\\project\\UCI HAR Dataset")

You can reproduce the tidy data set that I submitted by sourcing run_analysis.R. This script follows the instruction for this assignment in the order that it suggested. The steps are outlined below and details are provided:

1. **Merge the training and the test sets to create one data set.**  
* I used `cbind` and `rbind` to combine the data sets

2. **Extract only the measurements on the mean and standard deviation for each measurement**
* I used `grepl` to select the column names that contain "mean()" and "std()" and store the resulting feature names for use in step 4. The feature names for all measurements are given in features.txt

3. **Use descriptive activity names to name the activities in the data set** 
* I used the names provided in activity_labels.txt for the response (Y) and turn them into factor variables for aggregation in step 5. I also turn the subject ID (obtained from "subject_test.txt" and "subject_train.txt") to factor variables for the same purpose.

4. **Appropriately label the data set with descriptive variable names**
* I assigned column names to the measurement columns (X) using the names provided in features.txt. At this point, only columns with "mean()" and "std()" remain in the data set. The logical vector from step 2 is used to skip over the columns that have already been removed.

5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
* I used the `aggregate` function to collapse the rows by subject and by activity to compute the mean across the measurements (X). I also eliminated the symbols "()" in the column names because some software may have problems reading in non-alphanumeric symbols in the header. After that, I called `write.table` to write out the tidy data set in .txt format as required. The output filename is "tidy_dataset.txt". I also included test code at the end to verify the computation in the generation of the tidy data set. The tidy data set generated is consistent with my understanding of Hadley Wickham's guideline at http://vita.had.co.nz/papers/tidy-data.pdf.

**The tidy data set generated from step 5 can be read into R by using the following command:**

**tidy_data = read.table("tidy_dataset.txt", header = TRUE)**