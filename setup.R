# install dplyr
install.packages("dplyr")
library(dplyr)

# install ggplot2
install.packages("ggplot2")
library(ggplot2)

# download data
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile="airqualitydata.zip")

# unzip data
unzip(zipfile="airqualitydata.zip")

# load data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
