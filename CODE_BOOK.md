---
title: "run_analysis_CodeBook"
author: "AyahFouad"
date: "9 „«—”° 2019"
output: html_document
---

#####This Repository is to submit the thid course's project in Coursera "Data Science Specialization", which is graded by peers as part of "Peer-graded Assignment: Getting and Cleaning Data Course Project" section.

#####The following steps demonestrates steps performed to clean and analyse tidy data as per required in the project:

####**Step 1**: 
##### Downloading Data and setting work directory

- The data used for this project was downloaded and extracted from the following Url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Then the zipped file was extracted in the working directory which in my case was in "C:/Users/Magic/Documents" 
- And the data provided was in a folder called "UCI HAR Dataset"
- Instructions in the files "READ ME.txt" and "Features_info.txt" were followed to read the data.

####**Step 2**: 
##### Setting prelimenary Variables Names

- As per the instruction in "READ ME.txt" and "Features Info.txt" the following variables were assigned:
     
     1. **features** : 561 rows, 2 columns :
     which shows the functions used as variables across the experiment.
     2. **activities** :  6 rows, 2 columns :
     which shows activities done when the functions were measured and their lables.
     3. **subject_test** : 2947 rows, 1 column :
     which contains the data recorded for test subjects which represents 30% of total subjects
     4. **test_set** : 2947 rows, 561 columns :
     which contains recorded features for test data
     5. **test_lables** : 2947 rows, 1 columns :
     which contains test data of activitiesícode labels
     6. **subject_train** : 7352 rows, 1 column :
     which contains the data recorded for train subjects which represents 70% of total subjects
     7. **training_set** : 7352 rows, 561 columns :
     which contains recorded features for train data
     8. **training_lables** : 7352 rows, 1 columns  :
     which contains train data of activitiesícode labels
     
####**Step 3** : 
##### Changing the names of data frames to be more descriptive:

- After reading the data frames and assigning relatave variables, names of each data fram was changed as follows to be more descriptive and to be able to combine test and training data frames into one data set:

     1. **activities** : col1= "code" / col2= "activity"
     2. **features** : col1= "n" / col2= "functions"
     3. **subject_test** : col1= "subject"
     4. **test_set** : col1 till col 561 are named as per functions column in features data fram
     5. **test_lables** : col1= "code"
     6. **subject_train** : col1= "subject"
     7. **training_set** : col1 till col 561 are named as per functions column in features data fram
     8. **training_lables** : col1= "code"
     
     
####**Step 4** : 
##### Merging test data with training data
     
- the following variables are used to merge data sets of test and train:
     
     1.**set** : Is a data set built by staking "test_set" and "training_set" data frames by using rbind() function
     2. **lable** : Is a data set built by staking "training_lables" and "test_lables" by using rbind() function
     3. **subject** : Is a data set build by staking "subject_test" and "subject_train" sets by using rbind() function
     4. **Merged_Data** : Is a data set built by combining "subject", "lable" and "set" data frames created as per the above three points.
     
####**Step 5** : 
##### Selecting only measurements of "Mean" and "Standard Deviation" from the data set

- At the beginning of this step we have a data frame called "Merged_Data" with diminsions (10299 rows, 563 column) , where we selected only columns of mean and standard deviation measurements by using the following variables :

     1. ***search1** : which stores location of columns that measures "mean" functions
     2. **mean_data** : It's a data frame which includes data coresponding to "search1" of mean functions 
     3. **search2** : which stores location of columns that measures "standard deviation" functions
     4. **std_data** : It's a data frame which includes data coresponding to "search2" of standard deviation functions
     5. **mean_std** : is a data fram which is the combination of the mean and standard deviation data obtainllind from  "mean_data" and "std_data"
     6. **output_data** : is a data fram which is the combination of "subject", "lable" and "mean_std" data sets
     
  
####**Step 6** : 
##### Adding the activity name to the data set

- At this step the column "code" in "output_data" set is replaced with the name of activity as "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING" and "LAYING", by using this code:
    " output_data[,code] <- activities[output_data$code, 2] "
     

     
####**Step 7** : 
##### changind the names of columns to be more descriptive

- code column in output_data renamed into activities_type
- All "Acc" in columnís name replaced by "Accelerometer"
- All 'Gyro' in columnís name replaced by 'Gyroscope'
- All 'BodyBody' in columnís name replaced by 'Body'
- All 'Mag' in columnís name replaced by 'Magnitude'
- All 'start' with character f in columnís name replaced by 'Frequency'
- All start with 't' in columnís name replaced by 'Time'


####**Step 8** : 
##### creating independent tidy data set with the average of each variable for each activity and each subject

- **FinalData** : is a dataset with the mean avarage for each activity and subject in the output_data.


     


