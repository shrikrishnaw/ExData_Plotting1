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
ds$Datetime <- as.POSIXct(datetime)#Reading the data
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

#Png file opens  
  png(filename="plot4.png",width=480,height=480)
 # Set multiple figure by column
  par(mfcol=c(2,2))
# Graph 1  
  plot(ds$Global_active_power~ds$Datetime, type="l",ylab="Global Active Power Kilowatts",xlab="")
  #Graph 2
  yrange=range(ds$Sub_metering_1)
  plot(xrange, yrange, type="n",ylab="Sub_Meterings",xlab="" )
  lines(ds$Sub_metering_1~ds$Datetime,type="l",col="black")
  lines(ds$Sub_metering_2~ds$Datetime,type="l",col="red")
  lines(ds$Sub_metering_3~ds$Datetime,type="l",col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1.5)
#graph 3
yrange=range(ds$Voltage)
  plot(xrange, yrange, type="n",ylab="Voltage",xlab="datetime" )
  lines(ds$Voltage~ds$Datetime)
#graph 4
yrange=range(ds$Global_reactive_power)
  plot(xrange, yrange, type="n",ylab="Global_reactive_power",xlab="datetime" )
  lines(ds$Global_reactive_power~ds$Datetime)
  #close and save png 
  dev.off()