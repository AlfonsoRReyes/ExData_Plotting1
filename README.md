# README



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
    power <- read.table(fullFileName, sep = ";")
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
dim(power)[1]
```

```
[1] 2075260
```

```r
dim(power)[2]
```

```
[1] 9
```



```r
dim(power)
```

```
[1] 2075260       9
```


The dataset has 2075260 observations and 9 variables.

