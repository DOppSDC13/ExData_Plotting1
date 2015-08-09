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

## Create plot 2 as specified in the assignment
plot(dataFeb07$Global_active_power~dataFeb07$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()