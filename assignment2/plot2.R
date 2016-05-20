
# read the data
nei.df <- readRDS("data/summarySCC_PM25.rds")

# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

a.df <- aggregate(Emissions ~ year, data=subset(nei.df,fips=="24510"), sum)

png("plot2.png")
barplot(a.df$Emissions,names.arg=as.character(a.df$year),ylab="Emissions",main="Total Emissions, Baltimore City")
dev.off()

# Answer: 
# yes, overall, PM2.5 has decreased in Baltimore City between 1999 and 2008, although 
# there was an increase between 2002 and 2005.

