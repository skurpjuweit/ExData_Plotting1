# Exploratory Data Analysis
# Course Project 1, Plot 3

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

# create plot 3
Sys.setlocale("LC_TIME", "C")
par(mfcol = c(1, 1))

names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black", "red", "blue")
plot(df_sub$DateTime, df_sub[[names[1]]], type = "l", col = colors[1], xlab = "", ylab = "Energy sub metering")
lines(df_sub$DateTime, df_sub[[names[2]]], type = "l", col = colors[2])
lines(df_sub$DateTime, df_sub[[names[3]]], type = "l", col = colors[3])

# print legend, adjust text parameters so that png export looks ok
legend("topright", lty = 1, col = colors, legend = names, pt.cex = 1, cex = 0.85, text.width = 50000)

# save as PNG file
dev.copy(png, file = "Plot3.png")
dev.off()
