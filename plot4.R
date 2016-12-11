# plot4.R
## Plot # 4 - four plots in one

# read the script for extracting the data
source("read_data.R")

power <- read_2d()    # create a data frame from the function

power07_2d <- cleanup_data(power)

# create the plot
# set scene in 2 rows by 2 columns
par(mfrow = c(2, 2))

# plot active power vs datetime
with(power07_2d, plot(date_time, Global_active_power, 
                      type="l", 
                      xlab = "", 
                      ylab = "Global Active Power (kilowatts)"))

# plot Voltage vs datetime
with(power07_2d,
     plot(date_time, Voltage, 
          type = "l", 
          xlab = "datetime", 
          ylab = "Voltage")
)

# plot sub metering x3 vs datetime
plot(power07_2d$date_time, power07_2d$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metring")

lines(power07_2d$date_time, power07_2d$Sub_metering_2, col = "red")
lines(power07_2d$date_time, power07_2d$Sub_metering_3, col = "blue")     

# add legend
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),  
       lty = c(1, 1, 1))

# plot reactive power vs datetime
with(power07_2d,
     plot(date_time, Global_reactive_power, 
          type = "l", 
          xlab = "datetime")
)

# save the plot to PNG file
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()


