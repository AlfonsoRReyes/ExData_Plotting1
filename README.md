# README





```r
library(dplyr)
library(lubridate)
```



# Review criteria

## Criteria

* Was a valid GitHub URL containing a git repository submitted?
* Does the GitHub repository contain at least one commit beyond the original fork?
* Please examine the plot files in the GitHub repository. Do the plot files appear to be of the correct graphics file format?
* Does each plot appear correct?
* Does each set of R code appear to create the reference plot?

# Making plots
For each plot you should

* Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

* Name each of the plot files as plot1.png, plot2.png, etc.

* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.

* Add the PNG file and R code file to your git repository


# Calculate the memory requirements for the dataset
> How do we calculate the memory consumption?



# Opening the file
This takes around 3.5 minutes. It is 126.8 MB file.



```r
source("read_data.R")
power <- read_2d()
```

```
Reading one row of the large dataset 
Reading one column of large dataset 
convert Date from character to Date
Number of rows to skip: 66637 
Maximum number of rows to read: 69517 
Finished reading  2880 rows 
```

```r
rows <- dim(power)[1]
cols <- dim(power)[2]
cat(sprintf("rows: %d, cols: %d", rows, cols))
```

```
rows: 2880, cols: 9
```

The dataset has 2880 observations and 9 variables.

## Class of variables
All the variables to be used are factors. Need to be converted

```r
str(power)
```

```
'data.frame':	2880 obs. of  9 variables:
 $ Date                 : chr  "1/2/2007" "1/2/2007" "1/2/2007" "1/2/2007" ...
 $ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
 $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
 $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
 $ Voltage              : num  243 243 244 244 243 ...
 $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
 $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
```


# Using only 2007 data
We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

In this case we will be sub-setting the data frame

## Converting variable Date to Date class
Testing with one sample the date conversion.


We need the format to be separated with "/".
Also we need to convert `Global_active_power` to character because the variable is a factor.




## Getting observations for 2 days in 2007

Converting the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.

Convert `Global_active_power` from character to numeric.





```r
power07_2d <- power %>%
  mutate(date_time = as.POSIXct(paste(Date, Time),
                                format="%d/%m/%Y %H:%M:%S"))
```




```r
str(power07_2d)
```

```
'data.frame':	2880 obs. of  10 variables:
 $ Date                 : chr  "1/2/2007" "1/2/2007" "1/2/2007" "1/2/2007" ...
 $ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
 $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
 $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
 $ Voltage              : num  243 243 244 244 243 ...
 $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
 $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ date_time            : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" ...
```

`power07_2d` is the data frame for observation for two days in February 2007.


# Plot 1 - Global Active Power Histogram



```r
hist(power07_2d$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts", main = "Global Active Power")
```

![](README_files/figure-html/plot1-chunk-1.png)<!-- -->

```r
dev.copy(png,"plot1.png", width=480, height=480)
```

```
png 
  3 
```

```r
dev.off()
```

```
png 
  2 
```



# Plot #2 - Global Active Power vs Days


```r
with(power07_2d, plot(date_time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
```

![](README_files/figure-html/plot2-chunk-1.png)<!-- -->

```r
dev.copy(png,"plot2.png", width=480, height=480)
```

```
png 
  3 
```

```r
dev.off()
```

```
png 
  2 
```

# Plot #3 - Energy sub metering with legends



```r
plot(power07_2d$date_time, power07_2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metring")
lines(power07_2d$date_time, power07_2d$Sub_metering_2, col = "red")
lines(power07_2d$date_time, power07_2d$Sub_metering_3, col = "blue")     
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),  lty = c(1, 1, 1))
```

![](README_files/figure-html/plot3-chunk-1.png)<!-- -->

```r
dev.copy(png,"plot3.png", width=480, height=480)
```

```
png 
  3 
```

```r
dev.off()
```

```
png 
  2 
```

# Plot # 4 - four plots in one

## Plot voltage vs datetime

```r
with(power07_2d,
  plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
)
```

![](README_files/figure-html/plot4-1-chunk-1.png)<!-- -->
## Plot Global Reactive Power vs datetime


```r
with(power07_2d,
  plot(date_time, Global_reactive_power, type = "l", xlab = "datetime")
)
```

![](README_files/figure-html/plot4-2-chunk-1.png)<!-- -->

## Plot all 4 plots


```r
# set scene in 2 rows by 2 columns
par(mfrow = c(2, 2))

# plot active power vs datetime
with(power07_2d, plot(date_time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# plot Voltage vs datetime
with(power07_2d,
  plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
)

# plot sub metering x3 vs datetime
plot(power07_2d$date_time, power07_2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metring")
lines(power07_2d$date_time, power07_2d$Sub_metering_2, col = "red")
lines(power07_2d$date_time, power07_2d$Sub_metering_3, col = "blue")     
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),  lty = c(1, 1, 1))

# plot reactive power vs datetime
with(power07_2d,
  plot(date_time, Global_reactive_power, type = "l", xlab = "datetime")
)
```

![](README_files/figure-html/plot4-chunk-1.png)<!-- -->

```r
dev.copy(png,"plot4.png", width=480, height=480)
```

```
png 
  3 
```

```r
dev.off()
```

```
png 
  2 
```


