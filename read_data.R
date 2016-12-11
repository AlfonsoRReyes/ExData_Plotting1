

read_2d <- function() {
  
  library(dplyr)
  
  fn <- "./data/household_power_consumption.txt"
  
  # read one row only
  cat("Reading one row of the large dataset \n")
  DF.row1 <- read.table(fn, header = TRUE, nrow = 1, sep = ";")  # read one row and header
  nc <- ncol(DF.row1)      # number of columns
  
  # read one column only
  cat("Reading one column of large dataset \n")
  DF.Date <- read.table(fn, header = TRUE, 
                        as.is = TRUE, 
                        colClasses = c(NA, rep("NULL", nc - 1)), 
                        sep = ";")
  

  # convert Date from character to Date
  cat("convert Date from character to Date\n")
  DF.Date <- DF.Date %>%
    mutate(Date = as.POSIXct(Date, format="%d/%m/%Y"))
  
  # calculate rows to skip and max number of rows to read
  
  n2007_1 <- which.max(DF.Date$Date >= "2007-02-01")
  n2007_2 <- which.max(DF.Date$Date >= "2007-02-03")
  cat("Number of rows to skip:", n2007_1, "\n")
  cat("Maximum number of rows to read:", n2007_2, "\n")
  
  # data frame of 2 days in February 2007
  DF3 <- read.table(fn, 
                    col.names = names(DF.row1), 
                    skip = n2007_1, 
                    as.is = TRUE, 
                    sep = ";", 
                    nrows = (n2007_2-n2007_1)
                    )
  
  cat("Finished reading ", (n2007_2-n2007_1), "rows \n")
  return(DF3)
  
}