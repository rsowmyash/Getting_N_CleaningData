#####################           run_analysis.R            #######################################
############# STEP1: MERGE TRAINING AND TEST DATASETS TO CREATE ONE DATASET ###########################
## Read all the training and test text files that needs to appended for preparing the dataset##

test_X <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/test/X_test.txt", header= FALSE)
train_X <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/train/X_train.txt", header= FALSE)

test_activity <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/test/Y_test.txt", header= FALSE)
train_activity <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/train/Y_train.txt", header= FALSE)

test_subject <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/test/subject_test.txt", header= FALSE)
train_subject <- read.table("C:/Users/skumar/Documents/R_working_site/UCI HAR Dataset/train/subject_train.txt", header= FALSE)

#combine test and train datasets- measurements records#
x <- rbind(test_X, train_X)
#combine activity test and train datasets#
activity <- rbind(test_activity, train_activity)
#create subject (test subject append test train) dataset#
subject <- rbind(test_subject, train_subject)

######Appropriately label the data set with descriptive variable names######

names(subject) <- c("subject")
names(activity)<- c("activity")


##### User descriptive activity names to name the activities########
## naming the data frames##

## load features.txt into dataframe##
features = read.table("C:/Users/skumar/Documents/R_working_site/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", header= FALSE)
names(x)<- features$V2

# update values with correct activity names
activity[, 1] <- activityLabels[activity[, 1], 2]
# correct column name
names(activity) <- "activity"

## bind all the data together ##
datacombine <- cbind(subject, activity)
full_DF <- cbind(x, datacombine)

########### Extracts only the measurements on the mean and standard deviation for each measurement##########

SDMeanFeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectedNames<-c(as.character(SDMeanFeatures), "subject", "activity" )

full_DF <- subset(full_DF,select=selectedNames)


########## Create a second, independent tidy dataset with the average for each activity and each subject##############

averages_DF <- ddply(full_DF, .(subject, activity), function(x) colMeans(x[, 1:66]))


write.table(averages_DF, "c:/Users/skumar/Documents/R_working_site/final_dataset.txt", sep=",", row.names= FALSE)










