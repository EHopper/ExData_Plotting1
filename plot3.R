library(lubridate)


fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")){dir.create("data")}
download.file(fileUrl,"data/rawdata.zip")
unzip("./data/rawdata.zip",exdir="./data")

colnamesdata=read.table("data/household_power_consumption.txt",nrows = 1,sep=";")
alldates=read.table("data/household_power_consumption.txt",skip=1,sep=";", 
                    colClasses = c(NA,rep("NULL",8)))
alldates=dmy(alldates[,1])
inds=which(alldates==ymd(20070201) | alldates==ymd(20070202))
alldata=read.table("data/household_power_consumption.txt",skip=inds[1],sep=";",
                nrows = length(inds))
names(alldata)=lapply(colnamesdata,as.character)
times=dmy_hms(paste(alldata[,1],alldata[,2]))


png(filename = "plot3.png",width=480,height = 480, units = "px")
plot(times,alldata$Global_active_power,type="n",xlab="",
     ylab = "Global Active Power (kilowatts)",ylim =c(0,38) )
lines(times,alldata$Sub_metering_1,col="black")
lines(times,alldata$Sub_metering_2,col="red")
lines(times,alldata$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"), 
       legend = lapply(names(alldata)[7:9],as.character))
dev.off()