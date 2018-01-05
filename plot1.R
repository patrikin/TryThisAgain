#Plot1: Frequency of Global Active Power readings

#Reading data
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Select only records from the dates 2007-02-01 and 2007-02-02:
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

#Load ggplot from tidyverse
library(tidyverse)

#Make and save plot
png("plot1.png", width = 480, height = 480)
qplot(Global_active_power, data = data2, ylab = "Frequency", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") + theme_bw()
dev.off()