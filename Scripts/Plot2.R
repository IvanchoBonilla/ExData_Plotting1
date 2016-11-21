library(data.table)
library(dplyr)

DT <- tbl_df(fread("household_power_consumption.txt", na.strings = "?"))
DT <- mutate(DT, Date=as.Date(t(DT[,1]), "%d/%m/%Y"))
A <- filter(DT, Date>="2007-02-01", Date<="2007-02-02")

B<-tbl_df(strptime(t(paste(as.character(t(A[,1])), t(A[,2]))), format = "%Y-%m-%d %H:%M:%S"))
A<-bind_cols(A, B)

with(A, plot(value, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(A, lines(value, Global_active_power))

png(filename = "Plot2.png", height=480, width=480, units = "px")
dev.off()

rm(DT)
rm(A)
rm(B)