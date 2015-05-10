load_data <- function(file, dates) {
    ## Loads household energy data from the file and the dates specified.
    
    data <- read.table(file, header=TRUE, sep=";", colClasses = "character")
    subset <- data[data$Date %in% dates, ]
    subset$Time <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    subset$Date <- as.Date(subset$Date, "%d/%m/%Y")
    subset$Global_active_power <- as.numeric(subset$Global_active_power)
    subset$Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
    subset$Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
    subset$Sub_metering_3 <- as.numeric(subset$Sub_metering_3)
    subset
}

plot3 <- function() {
    ## Create a plot and save it into a png file
    
    # Read data from file
    subset <- load_data("household_power_consumption.txt"
                        , c("1/2/2007", "2/2/2007"))
    
    # Plot in a png file
    png(filename="plot3.png")
    with(subset, plot(Time
                      , Sub_metering_1
                      , type="n"
                      , xlab=""
                      , ylab="Energy sub metering"))
    with(subset, lines(Time, Sub_metering_1))
    with(subset, lines(Time, Sub_metering_2, col="red"))
    with(subset, lines(Time, Sub_metering_3, col="blue"))
    legend("topright", lty=1, col = c("black", "red", "blue")
           , legend = c("Sub_metering_1",
                        "Sub_metering_2",
                        "Sub_metering_3"))
    dev.off()
}
