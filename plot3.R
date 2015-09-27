#setwd ("C:/Github/ExData_Plotting2")
library (dplyr, ggplot2)

# load data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file (file_url, "data.zip")
unzip ("data.zip")
data <- readRDS ("summarySCC_PM25.rds")
scc  <- readRDS ("Source_Classification_Code.rds")

# transform data
years <- data %>% 
         filter (fips == "24510") %>%
         group_by (year, type) %>%
         summarize (sum_by_year = sum (Emissions)) %>%
         mutate (type = as.factor (type))

# plot data
png ("plot3.png", width = 640, height = 480)
q <- qplot (year, sum_by_year, data = years, color = type, geom = "line",
            xlab = "date, year", ylab = "Emission, tons",
            main = "PM2.5 Emissions by type in Baltimore City, Maryland")
q <- q + theme_bw()
print (q)
dev.off()