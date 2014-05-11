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
EPCsubset$Sub_metering_1 <- as.numeric(as.character(EPCsubset$Sub_metering_1)) 
EPCsubset$Sub_metering_2 <- as.numeric(as.character(EPCsubset$Sub_metering_2)) 
EPCsubset$Sub_metering_3 <- as.numeric(as.character(EPCsubset$Sub_metering_3)) 

## construct plot 3 for viewing on screen
plot(EPCsubset$datetime,EPCsubset$Sub_metering_1,
     type ="l",
     ylab ="Energy sub metering",
     xlab = "") 
lines(EPCsubset$datetime,EPCsubset$Sub_metering_2,col="red")
lines(EPCsubset$datetime,EPCsubset$Sub_metering_3,col="blue")
legend("topright",lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

## plot to PNG with width=480 and height=480
png(filename = "plot3.png", width = 480, height = 480)
plot(EPCsubset$datetime,EPCsubset$Sub_metering_1,
     type ="l",
     ylab ="Energy sub metering",
     xlab = "") 
lines(EPCsubset$datetime,EPCsubset$Sub_metering_2,col="red")
lines(EPCsubset$datetime,EPCsubset$Sub_metering_3,col="blue")
legend("topright",lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()

