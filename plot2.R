
# plot2.R
# read the script for extracting the data
source("read_data.R")

power <- read_2d()    # create a data frame from the function

power07_2d <- cleanup_data(power)


with(power07_2d, plot(date_time, Global_active_power, 
                      type="l", 
                      xlab = "", 
                      ylab = "Global Active Power (kilowatts)"))

# save the plot to PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()


