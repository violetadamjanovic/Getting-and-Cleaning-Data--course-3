# Getting-and-Cleaning-Data--course-3
run_analysis.R 
Description of work

STEP 1: The script merges train and test data thorugh three iterations: 
 - firstly, it merges "X_train.txt" and "X_test.txt" into "merged_X" data set (10299 x 561 data set); 
 - secondly it merges "Y_train.txt" and "Y_test.txt" into "merged_Y" data set (10299 x 1 data set), and 
 - finally, it merges "subject_train.txt" and "subject_test.txt" into "merged_subject" (10299 x 1 data set). 

STEP 2. The script extracts only those measurements showing the mean and standard deviation for each measurement. For that purpose, the script reads features.txt (561 measurements in sum), and from the second column of features.txt, it extracts only "-mean" and "-std", by using grep function. Extracted features are stored in variable merged_X which, is now 10299 x 66 data set. This explains that only 66 measurements out of 561 are about "-mean" and "-std". Here, we also set the descriptive variable names for merged_X by replace all "\\(|\\)" with " " and by using names() function. 

STEP 3. The script adds the descriptive activity names to name the activities in the data set. Activity names are given in "activity_labels.txt" data set. Firstly, we're reading activity_labels.txt into a temporary variable called tmp_activities (6 x 2 data set), then replacing all "_" from all matches with " ", and setting the descriptive variable names by using the names() function. 

STEP 4. The script labels the data set with descriptive variable names. It works with merged_subject temporary data set, and adds "subject" as the name. 

STEP 5. From the data set in step 4, the script now creates a new tidy data set that contains only the average of each variable for each activity and each subject. Firstly, we created "tidy_data_course project_step 4.txt" (based on STEP 4) (10299 x 68 data set), which merges all three datasets: merged_subject, merged_Y, merged_X, and we wrote "tidy_data_course project_step 4.txt" by using write.table() function. Then, we calculated the average of each variable for each activity and each subject. This is done by using a FOR loop which is controled based on the length of activities, subjects and variables from tidy_ds (STEP 4). During the FOR loop, the "final" data set is getting built, plus it calculates means (averages) for each variable. Finally, we write table called "tidy_data_course project_step 5.txt", based on "final" dataset. We're using row.name=FALSE for writing the table, as suggested in the decsription of the problem. 

By comparing the size of the data sets created in STEP 4 and STEP 5, we can see notable drop in size from 8.3 MB (step 4) to 224 KB (step 5). 
