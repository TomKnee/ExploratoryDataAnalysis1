directory = "."
basename = "household_power_consumption"
filename<- paste(basename, 'txt', sep='.')               
fullname<- paste(directory, filename, sep ='//')     
#print(fullname)

## Does file exist
if (!file.exists(fullname)){
  print('File Does not exist')
 }  

df <- read.csv(file = fullname, header = TRUE, sep = ";", quote="\"", na.strings = "?")




df$Datetime <- strptime(paste(as.character(df$Date), as.character(df$Time), sep = " "), "%d/%m/%Y %H:%M:%S")
d2 <- df[(df$Datetime >= (strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))) & (df$Datetime <= (strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))) & (!is.na(df$Datetime)),]
# setup output
png(filename="plot4.png",width = 480, height = 480, 
    units = "px", pointsize = 12,bg = "white", 
    res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
par(mfrow =c(2,2))
par(mar= c(4,4,1,1))

# top left graph
with(d2,{
  plot(d2$Datetime, d2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
})  

# top right graph

with(d2,{
  plot(d2$Datetime, d2$Voltage, type="l", ylab="Voltage", xlab="datetime", ylim=c(233,247))
})  

# bottom left graph
with(d2,{
  plot(x=d2$Datetime, y=d2$Sub_metering_1, type="n", ylim=c(0,40), ylab="", xlab="")
  lines(d2$Datetime, d2$Sub_metering_1, col="black", lty=1) 
  #, ylab="Energy sub metering", ylim=c(0,40))
  lines(d2$Datetime, d2$Sub_metering_2, col="red", lty=1)
  lines(d2$Datetime, d2$Sub_metering_3, col="blue", lty=1)
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

  # bottom right graph
with(d2,{
  plot(d2$Datetime, d2$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", ylim=c(0,.5))
  })  

dev.off()
})


