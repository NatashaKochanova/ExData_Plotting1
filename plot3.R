# This code reads the data into R, subsets its part for 2007-02-01 and 2007-02-02 and makes a plot (Date+Time against Energy sub metering).
# Note: before running the code the data should be downloaded and file "household_power_consumption.txt" should be unzipped into the working directory.

## Reading data into R
EPC <- read.table("household_power_consumption.txt", header=TRUE, na.strings=c("?"), sep=";")

## Subsetting data for 2007-02-01 and 2007-02-02
EPC$Date <- as.character(EPC$Date)
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")

EPCsub1 <- subset(EPC, EPC$Date=="2007-02-01")
EPCsub2 <- subset(EPC, EPC$Date=="2007-02-02")
EPCsub <- rbind(EPCsub1, EPCsub2)

## Combining Date and Time columns
EPCsub$Date <- as.Date(EPCsub$Date)
EPCsub$datetime <- paste(EPCsub$Date, EPCsub$Time)
EPCsub$datetime <- strptime(EPCsub$datetime, "%Y-%m-%d %H:%M:%S")

## Making the plot
par(ps = 12, cex = 1, cex.main = 1)
Sys.setlocale(category = "LC_ALL", locale = "English_USA")
plot(EPCsub$datetime, EPCsub$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(EPCsub$datetime, EPCsub$Sub_metering_2, col="red")
lines(EPCsub$datetime, EPCsub$Sub_metering_3, col="blue")
legend("topright", lwd=1, lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.8, text.font=1)

## Copying the plot into "plot3.png"
dev.copy(png, file = "plot3.png", width=480, height=480, units="px")
dev.off()