library(lubridate)

# Load the data
RawData <- read.table("./data/household_power_consumption.txt", sep = ";",header = TRUE)

# Convert the date to "Date" class
AllDates <- as.Date(RawData$Date,"%d/%m/%Y")

# Select only those rows which correspond to First and Second of February 2007
ReqdData <- RawData[year(AllDates)==2007 & month(AllDates)==02 & day(AllDates)<3,]

# Open png graphics device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
par(mfrow=c(1,1))

# Obtain the required plot
with(ReqdData,hist(as.numeric(as.character(Global_active_power)),xlab="Global Active Power (kilowatts)",col="red",main = "Global Active Power"))

# Close the graphics device
dev.off()
