# plot3.R
## Plot #3 - Energy sub metering with legend

# read the script for extracting the data
source("read_data.R")

power <- read_2d()    # create a data frame from the function

power07_2d <- cleanup_data(power)

# create the plot
plot(power07_2d$date_time, power07_2d$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metring")

lines(power07_2d$date_time, power07_2d$Sub_metering_2, col = "red")
lines(power07_2d$date_time, power07_2d$Sub_metering_3, col = "blue")     

# add the legend for the three lines
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),  
       lty = c(1, 1, 1))

# save the plot to PNG file
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

