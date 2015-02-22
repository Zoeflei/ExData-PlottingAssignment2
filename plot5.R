library(ggplot2)

## Download data. NB: this is time consuming.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 5: How have emissions from motor vehicle sources changed from 1999–2008 
## in Baltimore City?

NEISCC <- merge(NEI, SCC, by = "SCC")
carData <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

carDataByYear <- aggregate(Emissions ~ year, carData, sum)

png("plot5.png")
g <- ggplot(carDataByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") +
  xlab("Year") + 
  ylab("PM2.5 Emissions (tons)") + 
  ggtitle("Total Emissions from motor vehicles in Baltimore, MD from 1999 to 2008")
print(g)
dev.off()


