#'
#' Functions for reading and generating plots of the "household power consumption" 
#' data set provided by the UC Irvine Machine Learning data repository.
#'
#' Use function genPlot1() to generate plot1.png.
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
#' Plot histogram of $Global_active_power
#'
plot1 <- function(dd.power) {
    hist(dd.power$Global_active_power, col="red", xlab="Global active power (kilowatts)", main="Global Active Power")
}

#'
#' Read the data, gen plot1, and write it to plot1.png
#'
genPlot1 <- function(...) {
    dd.power <- loadPowerData(...)
    png(filename="plot1.png")
    plot1(dd.power)
    dev.off()
}



