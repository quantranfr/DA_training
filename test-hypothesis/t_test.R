library(tidyverse)

setwd("/Users/quan/code/DA training/satisfaction")
data <- read_csv("../raw/satisfaction.csv")

# Calculate average satisfaction for each employee
avg_satisfaction <- data %>%
  group_by(Employee) %>%
  summarise(Avg_Satisfaction = mean(Customer_Satisfaction))

# Plotting a bar graph for average satisfaction by employee
ggplot(avg_satisfaction, aes(x = Employee, y = Avg_Satisfaction)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  labs(x = "Employee", y = "Average Customer Satisfaction", title = "Average Customer Satisfaction by Employee") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

# Filter data for Employee 1 and Employee 2
employee_4 <- data %>%
  filter(Employee == "Employee_4")

employee_2 <- data %>%
  filter(Employee == "Employee_2")

# Perform t-test
t_test_result <- t.test(employee_4$Customer_Satisfaction, employee_2$Customer_Satisfaction)

# Print t-test result
print(t_test_result)


# Perform ANOVA test
anova_result <- aov(Customer_Satisfaction ~ Employee, data = data)

# Summary of ANOVA results
summary(anova_result)
