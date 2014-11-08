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

# Create datetime column
df$Datetime <- strptime(paste(as.character(df$Date), as.character(df$Time), sep = " "), "%d/%m/%Y %H:%M:%S")

# Get subset
d2 <- df[(df$Datetime >= (strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))) & (df$Datetime <= (strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))) & (!is.na(df$Datetime)),]

# Create graph
with(d2,{
  plot(d2$Datetime, d2$Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  
# copy to PNG
  dev.copy(png,file="plot2.png")
# Close the device
  dev.off()
  })



