#Download Data
library(dplyr)
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setwd("~/Desktop/Coursera R Specialization /Getting and Cleaning Data")
download.file(url,destfile = "~/Desktop/Coursera R Specialization /Getting and Cleaning Data/Project.zip")
unzip ("Project.zip", exdir = "./")
setwd("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/Assignment")
X_test<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
X_train<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
label<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
activity<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
Y_test<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
Y_train<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
tester<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
tester1<-read.table("~/Desktop/Coursera R Specialization /Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

#1. Merges the training and the test sets to create one data set.
dim(X_test)
dim(X_train)
class(X_test)
class(X_train)
Project<-rbind.data.frame(X_test,X_train)
Act_Project<-rbind.data.frame(Y_test,Y_train)

#Project<-cbind.data.frame(Project,Act_Project)
dim(label)
class(label)
label<-label[,2]
names(Project)<-label
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
colonne<-grep("*mean()",names(Project),value=FALSE )
colonne1<-grep("*std()",names(Project),value=FALSE )
c<-c(colonne,colonne1)
Project<-Project[,c]
#3.Uses descriptive activity names to name the activities in the data set
Project<-cbind.data.frame(Act_Project,Project)
Project<-merge(Project,activity, by.x="V1", by.y = "V1",all = TRUE)
Project<-Project[,-1]
#4.Appropriately labels the data set with descriptive variable names.
names(Project)<-sub("V2","Activity",names(Project))

#5.From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.
Project2<-Project
P<-Project2%>%group_by(Activity)%>%summarise_each(funs(mean))

