Getting & Cleaning Data Course Project CodeBook

Dataset details

Original Dataset Name: Human Activity Recognition Using Smartphones Data Set
Dataset File Name: getdata-projectfiles-UCI HAR Dataset
Dataset Download Link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Dataset Source: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory. Data can be found online on the UCI Machine Learning Repository
Dataset description

The Human Activity Recognition database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Data Set Characteristics  Number of Instances	Number of Attributes	Number of activities	Number of subjects
Multivariate, Time-Series	10299	561	6	30
A brief description of the data files are provided below.

features_info.txt: Shows information about the variables used on the feature vector.
features.txt: List of all feature names.
activity_labels.txt: Links the activity class labels with their activity name.
train/X_train.txt: Training set of all the 561 features. Features are normalized and bounded within [-1,1].
train/y_train.txt: Training labels of activities. Range is from 1 to 6.
test/X_test.txt: Test set of all the 561 features. Features are normalized and bounded within [-1,1].
test/y_test.txt: Test labels of activities. Range is from 1 to 6.
train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.
test/subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.
Dataset processing and transformation details

We used all the data files explained above for creating the tidy dataset. The explanation of how the script works is written in detail in README.md so do refer to it as and when needed. Here, we will dive down into the data and explain in detail how we processed and transformed the data into the final tidy dataset.

First we combined the files X_train.txt and X_test.txt into the featureData data frame using the rbind command. This data frame has 10299 rows, where each row represents a case corresponding to a particular subject and 561 columns corresponding to the 561 features, where each is a particular measure.
Next, we combined the files y_train.txt and y_test.txt into the activityLabels data frame using the rbind command. This data frame has 10299 rows and 1 column, where each row represents an activity done by a particular subject.
Next, we combined the files subject_train.txt and subject_test.txt into the subjectLabels data frame using the rbind command. This data frame has 10299 rows and 1 column, where each row represents a particular person i.e., subject identifier.
Then, we read in the feature names from the files features.txt and stores it in the featureNames vector with dimensions of 561 x 2. Where each row represents a particular feature consisting of a feature identifier and its corresponding feature name. We transform this into a 561 x 1 vector containing the feature names only and store it back into the featureNames vector.
From the featureNames vector, we get the required feature indices using the grep command for features having both mean and std and store the indices in the reqdfeatureIndices vector of size 66 x 1 representing a total of 66 features. We use the gsub command to remove the () symbols from the variable names and also converted them to lower case following the conventions for variable names.
Then, we read the different activity names corresponding to the activity identifiers from the activity_labels.txt file and transform the activity ids in the activityLabels data frame to form a new data frame activityData of size 10299 x 1 containing all the activity names. We also follow necessary naming conventions by removing underscores and transforming the names to lower case.
Finally we combine the three dataframes, subjectLabels, activityData and featureData to form the data frame cleanData with dimensions 10299 x 68. This is the first required tidy data set and we write it to the files clean_data.csv and clean_data.txt both having the same content. The rows represent a particular case of a perticular subject.
Next, we load the reshape2 package which will be required for creating the next tidy data set.
Next, we set our identifier and measure variables as idVars and measureVars respectively and then we convert our cleanData data frame into a molten data frame meltedData with dimensions of 679734 x 4 using the melt function. The idVars contain subjectid and activityname because we will be using them as identifier variables while computing average of the remaining feature variables which are the measure variables here.
Now, we decast our molten data frame into the required aggregated data frame where each feature is averaged per person ( subjectid ) per activity ( activityname ) using the dcast function, and we get our second required tidy data set tidyData which is a data frame having dimensions 180 x 68
We write this tidy data set to the files tidy_data.csv and tidy_data.txt both having the same content. Here each row represents a case of a particular subject performing a particular activity and all the features corresponding to that person and activity are averaged.
Tidy Dataset variables description

