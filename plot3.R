library(lubridate)

# Load the data
RawData <- read.table("./data/household_power_consumption.txt", sep = ";",header = TRUE)

# Convert the date to "Date" class
AllDates <- as.Date(RawData$Date,"%d/%m/%Y")

# Select only those rows which correspond to First and Second of February 2007
ReqdData <- RawData[year(AllDates)==2007 & month(AllDates)==02 & day(AllDates)<3,]
ReqdData$DateTime <- paste(as.character(ReqdData$Date),as.character(ReqdData$Time))

# Open png graphics device
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
par(mfrow=c(1,1))

# Obtain the required plot
plot(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_1)),type = "l", ylab="Energy sub metering",xlab = " ",lty = 1,col="black")
lines(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_2)),type = "l",col="red")
lines(dmy_hms(ReqdData$DateTime),as.numeric(as.character(ReqdData$Sub_metering_3)),type = "l",col="blue")
# Create the legend
legend("topright",col = c("black","red","blue"),lty = c(1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close the graphics device
dev.off()
