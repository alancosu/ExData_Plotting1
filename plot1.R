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

#Plot histogram of Global Active Power
png("plot1.png")
hist(hpc$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()
