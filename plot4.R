##This file reads in electric power consumption data from the UC Irvine Machine Learning Repository.
##This data is used to create a 4 subplots from the above data

#Unzip the downloaded zip file of included data into your working directory
unzip("exdata-data-household_power_consumption.zip")

#read in data frame
elecConsData <- read.table('household_power_consumption.txt', sep =";", header = T, na.strings = "?", stringsAsFactors = FALSE, dec = '.', quote = "", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#Convert $Date to class Date from character
elecConsData$Date <- as.Date(elecConsData$Date, format = "%d/%m/%Y")

#Extract dates of interest (Feb.1 - Feb.2, 2007)
elecConsData <- elecConsData[elecConsData$Date == as.Date("2007-2-2") | elecConsData$Date == as.Date("2007-2-1"),]

#Merge the Date and Time columns of elecConsData as class character and make new data frame with $Sub_metering_#
date_Time <- paste(as.character(elecConsData$Date), elecConsData$Time, sep = ' ')

#convert the date_Time from character to POSIXlt
date_Time <-  strptime(date_Time, format = "%Y-%m-%d %H:%M:%S")

#open png graphics device
png(filename = "plot4.png", width = 480, height = 480)

#Create the canvas for 4 subplots
par(mfcol = c(2,2))

#Plot the line plot for $Global_active_power
plot(date_Time, as.numeric(elecConsData$Global_active_power), ylab = "Global Active Power", xlab = '', type = 'l')

#Plot the line plot for $Sub_metering_1
plot(date_Time, as.numeric(elecConsData$Sub_metering_1), ylab = "Energy sub metering", xlab = '', type = 'l')
#Lock the axis to add additional elements
par(new=T)
#Add lines for Sub_metering_(2|3)
lines(date_Time, as.numeric(elecConsData$Sub_metering_2), col = "red")
lines(date_Time, as.numeric(elecConsData$Sub_metering_3), col = "blue")
#Add legend to the graph
legend("topright", legend = names(elecConsData)[7:9], lty = 1, lwd = 2, col = c("black","red","blue"), bty = "n")
par(new=F)

#Plot a time course plot for voltage
plot(date_Time, as.numeric(elecConsData$Voltage), ylab = "Voltage", xlab = 'datetime', type = 'l')

#Plot a time course plot for global_reactive_power
plot(date_Time, as.numeric(elecConsData$Global_reactive_power), ylab = "Voltage", xlab = 'datetime', type = 'l')


#Close the graphics device
dev.off()
