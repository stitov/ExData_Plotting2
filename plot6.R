#setwd ("C:/Github/ExData_Plotting2")
library (dplyr, ggplot2)

# load data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file (file_url, "data.zip")
unzip ("data.zip")
data <- readRDS ("summarySCC_PM25.rds")
scc  <- readRDS ("Source_Classification_Code.rds")

# transform data
motorSCC <- as.character (scc [grepl ("Mobile - On-Road", 
                                      scc$EI.Sector, ignore.case = T), "SCC"])
years <- data %>% 
         filter (fips == "24510" | fips == "06037", SCC %in% motorSCC, type == "ON-ROAD") %>%
         group_by (year, fips) %>%
         summarize (sum_by_year = sum (Emissions)) %>%
         mutate (fips = factor (fips, 
                 labels = c ("Baltimore City, Maryland", "Los Angeles, California")))

# plot data
png ("plot6.png", width = 640, height = 480)
q <- qplot (year, sum_by_year, data = years, geom = "line", col = fips,
            xlab = "date, year", ylab = "Emission, tons",
            main = "Motor vehicles PM2.5 Emissions")
q <- q + theme_bw()
print (q)
dev.off()
