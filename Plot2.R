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
?plot
?strptime


png(file=".//Plot2.png")
plot(data_final$datetime,data_final$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

rm(list=ls())

