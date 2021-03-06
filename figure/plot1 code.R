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
par(mar = c(5, 4, 2, 1))
with(dat, hist(Global_active_power, main = "Global Active Power",
                   xlab = "Global Active Power (kilowatts)", col = "red"))

dev.copy(png, file = "plot1.png", height = 480, width = 480)


dev.off()
