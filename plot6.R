library(ggplot2)

## Download data. NB: this is time consuming.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has 
## seen greater changes over time in motor vehicle emissions?

NEISCC <- merge(NEI, SCC, by = "SCC")

compareData <- NEI[(NEI$fips == "24510" | NEI$fips == "06037") & NEI$type == "ON-ROAD", ]
compareDataByYear <- aggregate(Emissions ~ year + fips , compareData, sum)

fips_labeller <- function(var, value) {
  value <- as.character(value)
  if(var =="fips") {
    value[value == "06037"] <- "Los Angeles, CA"
    value[value == "24510"] <- "Baltimore, MD"
  }
  return(value)
}

png("plot6.png")
p <- qplot(year, Emissions, data = compareDataByYear, facets = .~fips)
p <- p + geom_smooth(method = "lm") + facet_grid(.~fips, labeller = fips_labeller)
print(p)
dev.off()

## Answer: Baltimore saw an average decrease, Los Angeles saw an average increase. The largest 
## magnitude of change, however, occurred in Los Angeles.