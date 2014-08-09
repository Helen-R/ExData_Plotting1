# read txt file into table <dat>
data <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), skip=66637, nrows=2879, na.strings = "?")
# clean data
c <- complete.cases(data)
dat <- data[c,]

# transform date and time
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat$Time <- paste(dat$Date, dat$Time)
dat$Time <- strptime(dat$Time, "%Y-%m-%d %H:%M:%S")

# Plot four curves with size 480*480 in png device
# Plot1: Active power curve
# Plot2: Sub-meter curve
# Plot3: Voltage curve
# Plot4: Reactive power curve
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

with(dat, plot(Time, Global_active_power, type = "l", xlab="", ylab = "Global Active Power"))

with(dat, plot(Time, Sub_metering_1, type = "n", xlab="", ylab = "Energy sub metering"))
lines(dat$Time, dat$Sub_metering_1, col="black" )
lines(dat$Time, dat$Sub_metering_2, col="red" )
lines(dat$Time, dat$Sub_metering_3, col="blue" )
legend('topright', lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(dat, plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(dat, plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()