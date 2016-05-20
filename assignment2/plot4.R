
# read the data
scc.df <- readRDS("data/Source_Classification_Code.rds")
nei.df <- readRDS("data/summarySCC_PM25.rds")

# Question 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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


