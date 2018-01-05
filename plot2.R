#Plot2: Global Active Power over time

#Reading data
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Select only records from the dates 2007-02-01 and 2007-02-02:
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

#Load ggplot from tidyverse
  library(tidyverse)

#Combining Date and Time variables into date_time variable
  library(lubridate) #Load lubridate to handle time variables.
data2$date_time <- dmy_hms(paste(data2$Date, data2$Time))

#Make and save plot
  library(scales) #for date_breaks function that changes X axis scales to days.
png("plot2.png", width = 480, height = 480)
qplot(date_time, Global_active_power, data = data2, geom = "line", xlab = "", ylab = "Global Active power (kilowatts)") + scale_x_datetime(breaks = date_breaks("1 days"), labels = date_format("%a")) + #%a is abbreviated weekday, see 04_04_WorkingWithDates.R.
  theme_bw()
dev.off()

