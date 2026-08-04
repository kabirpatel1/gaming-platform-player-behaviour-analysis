# Load data
multi <- read.csv("Multiplayer_Data.csv")
single <- read.csv("SinglePlayer_Data.csv")

# Keep only single-player rows where Played == 1
single_played <- subset(single, Played == 1)

# Combine enjoyment and spending from both datasets
enjoyment_all <- c(multi$Enjoyment, single_played$Enjoyment)
spending_all  <- c(multi$Spending, single_played$Spending)

# Histogram of Player Enjoyment
png("hist_enjoyment.png", width = 800, height = 600)
hist(enjoyment_all,
     breaks = 10,
     main = "Histogram of Player Enjoyment",
     xlab  = "Enjoyment (1–10)",
     ylab  = "Frequency",
     border = "black")
dev.off()

# Histogram of Player Spending
png("hist_spending.png", width = 800, height = 600)
hist(spending_all,
     breaks = 20,
     main = "Histogram of Player Spending",
     xlab  = "Spending",
     ylab  = "Frequency",
     border = "black")
dev.off()


