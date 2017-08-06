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

#Plot Global Active Power with time
png("plot2.png")
with(hpc, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
