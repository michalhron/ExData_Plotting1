setwd("/Users/michalhron/GIT/EDA/")

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, "dataset.zip")
unzip("dataset.zip")


filepath <- "~/GIT/EDA/household_power_consumption.txt"

HPC <- read.table(filepath, header = TRUE, sep =";")
HPC2 <-  HPC[as.character(HPC$Date) %in% c("1/2/2007", "2/2/2007"),]

HPC2$dateTime <- paste(HPC2$Date, HPC2$Time)

HPC2$dateTimeF <- strptime(HPC2$dateTime, "%d/%m/%Y %H:%M:%S")

#plot 1
png("plot1.png", width=480, height=480, units="px")
hist(as.numeric(HPC2$Global_active_power), col ="red", main="Global Active Power", xlab="Global Active Power (kW)")
dev.off()


#plot 2
png("plot2.png", width=480, height=480, units="px")
plot(HPC2$dateTimeF, as.numeric(HPC2$Global_active_power), type = "l",ylab="Global Active Power (kiloWatts)", xlab = "")
dev.off()

#plot 3
png("plot3.png", width=480, height=480, units="px")
# Plot Energy sub metering
plot(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_2)), col="red")
lines(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_3)), col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
dev.off()

#plot 4

png("plot4.png", width=480, height=480, units="px")
# Plot Energy sub metering
par(mfrow=c(2,2))
plot(HPC2$dateTimeF, as.numeric(as.character(HPC2$Global_active_power)), type="l", xlab="", ylab="Global Active Power")

plot(HPC2$dateTimeF, as.numeric(as.character(HPC2$Voltage)), type="l", xlab="datetime", ylab="Voltage")

plot(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_2)), col="red")
lines(HPC2$dateTimeF, as.numeric(as.character(HPC2$Sub_metering_3)), col="blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

plot(HPC2$dateTimeF, as.numeric(as.character(HPC2$Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()

