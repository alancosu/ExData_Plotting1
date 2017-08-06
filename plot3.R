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

#plot 3 Sub-metering readings with time
png("plot3.png")
plot(hpc$DateTime, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc$DateTime, hpc$Sub_metering_1)
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2)
dev.off()
