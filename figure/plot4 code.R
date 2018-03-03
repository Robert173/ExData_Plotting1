setwd("/Users/Chet/Documents/Exploratory Graphics Project 1")

dat <- read.table("household_power_consumption.txt", header = TRUE,
                  sep = ";")


dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

dat <- subset(dat, Date >= as.Date("2007-2-1") 
              & Date <= as.Date("2007-2-2"))
dat <- na.omit(dat)

date_time <- paste(dat$Date, dat$Time)
dat <- cbind(date_time, dat)

dat$date_time <- as.POSIXct(date_time)

dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))

dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

png("plot4.png", height = 480, width = 480)

par(mfrow = c(2,2), mar = c(5, 4, 4, 1))


with(dat, plot(Global_active_power ~ date_time, type = "l", 
               xlab = "", ylab = "Global Active Power (kilowatts)"))

with(dat, plot(Voltage ~ date_time, type = "l", xlab = "datetime",
               ylab = "Voltage"))

with(dat, {
  plot(Sub_metering_1 ~ date_time, type = "l", xlab = "",
       ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ date_time, type = "l", col = "red")
  lines(Sub_metering_3 ~ date_time, type = "l", col = "blue")
})

legend("topright", col = c("black", "red", "blue"), 
       lwd = c(1, 1, 1), c("Sub_metering_1",
       "Sub_metering_2", "Sub_metering_3"), xpd = TRUE, bty = "n") 
   

with(dat, plot(Global_reactive_power ~ date_time, type = "l", xlab = "datetime",
               ylab = "Global_reactive_power"))

dev.off()
