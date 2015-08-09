# Exploratory Data Analysis
# Course Project 1, Plot 1

# read data frame
df <- read.table("household_power_consumption.txt",
                  header = T,
                  sep = ";",
                  colClasses = c("character", "character", rep("numeric", 7)),
                  na.strings = "?")

# convert data and time character strings into POSIXlt
df$Date2 <- as.Date(df$Date, "%d/%m/%Y")
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# subset data frame to time interval of interest
from <- as.POSIXlt("2007-02-01")
to <- as.POSIXlt("2007-02-03")
df_sub <- subset(df, DateTime >= from & DateTime <= to)

# create plot 1
hist(df_sub$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# save as PNG file
dev.copy(png, file = "Plot1.png")
dev.off()
