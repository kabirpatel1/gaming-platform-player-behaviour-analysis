# Load the single-player dataset
single <- read.csv("SinglePlayer_Data.csv")

# Filter impatient players (Played == 0) and keep only those with abandonment times recorded
impatient <- subset(single, Played == 0 & !is.na(AbandonmentTime))

# Histogram of queue times before leaving
png("hist_queue_impatient.png", width = 800, height = 600)
hist(impatient$AbandonmentTime,
     breaks = 20,
     main   = "Histogram of Queue Times for Impatient Players",
     xlab   = "Queue Time before Leaving",
     ylab   = "Frequency",
     border = "black")
dev.off()

# Also print to RStudio plots window
hist(impatient$AbandonmentTime,
     breaks = 20,
     main   = "Histogram of Queue Times for Impatient Players",
     xlab   = "Queue Time before Leaving",
     ylab   = "Frequency",
     border = "black")

# Quick summary of queue times
summary(impatient$AbandonmentTime)

