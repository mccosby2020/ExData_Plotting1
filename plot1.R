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
# open png device to output the plot
png(filename = "plot1.png", width = 480,height = 480)
# plot to the file
hist(dataset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# close the png device and file will be located in R home directory
dev.off()