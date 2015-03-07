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

# collect x and y axes ranges 
  xrange=range(ds$Datetime)
  yrange=range(ds$Sub_metering_1)
# plot empty graph
  png(filename="plot3.png",width=480,height=480)
  plot(xrange, yrange, type="n",ylab="Sub_Meterings",xlab="" )
# plot the respective lines
  lines(ds$Sub_metering_1~ds$Datetime,type="l",col="black")
  lines(ds$Sub_metering_2~ds$Datetime,type="l",col="red")
  lines(ds$Sub_metering_3~ds$Datetime,type="l",col="blue")
# Put up the legend  
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1.5)
# Close the graphic device  
  dev.off()