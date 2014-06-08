## download, unzip, and read into dataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
EPCdata <-read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

## convert date field from class factor into class date
EPCdata$Date <- as.Date(EPCdata$Date,format="%d/%m/%Y")

## subset data for dates from 2007-02-01 to 2007-02-02
EPCsubset <- subset(EPCdata, EPCdata$Date %in% as.Date(c("2007-02-01", "2007-02-02")))

## create a new var combining date and time
## used advice by community TA on https://class.coursera.org/exdata-002/forum/thread?thread_id=77#post-268
EPCsubset$datetime <- as.POSIXct(paste(EPCsubset$Date,EPCsubset$Time))

## convert variables of interest from factor into numeric for correct scaling in plots
## I first tried directly converting to numeric but ended up with very large numbers.
## Then found thread https://class.coursera.org/exdata-002/forum/thread?thread_id=99#post-359
## where various people suggested converting first to character before to numeric
## because the var contains small decimal numbers as factors, and converting them 
## directly to numeric makes "whole" numbers out of them
EPCsubset$Global_active_power <- as.numeric(as.character(EPCsubset$Global_active_power)) 
EPCsubset$Sub_metering_1 <- as.numeric(as.character(EPCsubset$Sub_metering_1)) 
EPCsubset$Sub_metering_2 <- as.numeric(as.character(EPCsubset$Sub_metering_2)) 
EPCsubset$Sub_metering_3 <- as.numeric(as.character(EPCsubset$Sub_metering_3)) 
EPCsubset$Voltage <- as.numeric(as.character(EPCsubset$Voltage)) 
EPCsubset$Global_reactive_power <- as.numeric(as.character(EPCsubset$Global_reactive_power)) 

## construct plot 4 for viewing on screen
par(mfcol = c(2,2))
plot(EPCsubset$datetime,EPCsubset$Global_active_power, type ="l",
     ylab ="Global Active Power", xlab = "")  
plot(EPCsubset$datetime,EPCsubset$Sub_metering_1, type ="l",
     ylab ="Energy sub metering", xlab = "") 
lines(EPCsubset$datetime,EPCsubset$Sub_metering_2,col="red")
lines(EPCsubset$datetime,EPCsubset$Sub_metering_3,col="blue")
legend("topright",lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")
plot(EPCsubset$datetime,EPCsubset$Voltage, type = "l",
     xlab="datetime", ylab="Voltage")
plot(EPCsubset$datetime,EPCsubset$Global_reactive_power, type = "l",
     xlab="datetime", ylab="Global_reactive_power")

## plot to PNG with width=480 and height=480
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
plot(EPCsubset$datetime,EPCsubset$Global_active_power, type ="l",
     ylab ="Global Active Power", xlab = "")  
plot(EPCsubset$datetime,EPCsubset$Sub_metering_1, type ="l",
     ylab ="Energy sub metering", xlab = "") 
lines(EPCsubset$datetime,EPCsubset$Sub_metering_2,col="red")
lines(EPCsubset$datetime,EPCsubset$Sub_metering_3,col="blue")
legend("topright",lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")
plot(EPCsubset$datetime,EPCsubset$Voltage, type = "l",
     xlab="datetime", ylab="Voltage")
plot(EPCsubset$datetime,EPCsubset$Global_reactive_power, type = "l",
     xlab="datetime", ylab="Global_reactive_power")
dev.off() 
