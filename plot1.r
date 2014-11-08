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

 # Create datetime colum
df$Datetime <- strptime(paste(as.character(df$Date), as.character(df$Time), sep = " "), "%d/%m/%Y %H:%M:%S")

# Get subset
d2 <- df[(df$Datetime >= (strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))) & (df$Datetime <= (strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))) & (!is.na(df$Datetime)),]

# Create graph
with(d2,{
  hist(d2$Global_active_power, xlim=c(0,6), ylim=c(0,1200), col ="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", breaks=12 )
  axis(1, at=seq(0,6, by=2), labels=seq(0,6, by=2)) 

# Copy to PNG
  dev.copy(png,file="plot1.png")
  
# Close Device
  dev.off()
  })



