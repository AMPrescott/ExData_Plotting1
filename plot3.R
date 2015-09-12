##This file reads in electric power consumption data from the UC Irvine Machine Learning Repository.
##This data is used to create a time course plot for the 3 sub metering measurements

#Unzip the downloaded zip file of included data into your working directory
unzip("exdata-data-household_power_consumption.zip")

#read in data frame
elecConsData <- read.table('household_power_consumption.txt', sep =";", header = T, na.strings = "?", stringsAsFactors = FALSE, dec = '.', quote = "", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#Convert $Date to class Date from character
elecConsData$Date <- as.Date(elecConsData$Date, format = "%d/%m/%Y")

#Extract dates of interest (Feb.1 - Feb.2, 2007)
elecConsData <- elecConsData[elecConsData$Date == as.Date("2007-2-2") | elecConsData$Date == as.Date("2007-2-1"),]

#Merge the Date and Time columns of elecConsData as class character and make new data frame with $Sub_metering_#
elecConsData <- as.data.frame(cbind(paste(as.character(elecConsData$Date), elecConsData$Time, sep = ' '), elecConsData$Sub_metering_1, elecConsData$Sub_metering_2,elecConsData$Sub_metering_3), stringsAsFactors = F)

#Name columnes of the new resized data frame
colnames(elecConsData) <- c("Date_Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#convert the Date_Time column from character to POSIXlt
elecConsData$Date_Time <-  strptime(elecConsData$Date_Time, format = "%Y-%m-%d %H:%M:%S")

#open png graphics device
png(filename = "plot3.png", width = 480, height = 480)

#Plot the line plot for $Sub_metering_1
plot(elecConsData$Date_Time, as.numeric(elecConsData$Sub_metering_1), ylab = "Energy sub metering", xlab = '', type = 'l')
#Lock the axis to add additional elements
par(new=T)
#Add lines for Sub_metering_(2|3)
lines(elecConsData$Date_Time, as.numeric(elecConsData$Sub_metering_2), col = "red")
lines(elecConsData$Date_Time, as.numeric(elecConsData$Sub_metering_3), col = "blue")
#Add legend to the graph
legend("topright", legend = names(elecConsData)[2:4], lty = 1, lwd = 2, col = c("black","red","blue"))
par(new=F)
#Close the graphics device
dev.off()
