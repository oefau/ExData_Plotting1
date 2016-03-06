# -----------------------  plot4.R   -------------------------------
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
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## Subset Feb 1st and 2nd data
Feb1_2 <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(df)

## Convert dates
datetime <- paste(as.Date(Feb1_2$Date), Feb1_2$Time)
Feb1_2$Datetime <- as.POSIXct(datetime)

## plot4.png
png(file = "plot4.png", height = 480, width = 480) # save to plot4.png
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Feb1_2, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()