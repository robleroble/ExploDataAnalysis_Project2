# run setup.R before running this script

# filter SCC to only include rows where EI.Sector contains "Vehicle"
vehicleSCC <- SCC %>%
  filter(grepl("Vehicle", EI.Sector))

# get list of SCC codes from vehicleSCC
vehicleSCCcodes <- pull(vehicleSCC, SCC)


# filter NEI based on SCC codes from vehicleSCCcodes and fips codes for Balt City and LA
vehicleBaltLANEI <- NEI %>%
  filter(SCC %in% vehicleSCCcodes) %>%
  filter(fips == "24510" | fips == "06037")

# create table with summed values using aggregate
aggVehicleNEI <- aggregate(vehicleBaltLANEI$Emissions, by=list(Year=vehicleBaltLANEI$year, City=vehicleBaltLANEI$fips), FUN=sum)

# create ggplot
g <- ggplot(aggVehicleNEI, aes(Year, x, color=City))

g + geom_point() + geom_smooth(method="lm", se=FALSE) + 
  labs(x="Year", y="PM2.5 Emissions (tons)", title="Change in Vehicle-related PM2.5
       in Baltimore City and Los Angeles from 1999 to 2008") + scale_fill_discrete(name="City", labels=c("Los Angeles", "Baltimore City"))


# save plot as a png
dev.copy(png, "plot6.png", width=480, height=480)
dev.off()
