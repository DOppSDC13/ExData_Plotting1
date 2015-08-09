## Load full dataset into R
dataset <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

## Subset data to capture only the specified dates
dataFeb07 <- subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataset)

## Convert date and time variables into date/time
datetime <- paste(as.Date(dataFeb07$Date), dataFeb07$Time)
dataFeb07$Datetime <- as.POSIXct(datetime)

## Create plot 4 as specified in the assignment
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataFeb07, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", cex=0.6, title.adj=0.15,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Save to png file as plot4
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()