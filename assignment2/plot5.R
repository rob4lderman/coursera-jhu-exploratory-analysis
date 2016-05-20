
# read the data
scc.df <- readRDS("data/Source_Classification_Code.rds")
nei.df <- readRDS("data/summarySCC_PM25.rds")

# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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


