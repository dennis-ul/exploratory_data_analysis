library(dplyr)

# read and subset data

data<-read.table(".//exdata_data_household_power_consumption//household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE)

datetime<-paste(data$Date, data$Time) %>%
  strptime(format="%d/%m/%Y %H:%M:%S")  


data<-cbind(datetime,data)
data_subset<- data %>% 
  filter(datetime>= "2007-02-01 00:00:00" & datetime< "2007-02-03 00:00:00") %>%
  select(-Date, -Time)
datetime<-data_subset$datetime

# transform to numeric

df<-data.frame(lapply(select(data_subset, Global_active_power:Sub_metering_3), as.numeric))
data_final<-cbind(datetime, df)


#Plot
png(file=".//Plot4.png")

par(mfrow=c(2,2))
plot(data_final$datetime,data_final$Global_active_power, type="l", xlab="",ylab="Global Active Power")
plot(data_final$datetime, data_final$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(data_final$datetime,data_final$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
lines(data_final$datetime, data_final$Sub_metering_2, col="red")
lines(data_final$datetime, data_final$Sub_metering_3, col="blue")
legend("topright", cex=0.7, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1, col=c("black", "red", "blue"))
plot(data_final$datetime, data_final$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")


dev.off()

rm(list=ls())

