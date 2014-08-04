# Exploratory Data Analysis
# Assignment 1 / Plot 4

# The reproducible way to download/unzip the data file.
# If the data files are already in the current WD, you can skip this step.  
fileName <- "household_power_consumption.txt"
fileNameZip <- "exdata-data-household_power_consumption.zip"
fileDest <- paste("./", fileName, sep = "")
fileDestZip <- paste("./", fileNameZip, sep = "")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


if (file.exists(fileName)) { ## Checks if the file exists in the current WD
    message(" Data file already exists in the currentWD")
} else { ## If the file does not exist
    if (file.exists(fileNameZip)) { ## Checks if the zip file exists
        message("Unzipping the data folder in the current WD")
        unzip(fileNameZip, fileName) ## Unzipping the file into current WD
    } else { ## If there is no un/zipped file then download and unzip
        message("Downloading and unzipping the data folder into in the created './data' directory")
        if (!file.exists("./data")) {
            dir.create("./data")  ## Creates ./data for data files
        }
        setwd("./data") ## Setting up the working directory.
        download.file(fileURL, fileDestZip, method = "auto")
        unzip(fileNameZip, fileName)
    }
}


# Reading the whole data set with defining the NA's, column classes and decimals
EPC <- read.csv2("./household_power_consumption.txt", header=TRUE, quote="", 
                 dec = ".", na.strings = "?", 
                 colClasses = c(rep("character", 2), rep("numeric", 7)),
                 comment.char="")

# Subsetting the data
data <- EPC[with(EPC, Date == "1/2/2007" | Date == "2/2/2007"), ]

# Combining the "Data" and "Time" and writing as POSIXlt class into "Daytime"
data$DayTime <- as.POSIXlt(strptime(paste(data$Date, data$Time), 
                                    "%d/%m/%Y %H:%M:%S"))

# Plot 4
png(file = "plot4.png", bg = "white", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
plot(data$DayTime, data$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
plot(data$DayTime, data$Voltage, type = "l", ylab = "Voltage", 
     xlab = "datetime",)
plot(data$DayTime, data$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")
plot.xy(xy.coords(data$DayTime, data$Sub_metering_2), type = "l", col = "red")
plot.xy(xy.coords(data$DayTime, data$Sub_metering_3), type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), lty = c(1,1,1), 
       col = c("black", "red", "blue"), bty = "n")
plot(data$DayTime, data$Global_reactive_power, type = "l", lwd = 0.1,
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
