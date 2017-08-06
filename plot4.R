#Download, unzip file, & read in
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, mode = "wb")
unzip(temp)
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

#Combine Date & Time and subset for selected dates
hpc$DateTime <- paste(hpc$Date, hpc$Time); hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %T")
hpc <- subset(hpc, hpc$DateTime >= "2007-02-01" & hpc$DateTime < "2007-02-03")

#Combined plot of Global Active Power, sub-metering, Voltage & Global Reactive Power with time
png("plot4.png")
par(mfcol = c(2,2))
with(hpc, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
plot(hpc$DateTime, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc$DateTime, hpc$Sub_metering_1)
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2)
with(hpc, plot(DateTime, Voltage, type = "l"))
with(hpc, plot(DateTime, Global_reactive_power, type = "l"))
dev.off()