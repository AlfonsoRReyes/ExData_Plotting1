# README





```r
library(dplyr)
```

```

Attaching package: 'dplyr'
```

```
The following objects are masked from 'package:stats':

    filter, lag
```

```
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union
```

```r
library(lubridate)
```

```

Attaching package: 'lubridate'
```

```
The following object is masked from 'package:base':

    date
```


# Review criteria

## Criteria

* Was a valid GitHub URL containing a git repository submitted?
* Does the GitHub repository contain at least one commit beyond the original fork?
* Please examine the plot files in the GitHub repository. Do the plot files appear to be of the correct graphics file format?
* Does each plot appear correct?
* Does each set of R code appear to create the reference plot?


# Calculate the memory requirements for the dataset
> How do we calculate the memory consumption?



# Opening the file
This takes around 3.5 minutes. It is 126.8 MB file.




```r
# read large dataset if is not in memory
if (is.null(dim(power)) == TRUE ) {
  power <- data.frame()     # create a dummy data frame
  # if the data frame has changed load it from the file again
  if ( (dim(power)[1] != 2075260) | (dim(power)[2] != 9) ) {
    cat("Opening large dataset ...", "\n")
    fileName <- "household_power_consumption.txt"
    fileDir <- "data"
    fullFileName <- paste(fileDir, fileName, sep = "/")
    power <- read.table(fullFileName, sep = ";", header = TRUE)
  }

} else {
  cat("data frame already loaded ...") 
  }
```

```
Opening large dataset ... 
```

```r
#```{r, cache=TRUE, dependson='gen-data'}
power_raw <- power
dim(power)[1]
```

```
[1] 2075259
```

```r
dim(power)[2]
```

```
[1] 9
```

The dataset has 2075259 observations and 9 variables.

## Class of variables
All the variables to be used are factors. Need to be converted

```r
class(power_raw$Date)
```

```
[1] "factor"
```

```r
class(power_raw$Time)
```

```
[1] "factor"
```

```r
class(power_raw$Global_active_power)
```

```
[1] "factor"
```

```r
class(power_raw$Global_reactive_power)
```

```
[1] "factor"
```

```r
class(power_raw$Sub_metering_1)
```

```
[1] "factor"
```

```r
class(power_raw$Voltage)
```

```
[1] "factor"
```


# Using only 2007 data
We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

In this case we will be sub-setting the data frame

## Converting variable Date to Date class
Testing with one sample the date conversion.


```r
# Making a simple example before conversion
dt <- paste(power_raw$Date[1], power_raw$Time[1])
dt
```

```
[1] "16/12/2006 17:24:00"
```

```r
as.POSIXct(dt, format="%d/%m/%Y %H:%M:%S")
```

```
[1] "2006-12-16 17:24:00 CST"
```
We need the format to be separated with "/".
Also we need to convert `Global_active_power` to character because the variable is a factor.



```r
power <- power_raw %>%
  # converting date, time variables from factors to character
  mutate(Date = as.character(Date), Time = as.character(Time)) %>%
  mutate(date_time = as.POSIXct(paste(Date, Time),
                                format="%d/%m/%Y %H:%M:%S")) %>%
  # coverting factors to character
  mutate(
    Global_active_power = as.character(Global_active_power), 
    Global_reactive_power = as.character(Global_reactive_power), 
         Sub_metering_1 = as.character(Sub_metering_1),
         Sub_metering_2 = as.character(Sub_metering_2),
         Sub_metering_3 = as.character(Sub_metering_3),
         Voltage = as.character(Voltage)
         ) 
```



```r
class(power$Date)
```

```
[1] "character"
```

```r
class(power$Time)
```

```
[1] "character"
```

```r
class(power$Global_active_power)
```

```
[1] "character"
```

```r
class(power$Global_reactive_power)
```

```
[1] "character"
```

```r
class(power$Sub_metering_1)
```

```
[1] "character"
```

```r
class(power$Voltage)
```

```
[1] "character"
```



## Getting observations for 2 days in 2007

Converting the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.

Convert `Global_active_power` from character to numeric.


```r
power_2007 <- power %>%
  filter(year(date_time) == 2007)

power07_2d <- power_2007 %>%
  filter(date(date_time) == "2007-02-01" | date(date_time) == "2007-02-02") %>%
  mutate(Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3),
         Voltage = as.numeric(Voltage)
         
         )
```



```r
class(power07_2d$Date)
```

```
[1] "character"
```

```r
class(power07_2d$Time)
```

```
[1] "character"
```

```r
class(power07_2d$Global_active_power)
```

```
[1] "numeric"
```

```r
class(power07_2d$Global_reactive_power)
```

```
[1] "numeric"
```

```r
class(power07_2d$Sub_metering_1)
```

```
[1] "numeric"
```

```r
class(power07_2d$Voltage)
```

```
[1] "numeric"
```

`power07_2d` is the data frame for observation for two days in February 2007.


# Plot 1 - Global Active Power Histogram



```r
hist(power07_2d$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts", main = "Global Active Power")
```

![](README_files/figure-html/unnamed-chunk-9-1.png)<!-- -->



# Plot #2 - Global Active Power vs Days


```r
with(power07_2d, plot(date_time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
```

![](README_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

# Plot #3 - Energy sub metering with legends




```r
plot(power07_2d$date_time, power07_2d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metring")
lines(power07_2d$date_time, power07_2d$Sub_metering_2, col = "red")
lines(power07_2d$date_time, power07_2d$Sub_metering_3, col = "blue")     
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),  lty = c(1, 1, 1))
```

![](README_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

# Plot # 4 - four plots in one

## Plot voltage vs datetime

```r
with(power07_2d,
  plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
)
```

![](README_files/figure-html/unnamed-chunk-12-1.png)<!-- -->
## Plot Global Reactive Power vs datetime


```r
with(power07_2d,
  plot(date_time, Global_reactive_power, type = "l", xlab = "datetime")
)
```

![](README_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

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

![](README_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


