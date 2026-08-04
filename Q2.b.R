

dat <- read.csv("InterarrivalTimes.csv", header = TRUE)
x <- na.omit(dat[[1]])     # use the first column; adjust if your col name differs
n <- length(x)

## 2) Histogram (and save to file)
png("interarrival_histogram.png", width = 1200, height = 700, res = 150)
hist(x,
     breaks = "Sturges",
     main = "Histogram of Inter-arrival Times",
     xlab  = "Inter-arrival time",
     ylab  = "Frequency",
     border = "black") %>% 
  print()
dev.off()


## 3) Candidate distributions (parameter estimates)
m  <- mean(x)
m
sd <- sd(x)
sd

# Exponential MLE
lambda_hat <- 1 / m
lambda_hat


## 4) 
K <- 10                         # number of bins 10 
p <- 1:K / K                    # deciles (0.1,...,1.0) under H0

p[length(p)] <- 1 - 1e-8

# Exponential inverse-CDF: F^{-1}(u) = -log(1-u)/lambda
edges <- c(0, -log(1 - p) / lambda_hat)
edges
# Observed counts (Oi) and expected counts (Ei)
Oi <- as.numeric(table(cut(x, breaks = edges, include.lowest = TRUE, right = TRUE)))
Oi
Ei <- rep(n / K, K)
Ei

# Chi-squared statistic
chi2 <- sum((Oi - Ei)^2 / Ei)
chi2
# Degrees of freedom: K - 1 - (# estimated parameters) = 10 - 1 - 1 = 8
df  <- K - 1 - 1
df
crit <- qchisq(0.95, df = df)
crit
pval <- 1 - pchisq(chi2, df = df)
pval

## 5) Output Oi/Ei table and test summary
oi_ei <- data.frame(
  Bin   = 1:K,
  Lower = head(edges, -1),
  Upper = tail(edges, -1),
  Oi    = Oi,
  Ei    = Ei
)

print(oi_ei, row.names = FALSE, digits = 4)

