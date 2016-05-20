#'
#' Functions for reading and generating plots of the "household power consumption" 
#' data set provided by the UC Irvine Machine Learning data repository.
#'
#' Use function genPlot4() to generate plot4.png.
#'


#'
#' read and filter data
#'
loadPowerData <- function(filename = "household_power_consumption.txt") {
    dd.power <- read.csv(filename, sep=";", na.strings="?")

    # filter out everything except feb1 and feb2
    dd.power <- subset(dd.power, Date == "1/2/2007" | Date == "2/2/2007")

    # concat Date & Time fields to single new field "DateTime", and convert it to date format.
    y <- paste(dd.power$Date, dd.power$Time)
    z <- strptime(y, "%d/%m/%Y %H:%M:%S") 
    dd.power$DateTime <- z

    dd.power # return the data frame
}

#'
#' load the data, generate plot4, and write it to file plot4.png.
#'
genPlot4 <- function(...) {
    dd.power <- loadPowerData(...)
    png(filename="plot4.png")
    plot4(dd.power)
    dev.off()
}

#'
#' Plot dd.power$DateTime vs Global_active_power
#' Note: this method is copied from plot2.R
#'
plot2 <- function(dd.power) {
    plot(dd.power$DateTime, dd.power$Global_active_power, xlab="",  ylab="Global Active Power (kilowatts)", type="n")
    lines(dd.power$DateTime, dd.power$Global_active_power)
}

#'
#' Plot dd.power$DateTime vs Sub_metering_1, Sub_metering_2, and Sub_metering_3
#' Note: this method is copied from plot3.R
#'
plot3 <- function(dd.power) {

    plot(dd.power$DateTime, dd.power$Sub_metering_1, xlab="", ylab="", type="n")
    title(ylab="Energy sub metering")
    lines(dd.power$DateTime, dd.power$Sub_metering_1)
    lines(dd.power$DateTime, dd.power$Sub_metering_2, col="red")
    lines(dd.power$DateTime, dd.power$Sub_metering_3, col="blue")
    legend(x="topright", 
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           lty=c("solid","solid","solid"), 
           lwd=c(2,2,2), 
           col=c("black","red","blue"))
}

#'
#' Plot dd.power$DateTime vs dd.power$Global_reactive_power
#'
plot4d <- function(dd.power) {
    with(dd.power, plot(DateTime, Global_reactive_power, type="n"))
    with(dd.power, lines(DateTime, Global_reactive_power))
}

#'
#' Plot dd.power$DateTime vs dd.power$Voltage
#'
plot4b <- function(dd.power) {
    with(dd.power, plot(DateTime, Voltage, type="n"))
    with(dd.power, lines(DateTime, Voltage))
}

#'
#' Plot 4 is a single graphic with 4 plots:
#'      a. Global_active_power (plot2)
#'      b. Voltage
#'      c. Energy sub metering (plot3)
#'      d. Global_reactive_power
#' 
plot4 <- function(dd.power) {
    par(mfrow = c(2,2))

    plot2(dd.power)
    plot4b(dd.power)
    plot3(dd.power)
    plot4d(dd.power)
}



