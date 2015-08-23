##activate packages
library(plyr)
library(dplyr)

##load feature names into data frame
f1<-read.table("features.txt")

##select feature names containing mean or std by index
f2<-grep("mean|std", f1$V2, value=FALSE)

##select feature names containing mean or std by name
f3<-grep("mean|std", f1$V2, value=TRUE)

##Clean up feature names
f3 <- gsub("\\(\\)", "", f3)

##load training and test data files into data frames
xtrn<-read.table("x_train.txt")
xtst<-read.table("x_test.txt")

##subset xtrn and xtst to retain only variable names containing 'mean' or 'std'
xtrn2 <- xtrn[, f2]
xtst2 <- xtst[, f2]

##insert modified variable names into xtrn2 and xtst2
names(xtrn2) <- f3
names(xtst2) <- f3

##load the activity codes and descriptions into a data frame
al <- read.table("activity_lables.txt")

##get 'to' and 'from' vectors for al for mapvalues function
a1 <- c(1, 2, 3, 4, 5, 6)
a2 <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

##Load the training and test activity codes into data frames
ytrn <- read.table("y_train.txt")
ytst <- read.table("y_test.txt")

## make working copies
ytrn2 <- ytrn
ytst2 <- ytst

##modify these using the mapvalues funtion to get description vectors
ytrn2 <- mapvalues(ytrn2[,1], a1, a2)
ytst2 <- mapvalues(ytst2[,1], a1, a2)

##add these columns

ytrn$new.col <- ytrn2
ytst$new.col <- ytst2

#rename columns
names(ytrn) <- c("activity_code", "activity")
names(ytst) <- c("activity_code", "activity")

##bind activity data frame to variable data frame column-wise
xtrn2 <- cbind(ytrn, xtrn2)
xtst2 <- cbind(ytst, xtst2)

##load the subject files into data frames
strn <- read.table("subject_train.txt")
stst <- read.table("subject_test.txt")

##augment subjec_id column with column indicating mode (train or test)
strn$new.col <- rep(c("train"), times = nrow(strn))
stst$new.col <- rep(c("test"), times = nrow(stst))

##rename the new columns
names(strn) <- c("subject_id", "mode")
names(stst) <- c("subject_id", "mode")

##bind the subject vectors to the main dataset column-wise
xtrn2 <- cbind(strn, xtrn2)
xtst2 <- cbind(stst, xtst2)

##Finally, create the final tidy dataset by row-binding the traing and test datasets
tidy_final <- rbind(xtrn2, xtst2)







