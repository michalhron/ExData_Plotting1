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