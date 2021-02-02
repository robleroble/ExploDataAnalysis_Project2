# run setup.R before running this script

# create table with only Baltimore City (county) data
baltCityNEI <- filter(NEI, fips==24510)

# create table with summed values w/aggregate
aggBaltCityNEI <- aggregate(baltCityNEI$Emissions, by=list(Year=baltCityNEI$year), FUN=sum)

# plot year and emissions
plot(aggBaltCityNEI$Year, aggBaltCityNEI$x, xlab="Year", ylab="PM2.5 emitted (tons)", 
     main=paste(strwrap(
       "Change in tons of PM2.5 emitted from 1999 to 2008 in Baltimore City, MD",
       width=40
       )       ))
# add red linear regression abline to show change
abline(lm(aggBaltCityNEI$x~aggBaltCityNEI$Year), col="red")

# save plot as a png
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
