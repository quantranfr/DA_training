# Load required library
library(tidyverse)

# Read the CSV file
setwd('/Users/quan/code/DA training/score')
data <- read.csv("../raw/diem_thi_thpt_2023.csv", colClasses = c(sbd = "character"))

# get the province code by extracting the first two characters of the sbd column, then convert to int
data$province <- substr(data$sbd, 1, 2) %>% as.integer()

# average maths scores grouped by province, sort by score
math_avg <- data %>%
  group_by(province) %>%
  summarise(avg = mean(toan, na.rm = TRUE)) %>%
  arrange(desc(avg))

# Read province data (id_province & name_province)
provinces <- read.csv("../raw/provinces.csv")

# replace the province code with the province name using tidyverse
math_avg <- math_avg %>%
  left_join(provinces, by = c("province" = "id_province"))


