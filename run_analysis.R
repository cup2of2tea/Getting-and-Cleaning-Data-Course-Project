tr = read.csv("UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
te = read.csv("UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)
tr[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt",sep="",header=FALSE)
te[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt",sep="",header=FALSE)
tr[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
te[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)

tot = rbind(tr,te)

fe <- read.csv("UCI HAR Dataset/features.txt",sep="",header=FALSE)
meanStd <- grep("mean|std",fe[,2])
fe <- fe[meanStd,]
meanStd <- c(meanStd,562,563)
tot <- tot[,meanStd]
colnames(tot) <- c(tolower(fe[,2]),"activity","subject")

act <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
i<-1
for (label in act$V2)
{
  tot$activity <- gsub(i,label,tot$activity)
  i=i+1
}
tid = aggregate(tot,by=list(activity=as.factor(tot$activity),subject=as.factor(tot$subject)),mean)
tid <- tid[,1:48]
write.table(tid, file="tid.txt",row.name=FALSE)
