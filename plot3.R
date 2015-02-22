library(dplyr)
library(ggplot2)

## Download data. NB: this is time consuming.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 3: Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City?

marylandData <- NEI$fips == "24510"
marylandData <- NEI[marylandData, ]

marylandAggYearAndType <- aggregate(Emissions ~ year + type, marylandData, sum)

png("plot3.png")
p <- qplot(year, Emissions, data = marylandAggYearAndType, facets = .~type)
p <- p + geom_smooth(method = "lm") + xlab("Year") + ylab(expression("PM2.5 Emissions (tons)")) + 
  ggtitle("Total PM2.5 Emissions in Baltimore, MD from 1999 to 2008")

dev.off()

## Answer: Non-Road, Non-Point, and On-Road all show a decrease in PM2.5 Emissions. Point 
## shows a general increase in PM2.5 Emissions.
