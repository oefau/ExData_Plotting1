# -----------------------  plot2.R   -------------------------------
# ------------------------------------------------------------------
# Download the data if it does not already exist. 
if (!file.exists("household_power_consumption.txt")) {
  fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  tmp <- tempfile()
  download.file(fileUrl, tmp)
  unzip(tmp)
  unlink(tmp)
}
df <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## Subsetting Feb 1 and 2 data
Feb1_2 <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(df)

## Convert dates
datetime <- paste(as.Date(Feb1_2$Date), Feb1_2$Time)
Feb1_2$Datetime <- as.POSIXct(datetime)

## plot2.png
png(file = "plot2.png", height = 480, width = 480) # save plot to plot2.png
plot(Feb1_2$Global_active_power~Feb1_2$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()