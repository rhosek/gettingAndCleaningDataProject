
The raw data for this project is contained in the UCI HAR dataset. 
We know the following about the raw data:
From the README file we learn the following:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The files of interest for us are as follows:

x_train.txt (7352,561)
y_train.txt (7352,1)
subject_train.txt (7352,1)
x_test.txt (2947,561)
y_test.txt (2947,1)
subject_test.txt (2947,1)
activity_labels.txt (6,2)
features.txt (561,2)
features_info.txt
README.txt

Note that there are inertial files in the dataset but they are outside the scope of our work and are not considered here.

Our mission is to create a tidy dataset that conforms to the following properties:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 

Additionally, we must do the following:
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The first step is to read the above files (except for README.txt and features_info.txt) into R using the read.table() function. The files then need to be examined using the dim() and head() functions to determine the size and shape of the files and a sense of variable names and values. The actual dimensions of the files that were determined are listed above next to the files in parantheses.

From the aforementioned dimensions we see that x_train and x_test are the files which contain the actual accelerometer data and note that they have equal numbers of columns (variables=561) but unequal numbers of rows. Therefore our strategy will be to merge these two data frames row-wise after removing columns that do not contain mean or std dev data. we will also need to change the column names.

y_train and y_test have one column(variable) each but have lengths (numbers of rows) that correspond to the number of rows in x_train and x_test, respectively. Also, on examination, it is revealed that these files contain only integers in the range 1 to 6. These numbers correspond to the activity codes found in the activity_labels file. Therefore, these y_ files will need to be bound column-wise to the appropriate x- files. As such they will constitute new variables and will be named "activity". Note that this new column could be left in numeric form or could be converted to the actual activity names. Or both columns could be utilized.

Here are the names of the working variables in the dataset:

 [1] "subject_id"  (1:30)                  "mode"    (train or test)                     
 [3] "activity_code"   (1:6)              "activity"                     
 
 The remainder of these variables are the means and standard deviations (std) of the x, y, and z components
 of various physical measures, such as acceleration, jerk and gyro. The names are self-explanatory.
 [5] "tBodyAcc-mean-X"               "tBodyAcc-mean-Y"              
 [7] "tBodyAcc-mean-Z"               "tBodyAcc-std-X"               
 [9] "tBodyAcc-std-Y"                "tBodyAcc-std-Z"               
[11] "tGravityAcc-mean-X"            "tGravityAcc-mean-Y"           
[13] "tGravityAcc-mean-Z"            "tGravityAcc-std-X"            
[15] "tGravityAcc-std-Y"             "tGravityAcc-std-Z"            
[17] "tBodyAccJerk-mean-X"           "tBodyAccJerk-mean-Y"          
[19] "tBodyAccJerk-mean-Z"           "tBodyAccJerk-std-X"           
[21] "tBodyAccJerk-std-Y"            "tBodyAccJerk-std-Z"           
[23] "tBodyGyro-mean-X"              "tBodyGyro-mean-Y"             
[25] "tBodyGyro-mean-Z"              "tBodyGyro-std-X"              
[27] "tBodyGyro-std-Y"               "tBodyGyro-std-Z"              
[29] "tBodyGyroJerk-mean-X"          "tBodyGyroJerk-mean-Y"         
[31] "tBodyGyroJerk-mean-Z"          "tBodyGyroJerk-std-X"          
[33] "tBodyGyroJerk-std-Y"           "tBodyGyroJerk-std-Z"          
[35] "tBodyAccMag-mean"              "tBodyAccMag-std"              
[37] "tGravityAccMag-mean"           "tGravityAccMag-std"           
[39] "tBodyAccJerkMag-mean"          "tBodyAccJerkMag-std"          
[41] "tBodyGyroMag-mean"             "tBodyGyroMag-std"             
[43] "tBodyGyroJerkMag-mean"         "tBodyGyroJerkMag-std"         
[45] "fBodyAcc-mean-X"               "fBodyAcc-mean-Y"              
[47] "fBodyAcc-mean-Z"               "fBodyAcc-std-X"               
[49] "fBodyAcc-std-Y"                "fBodyAcc-std-Z"               
[51] "fBodyAcc-meanFreq-X"           "fBodyAcc-meanFreq-Y"          
[53] "fBodyAcc-meanFreq-Z"           "fBodyAccJerk-mean-X"          
[55] "fBodyAccJerk-mean-Y"           "fBodyAccJerk-mean-Z"          
[57] "fBodyAccJerk-std-X"            "fBodyAccJerk-std-Y"           
[59] "fBodyAccJerk-std-Z"            "fBodyAccJerk-meanFreq-X"      
[61] "fBodyAccJerk-meanFreq-Y"       "fBodyAccJerk-meanFreq-Z"      
[63] "fBodyGyro-mean-X"              "fBodyGyro-mean-Y"             
[65] "fBodyGyro-mean-Z"              "fBodyGyro-std-X"              
[67] "fBodyGyro-std-Y"               "fBodyGyro-std-Z"              
[69] "fBodyGyro-meanFreq-X"          "fBodyGyro-meanFreq-Y"         
[71] "fBodyGyro-meanFreq-Z"          "fBodyAccMag-mean"             
[73] "fBodyAccMag-std"               "fBodyAccMag-meanFreq"         
[75] "fBodyBodyAccJerkMag-mean"      "fBodyBodyAccJerkMag-std"      
[77] "fBodyBodyAccJerkMag-meanFreq"  "fBodyBodyGyroMag-mean"        
[79] "fBodyBodyGyroMag-std"          "fBodyBodyGyroMag-meanFreq"    
[81] "fBodyBodyGyroJerkMag-mean"     "fBodyBodyGyroJerkMag-std"     
[83] "fBodyBodyGyroJerkMag-meanFreq"

Finally, we see that, as was the case with the y_ files, subject_train and subject_test are one-variable files equal in length to to their x_ counterparts. These files thus contain the subject ID numbers for each row in the tables and will need to be bound column-wise.


Here is a more compact form of the above steps organized in the order contained in the run_analysis.R script.
##activate packages plyr and dplyr
##load feature names into data frame
##select feature names containing mean or std by index
##select feature names containing mean or std by name
##Clean up feature names
##load training and test data files into data frames
##subset xtrn and xtst to retain only variable names containing 'mean' or 'std'
##insert modified variable names into xtrn2 and xtst2
##load the activity codes and descriptions into a data frame
##get 'to' and 'from' vectors for al for mapvalues function
##Load the training and test activity codes into data frames
## make working copies
##modify these using the mapvalues funtion to get description vectors
##add these columns
#rename columns
##bind activity data frame to variable data frame column-wise
##load the subject files into data frames
##augment subjec_id column with column indicating mode (train or test)
##rename the new columns
##bind the subject vectors to the main dataset column-wise
##Finally, create the final tidy dataset by row-binding the traing and test datasets





