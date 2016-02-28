# file name we will be processing is held in variable fileName
fileName <- "household_power_consumption.txt"
# check to see if the file is already exist in home directory else download and unzip it
if (!file.exists(fileName))
{
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile = "consumption.zip")
    unzip.file(zipfile ="consumption.zip")
}
# read into dataset variable for only [1/2] of /2/2007 data
dataset<- read.table(text = grep("^[1,2]/2/2007", readLines(fileName), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
dataset$Date <- as.Date(dataset$Date,format="%d/%m/%Y")
#generate vector Datetime to hold combination of date and time
Datetime <- paste(as.Date(dataset$Date),dataset$Time)
# Add new column Datetime to dataset to hold datetime values
dataset$Datetime <- as.POSIXct(Datetime)
#open png device to output the plot 3
png(filename = "plot4.png", width = 480,height = 480)
# plot to the file
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dataset, {
    plot(Global_active_power ~ Datetime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
         xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ Datetime, type = "l", 
         ylab = "Global_rective_power", xlab = "datetime")
})
# close the png device and file will be located in R home directory
dev.off()