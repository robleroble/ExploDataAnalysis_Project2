# run setup.R before running this script

# create table with only Baltimore City (county) data
baltCityNEI <- filter(NEI, fips==24510)

# create table grouped by year and type of pollution
grpdBaltCityNEI <- baltCityNEI %>%
  group_by(year, type) %>%
  summarize(Emissions=sum(Emissions))

# create ggplot w/data
g <- ggplot(grpdBaltCityNEI, aes(year, Emissions, color=type))

g + geom_point(size=3) + geom_smooth(method="lm", se=FALSE) + labs(x="Year", y="PM2.5 Emissions(tons)",
                                                             title="Change in PM2.5 Emissions by Type in Baltimore City, MD from 1999 - 2008")

# save plot as a png
dev.copy(png, "plot3.png", width=720, height=480)
dev.off()
