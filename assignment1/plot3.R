#'
#' Functions for reading and generating plots of the "household power consumption" 
#' data set provided by the UC Irvine Machine Learning data repository.
#'
#' Use function genPlot3() to generate plot3.png.
#'

#'
#' read and filter data
#'
#' Note: this method is duplicated in plot1.R, plot2.R, plot3.R, plot4.R
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
#' Plot dd.power$DateTime vs Sub_metering_1, Sub_metering_2, and Sub_metering_3
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
#' Load the data, generate plot3, and write it to file plot3.png
#' 
genPlot3 <- function(...) {
    dd.power <- loadPowerData(...)
    png(filename="plot3.png")
    plot3(dd.power)
    dev.off()
}



