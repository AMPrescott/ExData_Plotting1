##This file reads in electric power consumption data from the UC Irvine Machine Learning Repository.
##This data is used to create a PNG histogram for power usage levels.

#Unzip the downloaded zip file of included data into your working directory
unzip("exdata-data-household_power_consumption.zip")

#read in data frame
elecConsData <- read.table('household_power_consumption.txt', sep =";", header = T, na.strings = "?", stringsAsFactors = F)

#Convert $Date to class Date from character
elecConsData$Date <- as.Date(elecConsData$Date, format = "%d/%m/%Y")

#Extract dates of interest (Feb.1 - Feb.2, 2007)
elecConsData <- elecConsData[elecConsData$Date == as.Date("2007-2-2") | elecConsData$Date == as.Date("2007-2-1"),]

#open png graphics device
png(filename = "plot1.png", width = 480, height = 480)
#Plot the histogram for $Global_active_power
hist(elecConsData$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

#Close the graphics device
dev.off()
