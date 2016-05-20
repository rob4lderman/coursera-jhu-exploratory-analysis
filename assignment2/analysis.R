

# read the data
scc.df <- readRDS("data/Source_Classification_Code.rds")
nei.df <- readRDS("data/summarySCC_PM25.rds")


#--------------------------------------------------------------------------------------------------
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


#--------------------------------------------------------------------------------------------------
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
    

#--------------------------------------------------------------------------------------------------
# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
# plot answer this question.

s.df <- subset(nei.df,fips=="24510")
sa.df <- aggregate(Emissions ~ type + year, data=s.df, sum)

library(ggplot2)

png("plot3.png")
ggplot(sa.df, aes(x = factor(year), y = Emissions)) +
    facet_wrap(~ type) +
    geom_bar(stat = "identity") +
    labs(title="Total Emissions, Baltimore City", x="year")
dev.off()
    
# Answer:
# Emissions from all types of sources have decreased EXCEPT for "POINT", which has increased
# slightly overall from 1999 to 2008, including a large spike in 2005.

#--------------------------------------------------------------------------------------------------
# Question 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#
# To filter for coal combustion-related sources, filter on SCC codes that contain "Combustion" in SCC.Level.One 
# and "coal" in SCC.Level.Three.
scc.coal <- subset(scc.df, grepl("Combustion",SCC.Level.One) & grepl("coal",SCC.Level.Three,ignore.case=T), select=c(SCC,SCC.Level.One,SCC.Level.Three))
nei.coal <- subset(nei.df, SCC %in% scc.coal$SCC)
a.df <- aggregate(Emissions ~ year, data=nei.coal, sum)
    
png("plot4.png")
barplot(a.df$Emissions,names.arg=as.character(a.df$year),ylab="Emissions",main="Coal Combustion Emissions")
dev.off()

# Answer:
# Coal combustion emissions were mostly unchanged from 1999 to 2005, but then dropped significantly in 2008.
#

#--------------------------------------------------------------------------------------------------
# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
# To filter for motor vehical sources, filter on SCC codes that contain "Mobile Sources" in SCC.Level.One
scc.mv <- subset(scc.df, grepl("Mobile Sources",SCC.Level.One), select=c(SCC,SCC.Level.One))
nei.balt.mv <- subset(nei.df, fips=="24510" & SCC %in% scc.mv$SCC)
a.df <- aggregate(Emissions ~ year, data=nei.balt.mv, sum)

png("plot5.png")
barplot(a.df$Emissions,names.arg=as.character(a.df$year),ylab="Emissions",main="Motor Vehicle Emissions, Baltimore City")
dev.off()

# Answer:
# Motor vehicle Emissions in Baltimore City dropped significantly between 1999 and 2002.  They remained
# relatively unchanged between 2002 and 2008, with a slight increase in 2008.

#--------------------------------------------------------------------------------------------------
# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
#
# To filter for motor vehical sources, filter on SCC codes that contain "Mobile Sources" in SCC.Level.One
scc.mv <- subset(scc.df, grepl("Mobile Sources",SCC.Level.One), select=c(SCC,SCC.Level.One))

nei.mv <- subset(nei.df, (fips %in% c("24510","06037") & SCC %in% scc.mv$SCC))
a.df <- aggregate(Emissions ~ fips + year, data=nei.mv, sum)
a.df <- mutate(a.df, county=ifelse(fips=="06037","Los Angeles County","Baltimore City"))

library(ggplot2)

png("plot6.png")
ggplot(a.df, aes(x = factor(year), y = Emissions)) + 
      facet_wrap(~ county) + 
      geom_bar(stat = "identity") + 
      labs(title="Motor Vehicle Emissions", x="year")
dev.off()

# Answer:
# In absolute terms, Los Angeles County has seen greater changes over time. In relative terms,
# Baltimore City has seen greater changes.  This is due to the fact Baltimore City has far 
# less motor vehicle emissions (80% to 95% less) than Los Angeles County.

