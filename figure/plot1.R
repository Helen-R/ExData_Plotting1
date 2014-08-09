# read txt file into table <dat>
dat <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), skip=66637, nrows=2879)

# transform date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat$Time <- paste(dat$Date, dat$Time)
dat$Time <- strptime(dat$Time, "%Y-%m-%d %H:%M:%S")

# Plot histogram with size 480*480 in png device
png(filename = "plot1.png", width = 480, height = 480)
with(dat, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()