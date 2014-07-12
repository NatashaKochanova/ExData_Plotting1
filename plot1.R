# This code reads the data into R, subsets its part for 2007-02-01 and 2007-02-02 and makes a histogram of Global active power values.
# Note: before running the code the data should be downloaded and file "household_power_consumption.txt" should be unzipped into the working directory.

## Reading data into R
EPC <- read.table("household_power_consumption.txt", header=TRUE, na.strings=c("?"), sep=";")

## Subsetting data for 2007-02-01 and 2007-02-02
EPC$Date <- as.character(EPC$Date)
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")

EPCsub1 <- subset(EPC, EPC$Date=="2007-02-01")
EPCsub2 <- subset(EPC, EPC$Date=="2007-02-02")
EPCsub <- rbind(EPCsub1, EPCsub2)

## Making the histogram
par(ps = 12, cex = 1, cex.main = 1)
hist(EPCsub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Copying the histogram into "plot1.png"
dev.copy(png, file = "plot1.png", width=480, height=480, units="px")
dev.off()