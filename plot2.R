# Exploratory Data Analysis
# Assignment 1 / Plot 2

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
# Plot 2
png(file = "plot2.png", bg = "white", width = 480, height = 480, units = "px")
plot(data$DayTime, data$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", type = "l", xlab = "")
dev.off()