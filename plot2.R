library(dplyr)

## Download data. NB: this is time consuming.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008?

marylandData <- NEI$fips == "24510"
marylandData <- NEI[marylandData, ]

marylandAggregate <- aggregate(Emissions ~ year, marylandData, sum)
years <- c(1999, 2002, 2005, 2008)

png("plot2.png")
plot(marylandAggregate$year, marylandAggregate$Emissions, type = "p",
     main = "Total PM2.5 Emissions in Maryland by Year",
     ylab = "PM2.5 Emissions (tons)", xlab = "Year")
abline(lm(marylandAggregate$Emissions ~ marylandAggregate$year))
dev.off()

## Answer: There has been a general decrease, even with an increase between years 2002 
## and 2005. Abline shows a general decrease from 2000 to 2008