temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
dt <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE)
unlink(temp)

# dt <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

dt <- subset(dt, (dt$Date == "1/2/2007" | dt$Date == "2/2/2007"))
dt$DateTime <- paste(dt$Date, dt$Time, sep = " ")
dt$DateTime <- strptime(dt$DateTime, format = "%d/%m/%Y %H:%M:%S")

dt[3:9] <- lapply(dt[3:9], as.numeric)

png("plot2.png", width = 480, height = 480, bg = "transparent")
plot(dt$DateTime, dt$Global_active_power, type = "l",  main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
