library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 
## to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
plot(aggregatedTotalByYear$year, aggregatedTotalByYear$Emissions, type = "l",
     main = "Total Emissions of PM2.5 in the US by Year", 
     xlab = "Year", ylab = "PM2.5 Emissions (tons)")
dev.off()

## According to graph, emissions of PM2.5 have decreased.