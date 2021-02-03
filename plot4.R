# run setup.R before running this script

# filter SCC to only include rows where EI.Sector contains "Coal"
coalSCC <- SCC %>%
  filter(grepl("Coal", EI.Sector))
         
# check if diff with short.name
shortNameSCC <- SCC %>%
  filter(grepl("Coal", Short.Name))
# Short.Name seems to have other non-coal uses in there - I'm sticking with 
# EI.Sector

# get list of SCC codes from coalSCC
coalSCCcodes <- pull(coalSCC, SCC)

# filter NEI based on SCC codes from coalSCCcodes
coalNEI <- NEI %>%
  filter(SCC %in% coalSCCcodes)

# create table with summed values w/aggregate
aggCoalNEI <- aggregate(coalNEI$Emissions, by=list(Year=coalNEI$year), FUN=sum)

# create ggplot w/data
g <- ggplot(aggCoalNEI, aes(Year, x))

g + geom_point() + geom_smooth(method="lm", se=FALSE) + labs(x="Year", y="PM2.5 Emissions(tons)"
                                                            , title="Change in PM2.5 Coal Combustion related emissions from 1999 to 2008")

# save plot as a png
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()
