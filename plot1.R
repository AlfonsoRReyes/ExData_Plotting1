
# plot1.R
# read the script for extracting the data
source("read_data.R")

power <- read_2d()    # create a data frame from the function

power07_2d <- cleanup_data(power)

hist(power07_2d$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts", 
     main = "Global Active Power")

# save the plot to PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

