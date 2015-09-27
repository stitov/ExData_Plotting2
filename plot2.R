#setwd ("C:/Github/ExData_Plotting2")
library (dplyr)

# load data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file (file_url, "data.zip")
unzip ("data.zip")
data <- readRDS ("summarySCC_PM25.rds")
scc  <- readRDS ("Source_Classification_Code.rds")

# transform data
years <- data %>% 
         filter (fips == "24510") %>%
         group_by (year) %>%
         summarize (sum_by_year = sum (Emissions))

# plot data
png ("plot2.png", width = 640, height = 480)
plot (years, xlab = "date, year", ylab = "Emission, tons", type = "l", 
      main = "PM2.5 Emissions in Baltimore City, Maryland")
dev.off()