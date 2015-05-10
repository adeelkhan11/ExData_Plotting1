load_data <- function(file, dates) {
    ## Loads household energy data from the file and the dates specified.
    
    data <- read.table(file, header=TRUE, sep=";", colClasses = "character")
    subset <- data[data$Date %in% dates, ]
    subset$Time <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    subset$Date <- as.Date(subset$Date, "%d/%m/%Y")
    subset$Global_active_power <- as.numeric(subset$Global_active_power)
    subset
}

plot2 <- function() {
    ## Create a plot and save it into a png file
    
    # Read data from file
    subset <- load_data("household_power_consumption.txt"
                        , c("1/2/2007", "2/2/2007"))
    
    # Plot in a png file
    png(filename="plot2.png")
    with(subset, plot(Time
                      , Global_active_power
                      , type="n"
                      , xlab=""
                      , ylab="Global Active Power (kilowatts)"))
    with(subset, lines(Time, Global_active_power))
    dev.off()
}
