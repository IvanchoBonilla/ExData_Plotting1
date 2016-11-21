library(data.table)
library(dplyr)

DT <- tbl_df(fread("household_power_consumption.txt", na.strings = "?"))
DT <- mutate(DT, Date=as.Date(t(DT[,1]), "%d/%m/%Y"))
A <- filter(DT, Date>="2007-02-01", Date<="2007-02-02")

B<-tbl_df(strptime(t(paste(as.character(t(A[,1])), t(A[,2]))), format = "%Y-%m-%d %H:%M:%S"))
A<-bind_cols(A, B)

par(mfrow=c(2,2))

with(A, plot(value, Global_active_power, type = "n", ylab="Global Active Power", xlab = ""))
with(A, lines(value, Global_active_power))

with(A, plot(value, Voltage, type = "n", xlab="datetime"))
with(A, lines(value, Voltage))

with(A, plot(value, Global_active_power, type = "n", ylim = c(0,40), ylab="Energy sub metering", xlab = ""))
with(A, lines(value, Sub_metering_1, col="black"))
with(A, lines(value, Sub_metering_2, col="red"))
with(A, lines(value, Sub_metering_3, col="blue"))
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(A, plot(value, Global_reactive_power, type = "n", xlab="datetime"))
with(A, lines(value, Global_reactive_power))


png(filename = "Plot4.png", height=480, width=480, units = "px")
dev.off()

rm(DT)
rm(A)
rm(B)