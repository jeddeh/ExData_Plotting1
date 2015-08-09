temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
dt <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE)
unlink(temp)

# dt <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

dt <- subset(dt, (dt$Date == "1/2/2007" | dt$Date == "2/2/2007"))
dt$DateTime <- paste(dt$Date, dt$Time, sep = " ")
dt$DateTime <- strptime(dt$DateTime, format = "%d/%m/%Y %H:%M:%S")

dt[3:9] <- lapply(dt[3:9], as.numeric)

png("plot4.png", width = 480, height = 480, bg = "transparent")

par(mfcol = c(2, 2))
plot(dt$DateTime, dt$Global_active_power, type = "l",  main = "", xlab = "", ylab = "Global Active Power")

plot(dt$DateTime, dt$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering", type = "n")
lines(dt$DateTime, dt$Sub_metering_1, col = "black")
lines(dt$DateTime, dt$Sub_metering_2, col = "red")
lines(dt$DateTime, dt$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 2.5, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dt$DateTime, dt$Voltage, type = "l",  main = "", xlab = "datetime", ylab = "Voltage")

plot(dt$DateTime, dt$Global_reactive_power, type = "l",  main = "", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
