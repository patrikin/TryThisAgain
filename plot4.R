#Plot4: Combining four plots

data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Select only records from the dates 2007-02-01 and 2007-02-02:
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

#Load ggplot from tidyverse
library(tidyverse)

#Combining Date and Time variables into date_time variable
library(lubridate) #Load lubridate to handle time variables.
data2$date_time <- dmy_hms(paste(data2$Date, data2$Time))

#Gather the three different sub_metering columns into one using dplyr
data3 <- data2 %>%
  gather("SubMeteringCategory", "SubMetering", 7:9)


#Making individual plots p1 to p4
library(scales)#for date_breaks function that changes X axis scales to days.

p1 = qplot(date_time, Global_active_power, data = data2, geom = "line", xlab = "", ylab = "Global Active power") + scale_x_datetime(breaks = date_breaks("1 days"), labels = date_format("%a")) + #%a is abbreviated weekday, see 04_04_WorkingWithDates.R.
  theme_bw()
p1

p2 = qplot(date_time, Voltage, data = data2, geom = "line", xlab = "dateTime", ylab = "Voltage") + scale_x_datetime(breaks = date_breaks("1 days"), labels = date_format("%a")) + #%a is abbreviated weekday, see 04_04_WorkingWithDates.R.
  theme_bw()

p3 = qplot(date_time, SubMetering, data = data3, color = SubMeteringCategory, xlab = "", ylab = "Energy sub metering", geom = "line")+ scale_x_datetime(breaks = date_breaks("1 days"), labels = date_format("%a")) + #%a is abbreviated weekday, see 04_04_WorkingWithDates.R.
  theme_bw() +
  theme(legend.position = c(0.70, 0.80))
p3

p4 = qplot(date_time, Global_reactive_power, data = data2, geom = "line", xlab = "dateTime", ylab = "Global_reactive_power") + scale_x_datetime(breaks = date_breaks("1 days"), labels = date_format("%a")) + #%a is abbreviated weekday, see 04_04_WorkingWithDates.R.
  theme_bw()

#Combining the four plots into one
  library(gridExtra) #Needed for grid.arrange function
png("plot4.png", width = 480, height = 480)
grid.arrange(p1, p2, p3, p4, ncol=2)
dev.off()