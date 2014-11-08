directory = "."
basename = "household_power_consumption"
filename<- paste(basename, 'txt', sep='.')               
fullname<- paste(directory, filename, sep ='//')     
#print(fullname)

## Does file exist
if (!file.exists(fullname)){
  print('File Does not exist')
 }  

# Get data
df <- read.csv(file = fullname, header = TRUE, sep = ";", quote="\"", na.strings = "?")


# Create Datetime column
df$Datetime <- strptime(paste(as.character(df$Date), as.character(df$Time), sep = " "), "%d/%m/%Y %H:%M:%S")

# Get the subset
d2 <- df[(df$Datetime >= (strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))) & (df$Datetime <= (strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))) & (!is.na(df$Datetime)),]

# Set up png output
png(filename="plot3.png",width = 480, height = 480, 
    units = "px", pointsize = 12,bg = "white", 
    res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# Create graph
with(d2,{
  plot(x=d2$Datetime, y=d2$Sub_metering_1, type="n", ylim=c(0,40), ylab="", xlab="")
  lines(d2$Datetime, d2$Sub_metering_1, col="black", lty=1) 
  #, ylab="Energy sub metering", ylim=c(0,40))
  lines(d2$Datetime, d2$Sub_metering_2, col="red", lty=1)
  lines(d2$Datetime, d2$Sub_metering_3, col="blue", lty=1)
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

# Turn off output
dev.off()
})



