# run setup.R before running this script

# create table with summed values w/aggregate
newNEI <- aggregate(NEI$Emissions, by=list(Year=NEI$year), FUN=sum)

# plot year and emissions
plot(newNEI$Year, newNEI$x, xlab="Year", ylab="PM2.5 emitted (tons)", main="Change in tons of PM2.5 emitted from 1999 to 2008")
# add red linear regression abline to show change
abline(lm(newNEI$x~newNEI$Year), col="red")

# save plot as a png
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()

