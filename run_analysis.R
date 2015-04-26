# The "run_analysis.R" script explains the work done for the "Getting and Cleaning Data" 
# course project. The script performs several steps, as described below.
# 
# Note: the working directory is: "/Users/vdamjano/courseproject/datasciencecoursera/data/UCI HAR Dataset"
#
# STEP 1. Merge the training and the test sets to create one data set.
# -----------------------------------------------------------------------------------
# Note: The training data and the tests data sets are stored localy, within "/train" 
# and "/test" subfolders. Merging of data sets is done by rows. 

# STEP 1.1. Merging "X_train.txt" and "X_test.txt" into "merged_X" data set
tmp1 <- read.table("./train/X_train.txt")
dim(tmp1)
# 7352  561
tmp2 <- read.table("./test/X_test.txt") 
dim(tmp2)
# 2947  561
merged_X <- rbind(tmp1, tmp2) 
dim(merged_X)
# 10299   561
#
# STEP 1.2. Merging "Y_train.txt" and "Y_test.txt" into "merged_Y" data set
tmp3 <- read.table("./train/Y_train.txt") 
dim(tmp3)
# 7352   1
tmp4 <- read.table("./test/Y_test.txt") 
dim(tmp4)
# 2947   1
merged_Y <- rbind(tmp3, tmp4) 
dim(merged_Y)
# 10299    1
#
# STEP 1.3. Merging "subject_train.txt" and "subject_test.txt" into "merged_subject" ds
tmp5 <- read.table("./train/subject_train.txt") 
dim(tmp5)
# 7352    1
tmp6 <- read.table("./test/subject_test.txt") 
dim(tmp6)
# 2947   1
merged_subject <- rbind(tmp5, tmp6) 
dim(merged_subject)
#  10299    1
#
# STEP 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# -----------------------------------------------------------------------------------
# Note: Features.txt is about measurements.
# Note: The values for mean and standard deviation are estimated from the signals, 
# which are accessable from the second column of "features.txt". Hence we're reading 
# "features.txt" into temporary variable called tmp_features. Afterwards, we extract only 
# "-mean" and "-std", from the second column of tmp_features, by using grep function
tmp_features <- read.table("features.txt")
nrow(tmp_features)
# 561
extracted_features <- grep("-mean\\(\\)|-std\\(\\)", tmp_features[, 2])
merged_X <- merged_X[, extracted_features] 
dim(merged_X)
# 10299    66
# setting the descriptive variable names for merged_X
names(merged_X) <- tmp_features[extracted_features, 2] 
# replace all "\\(|\\)" with " " 
names(merged_X) <- gsub("\\(|\\)", "", names(merged_X)) 
#
# STEP 3. Uses descriptive activity names to name the activities in the data set. 
# -----------------------------------------------------------------------------------
# Note: Activity names are given in "activity_labels.txt" data set.
# At first, we're reading activity_labels.txt into a temporary variable called tmp_activities
tmp_activities <- read.table("activity_labels.txt") 
dim(tmp_activities)
#  6   2 
# setting the descriptive variable names for merged_Y
# replace all "_" from all matches with " ", and set the descriptive variable names 
tmp_activities[, 2] = gsub("_", " ", tmp_activities[, 2]) 
merged_Y[,1] = tmp_activities[merged_Y[,1], 2] 
names(merged_Y) <- "activity"
#
# STEP 4. Appropriately labels the data set with descriptive variable names.
# -----------------------------------------------------------------------------------
names(merged_subject) <- "subject"  
#
# STEP 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------------------
# 
tidy_ds <- cbind(merged_subject, merged_Y, merged_X)
dim(tidy_ds)
# 10299    68
write.table(tidy_ds, "tidy_data_course project_step 4.txt") 
#
# calculate the average of each variable for each activity and each subject 
dim(tidy_ds)[2]
# 68 = number of variables in tidy_ds
number_of_variables = dim(tidy_ds)[2]
# 68
number_of_activities = length(tmp_activities[,1]) 
# 6
number_of_subjects = length(unique(merged_subject)[,1]) 
# 30
uniqueS = unique(merged_subject)[,1] 
#
# number of combinations for all subjects and activities is a result of their multiplication
# that will be stored within a variable "final"
final = tidy_ds[1:(number_of_subjects * number_of_activities), ] 
dim(final)
# 180  68 
pom = 1 

for (xs in 1:number_of_subjects) { 
        for (xa in 1:number_of_activities) { 
                result[pom, 1] = uniqueS[xs] 
                result[pom, 2] = tmp_activities[xa, 2] 
                tmpF <- tidy_ds[tidy_ds$subject==xs & tidy_ds$activity==tmp_activities[xa, 2], ] 
                final[pom, 3:number_of_variables] <- colMeans(tmpF[, 3:number_of_variables]) 
                pom = pom+1 
        } 
        
        
}
write.table(final, "tidy_data_course project_step 5.txt", row.name=FALSE)
# Getting-and-Cleaning-Data--course-3
