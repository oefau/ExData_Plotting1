# -----------------------  plot1.R   -------------------------------
# ------------------------------------------------------------------
# Download the data if it does not already exist. 
if (!file.exists("household_power_consumption.txt")) {
  fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  tmp <- tempfile()
  download.file(fileUrl, tmp)
  unzip(tmp)
  unlink(tmp)
}
# read the data 

df <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

df$Date <- as.Date(df$Date, format="%d/%m/%Y")


## Subset Feb 1st and 2nd data
Feb1_2 <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(df)

## Convert dates
datetime <- paste(as.Date(Feb1_2$Date), Feb1_2$Time)
Feb1_2$Datetime <- as.POSIXct(datetime)

## plot1.png
png(file = "plot1.png", height = 480, width = 480) ## Save plot to file plot1.png
hist(Feb1_2$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
