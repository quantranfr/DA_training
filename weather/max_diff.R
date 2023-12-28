library(tidyverse)

setwd("/Users/quan/code/DA training/weather")
weather <- read_csv("../raw/weather.csv")

weather_summary <- weather %>% 
  group_by(province) %>% 
  summarise(max_of_max = max(max),
            min_of_min = min(min)) %>% 
  mutate(max_diff = max_of_max - min_of_min) %>% 
  arrange(desc(max_diff))

my_plot <- ggplot(weather_summary,
       aes(x = max_diff,
           y = fct_reorder(province, max_diff))) +
  geom_col()
