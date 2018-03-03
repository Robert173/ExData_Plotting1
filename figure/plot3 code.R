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

dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

par(mar = c(5, 4, 4, 1))

with(dat, {
  plot(Sub_metering_1 ~ date_time, type = "l", xlab = "",
        ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ date_time, type = "l", col = "red")
  lines(Sub_metering_3 ~ date_time, type = "l", col = "blue")
} )

legend("topright", col = c("black", "red", "blue"), 
  lwd = c(1, 1, 1), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
  xpd = TRUE)

dev.copy(png, file = "plot3.png", height = 480, width = 480)


dev.off()

