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
         group_by (year) %>%
         summarize (sum_by_year = sum (Emissions)) %>%
         mutate (sum_by_year = sum_by_year / 1000)

# plot data
png ("plot1.png", width = 640, height = 480)
plot (years, xlab = "date, year", ylab = "Emission, megatons", type = "l", 
      main = "PM2.5 Emissions")
dev.off()