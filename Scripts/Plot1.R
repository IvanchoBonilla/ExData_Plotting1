library(data.table)
library(dplyr)

DT <- tbl_df(fread("household_power_consumption.txt", na.strings = "?"))
DT <- mutate(DT, Date=as.Date(t(DT[,1]), "%d/%m/%Y"))
A <- filter(DT, Date>="2007-02-01", Date<="2007-02-02")

png(filename = "Plot1.png", height=480, width=480, units = "px")

with(A, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

dev.off()

rm(DT)
rm(A)
