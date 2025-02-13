library(dplyr)
library(lubridate)
library(M3)

EPC_colname<-tolower(c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
EPC<-read.table("./Data/household_power_consumption.txt",sep=";",col.names = EPC_colname, header = TRUE)
EPC<-mutate(EPC,date=dmy(date))
EPC<-subset(EPC,date=="2007-02-01"|date=="2007-02-02")
EPC<-mutate(EPC,global_active_power=as.numeric(global_active_power),
            global_reactive_power=as.numeric(global_reactive_power),
            voltage=as.numeric(voltage),
            global_intensity=as.numeric(global_intensity),
            sub_metering_1=as.numeric(sub_metering_1),
            sub_metering_2=as.numeric(sub_metering_2),
            sub_metering_3=as.numeric(sub_metering_3))
dt<-combine.date.and.time(date=EPC$date,time=EPC$time)
png("plot4.png",width=480,height=480,units = "px")
par(mfrow=c(2,2),mar=c(4,4,2,2),oma=c(0,0,0,0))

#plot 1st graph
plot(dt,EPC$global_active_power,xlab="",ylab="Global Active Power",type="l")

#plot 2nd graph
plot(dt,EPC$voltage,xlab="datetime",ylab="Voltage",type="l")

#plot 3rd graph
plot(dt,EPC$sub_metering_1,type="l",xlab="",ylab="")
lines(dt,EPC$sub_metering_2,type="l", col="red",xlab="",ylab="")
lines(dt,EPC$sub_metering_3,type="l", col="blue",ylab="",xlab="")
title(ylab="Energy sub metering",xlab="")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=c(1,1,1), cex=0.8, bty="n")

#plot 4 graph
plot(dt,EPC$global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")


dev.off()