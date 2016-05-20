
# read the data
nei.df <- readRDS("data/summarySCC_PM25.rds")

# Question 1: 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

a.df <- aggregate(Emissions ~ year, data=nei.df, sum)
png("plot1.png")
barplot(a.df$Emissions,names.arg=as.character(a.df$year),ylab="Emissions",main="Total Emissions")
dev.off()

# Answer: 
# yes, they've decreased.

