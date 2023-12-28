library(tidyverse)

setwd("/Users/quan/code/DA training/weather")
data <- read_csv("../raw/weather.csv")

pivot_table <- data %>%
  count(province, wind_d) %>%
  pivot_wider(names_from = wind_d, values_from = n, values_fill = 0)

write.csv(pivot_table, 'pivot_table.csv', row.names = FALSE)
