
# read the data
scc.df <- readRDS("data/Source_Classification_Code.rds")
nei.df <- readRDS("data/summarySCC_PM25.rds")

# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# To filter for motor vehical sources, filter on SCC codes that contain "Mobile Sources" in SCC.Level.One
scc.mv <- subset(scc.df, grepl("Mobile Sources",SCC.Level.One), select=c(SCC,SCC.Level.One))

nei.mv <- subset(nei.df, (fips %in% c("24510","06037") & SCC %in% scc.mv$SCC))
a.df <- aggregate(Emissions ~ fips + year, data=nei.mv, sum)

library(dplyr)
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
# less motor vehicle emissions (roughly 80-95% less) than Los Angeles County, so the changes in
# Baltimore data are relatively large compared to those in LA.

