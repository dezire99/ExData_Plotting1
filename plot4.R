library(lubridate)

# Load the data
RawData <- read.table("./data/household_power_consumption.txt", sep = ";",header = TRUE)

# Convert the date to "Date" class
AllDates <- as.Date(RawData$Date,"%d/%m/%Y")

# Select only those rows which correspond to First and Second of February 2007
ReqdData <- RawData[year(AllDates)==2007 & month(AllDates)==02 & day(AllDates)<3,]
ReqdData$DateTime <- paste(as.character(ReqdData$Date),as.character(ReqdData$Time))

# Open png graphics device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
par(mfcol=c(2,2))

# Obtain the required plot in 1,1 (Global active power vs datetime)
plot(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Global_active_power)),type = "l", ylab="Global Active Power",xlab = " ",lty = 1)

# Obtain the required plot in 2,1 (Energy sub metering vs datetime)
plot(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_1)),type = "l", ylab="Energy sub metering",xlab = " ",lty = 1,col="black")
lines(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_2)),type = "l",col="red")
lines(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_3)),type = "l",col="blue")
# Create the legend
legend("topright",col = c("black","red","blue"),lty = c(1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Obtain the required plot in 1,2 (Voltage vs datetime)
plot(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Voltage)),type = "l", ylab="Voltage",xlab = "datetime",lty = 1)

# Obtain the required plot in 2,2 (Global reactive power vs datetime)
plot(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Global_reactive_power)),type = "l", ylab="Global_reactive_power",xlab = "datetime",lty = 1)


# Close the graphics device
dev.off()
