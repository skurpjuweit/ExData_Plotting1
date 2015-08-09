# Exploratory Data Analysis
# Course Project 1, Plot 4

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

# create 2x2 plots
Sys.setlocale("LC_TIME", "C")
par(mfcol = c(2, 2))

# Plot top left
plot(df_sub$DateTime, df_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Plot bottom left
names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black", "red", "blue")
plot(df_sub$DateTime, df_sub[[names[1]]], type = "l", col = colors[1], xlab = "", ylab = "Energy sub metering")
lines(df_sub$DateTime, df_sub[[names[2]]], type = "l", col = colors[2])
lines(df_sub$DateTime, df_sub[[names[3]]], type = "l", col = colors[3])

# print legend, adjust text parameters so that png export looks ok
legend("topright", lty = 1, col = colors, legend = names, bty = "n", pt.cex = 1, cex = 0.65, text.width = 80000)

# Plot top right
plot(df_sub$DateTime, df_sub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot bottom right
plot(df_sub$DateTime, df_sub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactice_power")

# save as PNG file
dev.copy(png, file = "Plot4.png")
dev.off()
