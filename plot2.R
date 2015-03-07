#Reading the data
data = read.table("powerCons.txt",sep=";", dec=".",header=TRUE,stringsAsFactors=FALSE,na.strings="?",
                  colClasses=c(rep("character",2), rep("numeric",7)))
                  
#Subset according to date
DT<- subset(data,as.Date(data$Date,format='%d/%m/%Y')>=as.Date('2007-02-01',format='%Y-%m-%d'))
DT<- subset(DT,as.Date(DT$Date,format='%d/%m/%Y')<=as.Date('2007-02-02',format='%Y-%m-%d'))

ds<-DT #created a duplicate just to make sure nothing messes up

ds[[1]]<-strptime(ds[[1]],"%d/%m/%Y")#Format conversion

#create datetime variable by merging Date and Time
datetime <- paste(as.Date(ds$Date), ds$Time)

#convert to proper format
ds$Datetime <- as.POSIXct(datetime)

#plot graph
png(filename = "plot2.png",width = 480, height = 480)

plot(ds$Global_active_power~ds$Datetime, type="l",ylab="Global Active Power Kilowatts",xlab="")

dev.off()