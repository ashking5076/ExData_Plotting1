library(dplyr)
library(lubridate)

EPC_colname<-tolower(c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
EPC<-read.table("./Data/household_power_consumption.txt",sep=";",col.names = EPC_colname, header = TRUE)
EPC<-mutate(EPC,date=dmy(date))
EPC<-subset(EPC,date=="2007-02-01"|date=="2007-02-02")
EPC<-mutate(EPC,time=hms(time),global_active_power=as.numeric(global_active_power),
            global_reactive_power=as.numeric(global_reactive_power),
            voltage=as.numeric(voltage),
            global_intensity=as.numeric(global_intensity),
            sub_metering_1=as.numeric(sub_metering_1),
            sub_metering_2=as.numeric(sub_metering_2),
            sub_metering_3=as.numeric(sub_metering_3))
png("plot1.png",width=480,height=480,units = "px")
hist(EPC$global_active_power,xlab="Global Active Power (kilowatts)",col = "red", main="Gloabl Active Power")
dev.off()