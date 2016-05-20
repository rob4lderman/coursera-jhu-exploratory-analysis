#'
#' Functions for reading and generating plots of the "household power consumption" 
#' data set provided by the UC Irvine Machine Learning data repository.
#'
#' Use function genPlot2() to generate plot2.png.
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
#' Plot dd.power$DateTime vs Global_active_power
#'
plot2 <- function(dd.power) {
    plot(dd.power$DateTime, dd.power$Global_active_power, xlab="",  ylab="Global Active Power (kilowatts)", type="n")
    lines(dd.power$DateTime, dd.power$Global_active_power)
}

#'
#' load the data, generate plot2, and write it to file plot2.png.
#'
genPlot2 <- function(...) {
    dd.power <- loadPowerData(...)
    png(filename="plot2.png")
    plot2(dd.power)
    # dev.copy(png, filename="plot2.png")
    dev.off()
}


