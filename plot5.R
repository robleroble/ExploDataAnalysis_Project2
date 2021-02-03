# run setup.R before running this script

# filter SCC to only include rows where EI.Sector contains "Vehicle"
vehicleSCC <- SCC %>%
  filter(grepl("Vehicle", EI.Sector))

# get list of SCC codes from vehicleSCC
vehicleSCCcodes <- pull(vehicleSCC, SCC)


# filter NEI based on SCC codes from vehicleSCCcodes and fips code for Baltimore City
vehicleBaltNEI <- NEI %>%
  filter(SCC %in% vehicleSCCcodes) %>%
  filter(fips == 24510)

# create table with summed values using aggregate
aggVehicleBaltNEI <- aggregate(vehicleBaltNEI$Emissions, by=list(Year=vehicleBaltNEI$year), FUN=sum)

# create ggplot with data
g <- ggplot(aggVehicleBaltNEI, aes(Year, x))

g + geom_point() + geom_smooth(method="lm", se=FALSE) +
  labs(x="Year", y="PM2.5 Emissions (tons)", title="Change in PM2.5 Vehicle-Related emissions in Baltimore City from 1999 to 2008")

# save plot as a png
dev.copy(png, "plot5.png", width=720, height=480)
dev.off()
