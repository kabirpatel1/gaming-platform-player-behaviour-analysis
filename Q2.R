# Load data
multi_data <- read.csv("Multiplayer_Data.csv")

# Function to compute mean and 95% CI
library(dplyr)

spending_ci <- multi_data %>%
  group_by(NumberBots) %>%
  summarise(
    Mean_Spending = mean(Spending, na.rm = TRUE),
    n = n(),
    SE = sd(Spending, na.rm = TRUE)/sqrt(n),
    .groups = "drop"
  ) %>%
  mutate(
    CI_Lower = Mean_Spending - qt(0.975, df = n-1) * SE,
    CI_Upper = Mean_Spending + qt(0.975, df = n-1) * SE
  ) %>%
  select(NumberBots, Mean_Spending, CI_Lower, CI_Upper, n)


print(spending_ci)


