
# read test data
testx <- read.table("X_test.txt")
testy <- read.table("y_test.txt")

# read train data
trainx <- read.table("X_train.txt")
trainy <- read.table("y_train.txt")

# read subject data
subjecttest <- read.table("subject_test.txt")
subjecttrain <- read.table("subject_train.txt")

# activity labels for testy
for (i in 1:2947){
  oldnames <- testy$V1
  oldname <- oldnames[i]
  if (oldname=="1"){
    testy$V1[i]="WALKING"
  }
  if (oldname=="2"){
    testy$V1[i]="WALKING_UPSTAIRS"
  }
  if (oldname=="3"){
    testy$V1[i]="WALKING_DOWNSTAIRS"
  }
  if (oldname=="4"){
    testy$V1[i]="SITTING"
  }
  if (oldname=="5"){
    testy$V1[i]="STANDING"
  }
  if (oldname=="6"){
    testy$V1[i]="LAYING"
  }
}

# activity labels for trainy
for (i in 1:2947){
  oldnames <- trainy$V1
  oldname <- oldnames[i]
  if (oldname=="1"){
    trainy$V1[i]="WALKING"
  }
  if (oldname=="2"){
    trainy$V1[i]="WALKING_UPSTAIRS"
  }
  if (oldname=="3"){
    trainy$V1[i]="WALKING_DOWNSTAIRS"
  }
  if (oldname=="4"){
    trainy$V1[i]="SITTING"
  }
  if (oldname=="5"){
    trainy$V1[i]="STANDING"
  }
  if (oldname=="6"){
    trainy$V1[i]="LAYING"
  }
}

# bind test, train, and setsubject sets
newtest <- cbind(testx, testy, subjecttest)
newtrain <- cbind(trainx, trainy, subjecttrain)

# rename variable labels
features <- read.table("features.txt")
labels1 <- features$V2
labels1 <- as.character(labels1)

for (i in 1:562){
  colnames(newtest)[i] <- labels1[i]
}

for (i in 1:562){
  colnames(newtrain)[i] <- labels1[i]
}

# bind test and train data sets
total <- rbind(newtest, newtrain)
colnames(total)[562] <- "Activity"
colnames(total)[563] <- "Subject"

# extract std devs and means of measurements
extdata<- total[,c(1,2,3,41,42,43,81,82,83,121,122,123,161,
                        162,163,201,214,227,240,253,266,267,268,
                        345,346,347,424,425,426,503,516,529,542,
                        4,5,6,44,45,46,84,85,86,124,125,126,164,
                        165,166,202,215,228,241,254,269,270,271,
                        348,349,350,427,428,429,504,517,530,543,
                        562,563)]

# creates tidy data set with the average of each variable for each activity and each subject
tidydata<-aggregate(extdata[1:66], by=list(extdata$Subject, extdata$Activity), FUN=mean, na.rm=TRUE)
write.table(tidydata, file="tidytable.txt")