run_analysis <- function(){
     library(dplyr)
     
     #Reading data frames
     #========================
features <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/features.txt")
activities <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/activity_labels.txt")
subject_test <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/test/subject_test.txt")
test_set <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/test/X_test.txt")
test_lables <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/test/y_test.txt")
subject_train <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/train/subject_train.txt")
training_set <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/train/x_train.txt")
training_lables <- 
     read.table("C:/Users/Magic/Documents/UCI HAR Dataset/train/y_train.txt")
     
     #changing columns names per dataframe
     #=========================================
names(activities) <- c("code","activity")
names(features) <- c("n","functions")
names(subject_test) <- c("subject")
names(test_set) <- as.character(features$functions)
names(test_lables) <-  c("code")
names(subject_train) <-  c("subject")
names(training_set) <- as.character(features$functions)
names(training_lables) <-  c("code")

     
     #Merging the training and the test sets to create one data set
     #=============================================================
     set <- rbind(training_set, test_set)
     lable <- rbind(training_lables, test_lables)
     Subject <- rbind(subject_train, subject_test)
     Merged_Data <- cbind(Subject,lable ,set)
     

     #Extracting measurements on means and stds for each column
     #=========================================================
     
     #mean data
     search1 <- grep( "[Mm][Ee][Aa][Nn]" ,colnames(Merged_Data))
     mean_data<- Merged_Data[,search1]
     # std data
     search2 <- grep( '[Ss][Tt][Dd]' ,colnames(Merged_Data))
     std_data<- Merged_Data[,search2]
     #output data
     mean_std<- cbind(mean_data,std_data)
     output_data <- cbind(Subject,lable,mean_std)
     output_data <- data.frame(output_data)
     
     
     #adding activity types
     #======================
     output_data$code <- activities[output_data$code, 2]
     
     
     #using clear column names
     #========================
     names(output_data)[2] = "activity_type"
     names(output_data)<-gsub("Acc", "Accelerometer", names(output_data))
     names(output_data)<-gsub("Gyro", "Gyroscope", names(output_data))
     names(output_data)<-gsub("BodyBody", "Body", names(output_data))
     names(output_data)<-gsub("Mag", "Magnitude", names(output_data))
     names(output_data)<-gsub("^t", "Time", names(output_data))
     names(output_data)<-gsub("^f", "Frequency", names(output_data))
     names(output_data)<-gsub("tBody", "TimeBody", names(output_data))
     names(output_data)<-gsub("-mean()", "Mean", names(output_data), ignore.case = TRUE)
     names(output_data)<-gsub("-std()", "STD", names(output_data), ignore.case = TRUE)
     names(output_data)<-gsub("-freq()", "Frequency", names(output_data), ignore.case = TRUE)
     names(output_data)<-gsub("angle", "Angle", names(output_data))
     names(output_data)<-gsub("gravity", "Gravity", names(output_data))
     
     
     #data set with avg of each coloumn for each activity and subject
     #===============================================================
     FinalData <- output_data %>%
          group_by(subject, activity_type) %>%
          summarise_all(funs(mean))
     write.table(FinalData, "FinalData.txt", row.name=FALSE)
     
     #CHECK final data
     FinalData
     str(FinalData)
}
