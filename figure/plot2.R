# read txt file into table <dat>
data <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), skip=66637, nrows=2879, na.strings = "?")
# clean data
c <- complete.cases(data)
dat <- data[c,]

# transform date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat$Time <- paste(dat$Date, dat$Time)
dat$Time <- strptime(dat$Time, "%Y-%m-%d %H:%M:%S")

# Plot Active power curve with size 480*480 in png device
png(filename = "plot2.png", width = 480, height = 480)
with(dat, plot(Time, Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)"))
dev.off()

## PS:
## The x-axis automatically translate "Thu", "Fri", "Sat" into Mandarin...
## Not sure how to fix it yet.