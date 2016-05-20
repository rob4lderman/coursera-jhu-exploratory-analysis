
# read the data
nei.df <- readRDS("data/summarySCC_PM25.rds")

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

