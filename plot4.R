library(ggplot2)

## Download data. NB: this is time consuming.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "./ExData", method = "curl")
dir.create("./ExData2")
unzip(zipfile = "./ExData", exdir = "./ExData2")

setwd("./ExData2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 4: Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

NEISCC <- merge(NEI, SCC, by = "SCC")
coalData <- grep("coal", NEISCC$Short.Name, ignore.case = TRUE)
coalNEISCC <- NEISCC[coalData, ]

coalAggregate <- aggregate(Emissions ~ year, coalNEISCC, sum)

png("plot4.png")
g <- ggplot(coalAggregate, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + 
  xlab("Year") + 
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("Total Emissions from coal sources between 1999 and 2008")
print(g)
dev.off()


