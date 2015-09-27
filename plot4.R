#setwd ("C:/Github/ExData_Plotting2")
library (dplyr, ggplot2)

# load data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file (file_url, "data.zip")
unzip ("data.zip")
data <- readRDS ("summarySCC_PM25.rds")
scc  <- readRDS ("Source_Classification_Code.rds")

# transform data
coalSCC <- as.character (scc [grepl ("coal.*combustion|combustion.*coal", 
                                     scc$Short.Name, ignore.case = T), "SCC"])
years <- data %>% 
         filter (SCC %in% coalSCC) %>%
         group_by (year) %>%
         summarize (sum_by_year = sum (Emissions))
         

# plot data
png ("plot4.png", width = 640, height = 480)
q <- qplot (year, sum_by_year, data = years, geom = "line",
            xlab = "date, year", ylab = "Emission, tons",
            main = "Coal combustion PM2.5 Emissions in US")
q <- q + theme_bw()
print (q)
dev.off()
