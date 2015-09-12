##This file reads in electric power consumption data from the UC Irvine Machine Learning Repository.
##This data is used to create a a time course plot of Global active power

#Unzip the downloaded zip file of included data into your working directory
unzip("exdata-data-household_power_consumption.zip")

#read in data frame
elecConsData <- read.table('household_power_consumption.txt', sep =";", header = T, na.strings = "?", stringsAsFactors = FALSE, dec = '.', quote = "", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#Convert $Date to class Date from character
elecConsData$Date <- as.Date(elecConsData$Date, format = "%d/%m/%Y")

#Extract dates of interest (Feb.1 - Feb.2, 2007)
elecConsData <- elecConsData[elecConsData$Date == as.Date("2007-2-2") | elecConsData$Date == as.Date("2007-2-1"),]

#Merge the Date and Time columns of elecConsData as class character and make new data frame with $Global_active Power
elecConsData <- as.data.frame(cbind(paste(as.character(elecConsData$Date), elecConsData$Time, sep = ' '), elecConsData$Global_active_power), stringsAsFactors = F)

#Name columnes of the new resized data frame
colnames(elecConsData) <- c("Date_Time", "Global_active_power")

#convert the Date_Time column from character to POSIXlt
elecConsData$Date_Time = strptime(elecConsData$Date_Time, format = "%Y-%m-%d %H:%M:%S")

#open png graphics device
png(filename = "plot2.png", width = 480, height = 480)

#Plot the line plot for $Global_active_power
plot(elecConsData$Date_Time, as.numeric(elecConsData$Global_active_power), ylab = "Global Active Power (kilowatts)", xlab = '', type = 'l')

#Close the graphics device
dev.off()
