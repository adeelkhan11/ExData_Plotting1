load_data <- function(file, dates) {
    ## Loads household energy data from the file and the dates specified.
    
    data <- read.table(file, header=TRUE, sep=";", colClasses = "character")
    subset <- data[data$Date %in% dates, ]
    subset$Time <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    subset$Date <- as.Date(subset$Date, "%d/%m/%Y")
    subset$Global_active_power <- as.numeric(subset$Global_active_power)
    subset
}

plot1 <- function() {
    ## Create a histogram of the Global Active Power
    
    # Read data from file
    subset <- load_data("household_power_consumption.txt"
                        , c("1/2/2007", "2/2/2007"))
    
    # Plot a histogram in a png file
    png(filename="plot1.png")
    hist(subset$Global_active_power
         , xlab="Global Active Power (kilowatts)"
         , main="Global Active Power"
         , breaks=12
         , col="red")
    dev.off()
}