The following section of the codebook describes all the variables in our final tidy data set.

 ??? subjectid ---------------| Description - The person \ subject performing the activity 
                            | Type - int  
                            | Data - 1 1 1 1 1 1 2 2 2 2 ...

 ??? activityname ------------| Description - The kind of activity performed
                            | Type - Factor with 6 levels
                            | Data - "laying" "sitting" "standing" "walking" "walkingupstairs" "walkingdownstairs" ...

 ??? tbodyacc-mean-x ---------| Description - Mean accelerometer body acceleration in x-axis
                            | Type - numeric   
                            | Data - 0.222 0.261 0.279 0.277 0.289 ...

 ??? tbodyacc-mean-y ---------| Description - Mean accelerometer body acceleration in y-axis
                            | Type - numeric  
                            | Data - -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...

 ??? tbodyacc-mean-z ---------| Description - Mean accelerometer body acceleration in z-axis
                            | Type - numeric  
                            | Data - -0.113 -0.105 -0.111 -0.111 -0.108 ...

 ??? tbodyacc-std-x --------- | Description - Standard deviation of accelerometer body acceleration in x-axis
                            | Type - numeric           
                            | Data - -0.928 -0.977 -0.996 -0.284 0.03 ...

 ??? tbodyacc-std-y-----------| Description - Standard deviation of accelerometer body acceleration in y-axis
                            | Type - numeric           
                            | Data - -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...

 ??? tbodyacc-std-z ----------| Description - Standard deviation of accelerometer body acceleration in z-axis
                            | Type - numeric          
                            | Data - -0.826 -0.94 -0.98 -0.26 -0.23 ...

 ??? tgravityacc-mean-x ------| Description - Mean of accelerometer gravity acceleration measure in x-axis
                            | Type - numeric  
                            | Data - -0.249 0.832 0.943 0.935 0.932 ...

 ??? tgravityacc-mean-y ------| Description - Mean of accelerometer gravity acceleration measure in y-axis
                            | Type - numeric   
                            | Data - 0.706 0.204 -0.273 -0.282 -0.267 ...

 ??? tgravityacc-mean-z ------| Description - Mean of accelerometer gravity acceleration measure in z-axis
                            | Type - numeric   
                            | Data - 0.4458 0.332 0.0135 -0.0681 -0.0621 ...

 ??? tgravityacc-std-x -------| Description - Standard deviation of accelerometer gravity acceleration measure in x-axis
                            | Type - numeric  
                            | Data - -0.897 -0.968 -0.994 -0.977 -0.951 ...

 ??? tgravityacc-std-y -------| Description - Standard deviation of accelerometer gravity acceleration measure in y-axis
                            | Type - numeric  
                            | Data - -0.908 -0.936 -0.981 -0.971 -0.937 ...

 ??? tgravityacc-std-z -------| Description - Standard deviation of accelerometer gravity acceleration measure in z-axis
                            | Type - numeric  
                            | Data - -0.852 -0.949 -0.976 -0.948 -0.896 ...

 ??? tbodyaccjerk-mean-x -----| Description - Mean of time derivation of accelerometer body acceleration in x-axis
                            | Type - numeric   
                            | Data - 0.0811 0.0775 0.0754 0.074 0.0542 ...

 ??? tbodyaccjerk-mean-y -----| Description - Mean of time derivation of accelerometer body acceleration in y-axis
                            | Type - numeric   
                            | Data - 0.003838 -0.000619 0.007976 0.028272 0.02965 ...

 ??? tbodyaccjerk-mean-z------| Description - Mean of time derivation of accelerometer body acceleration in z-axis
                            | Type - numeric   
                            | Data - 0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...

 ??? tbodyaccjerk-std-x ------| Description - Standard deviation of time derivation of accelerometer body acceleration in x-axis
                            | Type - numeric  
                            | Data - -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...

 ??? tbodyaccjerk-std-y ------| Description - Standard deviation of time derivation of accelerometer body acceleration in y-axis
                            | Type - numeric  
                            | Data - -0.924 -0.981 -0.986 0.067 -0.102 ...

 ??? tbodyaccjerk-std-z ------| Description - Standard deviation of time derivation of accelerometer body acceleration in z-axis
                            | Type - numeric  
                            | Data - -0.955 -0.988 -0.992 -0.503 -0.346 ...

 ??? tbodygyro-mean-x --------| Description - Mean gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...

 ??? tbodygyro-mean-y --------| Description - Mean gyroscope body acceleration in y-axis
                            | Type - numeric
                            | Data - -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...

 ??? tbodygyro-mean-z --------| Description - Mean gyroscope body acceleration in z-axis
                            | Type - numeric
                            | Data - 0.1487 0.0629 0.0748 0.0849 0.0901 ...

 ??? tbodygyro-std-x ---------| Description - Standard deviation of gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.874 -0.977 -0.987 -0.474 -0.458 ...

 ??? tbodygyro-std-y ---------| Description - Standard deviation of gyroscope body acceleration in y-axis
                            | Type - numeric
                            | Data - -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...

 ??? tbodygyro-std-z ---------| Description - Standard deviation of gyroscope body acceleration in z-axis
                            | Type - numeric
                            | Data - -0.908 -0.941 -0.981 -0.344 -0.125 ...

 ??? tbodygyrojerk-mean-x ----| Description - Mean of time derivation of gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...

 ??? tbodygyrojerk-mean-y ----| Description - Mean of time derivation of gyroscope body acceleration in y-axis
                            | Type - numeric
                            | Data - -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...

 ??? tbodygyrojerk-mean-z ----| Description - Mean of time derivation of gyroscope body acceleration in z-axis
                            | Type - numeric
                            | Data - -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...

 ??? tbodygyrojerk-std-x -----| Description - Standard deviation of time derivation of gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.919 -0.992 -0.993 -0.207 -0.487 ...

 ??? tbodygyrojerk-std-y -----| Description - Standard deviation of time derivation of gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.968 -0.99 -0.995 -0.304 -0.239 ...

 ??? tbodygyrojerk-std-z -----| Description - Standard deviation of time derivation of gyroscope body acceleration in x-axis
                            | Type - numeric
                            | Data - -0.958 -0.988 -0.992 -0.404 -0.269 ...

 ??? tbodyaccmag-mean --------| Description - Magnitude of  tbodyacc-mean calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...

 ??? tbodyaccmag-std ---------| Description - Magnitude of  tbodyacc-std calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...

 ??? tgravityaccmag-mean -----| Description - Magnitude of  tgravityacc-mean calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...

 ??? tgravityaccmag-std ------| Description - Magnitude of  tgravityacc-std calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...

 ??? tbodyaccjerkmag-mean ----| Description - Magnitude of  tbodyaccjerk-mean calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...

 ??? tbodyaccjerkmag-std -----| Description - Magnitude of  tbodyaccjerm-std calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...

 ??? tbodygyromag-mean -------| Description - Magnitude of  tbodygyro-mean calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...

 ??? tbodygyromag-std --------| Description - Magnitude of  tbodygyro-std calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.819 -0.935 -0.979 -0.187 -0.226 ...

 ??? tbodygyrojerkmag-mean ---| Description - Magnitude of  tbodygyrojerk-mean calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.963 -0.992 -0.995 -0.299 -0.295 ...

 ??? tbodygyrojerkmag-std ----| Description - Magnitude of  tbodygyrojerk-std calculated using Euclidean norm 
                            | Type - numeric
                            | Data - -0.936 -0.988 -0.995 -0.325 -0.307 ...

 ??? fbodyacc-mean-x ---------| Description - Fast Fourier Transform of tbodyacc-mean-x
                            | Type - numeric
                            | Data - -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...

 ??? fbodyacc-mean-y ---------| Description - Fast Fourier Transform of tbodyacc-mean-y
                            | Type - numeric
                            | Data - -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...

 ??? fbodyacc-mean-z ---------| Description - Fast Fourier Transform of tbodyacc-mean-z
                            | Type - numeric
                            | Data - -0.883 -0.959 -0.985 -0.332 -0.226 ...

 ??? fbodyacc-std-x ----------| Description - Fast Fourier Transform of tbody-acc-std-x
                            | Type - numeric
                            | Data - -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...

 ??? fbodyacc-std-y ----------| Description - Fast Fourier Transform of tbody-acc-std-y
                            | Type - numeric
                            | Data - -0.834 -0.917 -0.972 0.056 -0.113 ...

 ??? fbodyacc-std-z ----------| Description - Fast Fourier Transform of tbody-acc-std-z
                            | Type - numeric
                            | Data - -0.813 -0.934 -0.978 -0.28 -0.298 ...

 ??? fbodyaccjerk-mean-x -----| Description - Fast Fourier Transform of tbodyaccjerk-mean-x
                            | Type - numeric
                            | Data - -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...

 ??? fbodyaccjerk-mean-y -----| Description - Fast Fourier Transform of tbodyaccjerk-mean-y
                            | Type - numeric
                            | Data - -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...

 ??? fbodyaccjerk-mean-z -----| Description - Fast Fourier Transform of tbodyaccjerk-mean-z
                            | Type - numeric
                            | Data - -0.948 -0.986 -0.991 -0.469 -0.288 ...

 ??? fbodyaccjerk-std-x ------| Description - Fast Fourier Transform of tbodyaccjerk-std-x
                            | Type - numeric
                            | Data - -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...

 ??? fbodyaccjerk-std-y ------| Description - Fast Fourier Transform of tbodyaccjerk-std-y
                            | Type - numeric
                            | Data - -0.932 -0.983 -0.987 0.107 -0.135 ...

 ??? fbodyaccjerk-std-z ------| Description - Fast Fourier Transform of tbodyaccjerk-std-z
                            | Type - numeric
                            | Data - -0.961 -0.988 -0.992 -0.535 -0.402 ...

 ??? fbodygyro-mean-x --------| Description - Fast Fourier Transform of fbodygyro-mean-x
                            | Type - numeric
                            | Data - -0.85 -0.976 -0.986 -0.339 -0.352 ...

 ??? fbodygyro-mean-y --------| Description - Fast Fourier Transform of fbodygyro-mean-y
                            | Type - numeric
                            | Data - -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...

 ??? fbodygyro-mean-z --------| Description - Fast Fourier Transform of fbodygyro-mean-z
                            | Type - numeric
                            | Data - -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...

 ??? fbodygyro-std-x ---------| Description - Fast Fourier Transform of fbodygyro-std-x
                            | Type - numeric
                            | Data - -0.882 -0.978 -0.987 -0.517 -0.495 ...

 ??? fbodygyro-std-y ---------| Description - Fast Fourier Transform of fbodygyro-std-y
                            | Type - numeric
                            | Data - -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...

 ??? fbodygyro-std-z ---------| Description - Fast Fourier Transform of fbodygyro-std-z
                            | Type - numeric
                            | Data - -0.917 -0.944 -0.982 -0.437 -0.238 ...

 ??? fbodyaccmag-mean --------| Description - Magnitude of fbodyacc-mean calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...

 ??? fbodyaccmag-std ---------| Description - Magnitude of fbodyacc-std calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.798 -0.928 -0.982 -0.398 -0.187 ...

 ??? fbodybodyaccjerkmag-mean | Description - Magnitude of fbodyaccjerk-mean calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...

 ??? fbodybodyaccjerkmag-std -| Description - Magnitude of fbodyaccjerk-std calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.922 -0.982 -0.993 -0.103 -0.104 ...

 ??? fbodybodygyromag-mean ---| Description - Magnitude of fbodygyro-mean calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.862 -0.958 -0.985 -0.199 -0.186 ...

 ??? fbodybodygyromag-std ----| Description - Magnitude of fbodygyro-std calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.824 -0.932 -0.978 -0.321 -0.398 ...

 ??? fbodybodygyrojerkmag-mean| Description - Magnitude of fbodygyrojerk-mean calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.942 -0.99 -0.995 -0.319 -0.282 ...

 ??? fbodybodygyrojerkmag-std | Description - Magnitude of fbodygyrojerk-std calculated using Euclidean norm
                            | Type - numeric
                            | Data - -0.933 -0.987 -0.995 -0.382 -0.392 ...
