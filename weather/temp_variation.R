library(tidyverse)
library(corrplot)

setwd("/Users/quan/code/DA training/weather")
data <- read_csv("../raw/weather.csv")

# Define the desired order of wind directions
desired_order <- c("N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW")

# Convert 'wind_d' to a factor with desired levels and order
data$wind_d <- factor(data$wind_d, levels = desired_order)

hanoi_data_2009_02 <- data %>%
  filter(province == "Ha Noi" &
         lubridate::year(date) == 2009 &
         lubridate::month(date) == 2) %>%
  arrange(date) %>%
  mutate(mean_temp = (max + min) / 2)

plot1 <- ggplot(hanoi_data_2009_02, aes(x = date)) +
  geom_line(aes(y = max, color = "Max Temperature")) +
  geom_line(aes(y = mean_temp, color = "Mean Temperature")) +
  geom_line(aes(y = min, color = "Min Temperature")) +
  labs(x = "Date", y = "Temperature", color = "Legend") +
  scale_color_manual(values = c("Max Temperature" = "red",
                                "Mean Temperature" = "gray",
                                "Min Temperature" = "blue")) +
  ggtitle("Temperature Variation in Hanoi or Ha Noi") +
  theme_minimal()

# Calculate correlations between temperature and other variables
correlations <- cor(hanoi_data_2009_02[c("max", "min", "wind", "rain", "humidi", "cloud", "pressure")])

# Visualize correlations
plot2 <- corrplot(correlations, method = "color")

hanoi_data_20xx_02 <- data %>%
  filter(province == "Ha Noi" &
           # lubridate::year(date) == 2009 &
           lubridate::month(date) == 2) %>%
  arrange(date) %>%
  mutate(mean_temp = (max + min) / 2)

# Scatterplot to visualize temperature variation by wind direction
plot3 <- # 
  ggplot(hanoi_data_20xx_02, aes(x = wind_d, y = mean_temp)) +
  geom_jitter(width = 0.2, height = 0, alpha = 0.6) + # Jitter for better visibility
  labs(x = "Wind Direction", y = "Mean Temperature") +
  ggtitle("Temperature Variation by Wind Direction") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) # Rotate x-axis labels if needed

#---------------
