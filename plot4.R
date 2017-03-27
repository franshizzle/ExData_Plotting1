## Exploratory Data Analysis
## Week 1 Course Project
## Francis Brua
## PLOT 4

library(RCurl)
library(data.table)

## Download the data from UCI

FilePath <- "e:/coursera/exploratory_data_analysis/week1"
setwd(FilePath)

Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(Url, destfile = "PowerConsumption.zip", method = "libcurl")
unzip(zipfile = "PowerConsumption.zip", exdir = "./data")

## Read Files and Create Tables

PowerData <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c('character'   ##Date
                                       , 'character'  ##Time
                                       , 'numeric'    ##Global_active_power
                                       , 'numeric'    ##Global_reactive_power
                                       , 'numeric'    ##Voltage
                                       , 'numeric'    ##Global_intensity
                                       , 'numeric'    ##Sub_metering_1
                                       , 'numeric'    ##Sub_metering_2
                                       , 'numeric'    ##Sub_metering_3
                        )
)
## Format date 
PowerData$Date <- as.Date(PowerData$Date, "%d/%m/%Y")

## Subset data to only include 2007-02-01 and 2007-02-02

PowerData <- subset(PowerData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Combine Date and Time

PowerData$TimeStamp <- as.POSIXct(paste(PowerData$Date, PowerData$Time))

## Create Plot for Plot 4

par(mfrow = c(2,2))

with(PowerData, {
  ## 1st plot
  plot(Global_active_power ~ TimeStamp, type = "l", xlab = "", ylab = "Global Active Power")
  ## 2nd Plot
  plot(Voltage ~ TimeStamp, type = "l", xlab = "", ylab = "Voltage")
  ## 3rd plot
  plot(Sub_metering_1 ~ TimeStamp, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ TimeStamp, col = "Red")
  lines(Sub_metering_3 ~ TimeStamp, col = "Blue")
  legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, lwd = 1, bty = "n", pt.cex = 1)
  ## 4th Plot
  plot(Global_reactive_power ~ TimeStamp, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})

## Save plot as PNG

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()