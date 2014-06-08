## download, unzip, and read into dataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
EPCdata <-read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

## convert date field from class factor into class date
EPCdata$Date <- as.Date(EPCdata$Date,format="%d/%m/%Y")

## subset data for dates from 2007-02-01 to 2007-02-02
EPCsubset <- subset(EPCdata, EPCdata$Date %in% as.Date(c("2007-02-01", "2007-02-02")))

## convert variable of interest from factor into numeric for correct scaling in plots
## I first tried directly converting to numeric but ended up with very large numbers.
## Then found thread https://class.coursera.org/exdata-002/forum/thread?thread_id=99#post-359
## where various people suggested converting first to character before to numeric
## because the var contains small decimal numbers as factors, and converting them 
## directly to numeric makes "whole" numbers out of them
EPCsubset$Global_active_power <- as.numeric(as.character(EPCsubset$Global_active_power)) 

## construct plot 1
hist(EPCsubset$Global_active_power,   
     col ="red",
     xlab ="Global Active Power (kilowatts)",
     main ="Global Active Power")

## save to PNG with width=480 and height=480
dev.copy(png, file= "plot1.png", width = 480, height = 480)
dev.off()
