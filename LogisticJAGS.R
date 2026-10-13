## Growth Model
model {
  # Priors
  K     ~ dgamma(0.001, 0.001)
  r     ~ dgamma(0.001, 0.001)
  sigma ~ dunif(0, 2)
  tau  <- 1 / sigma^2      # precision from SD

  # Likelihood
  for (i in 1:n) {
    mu[i] <- r - r / K * x[i]
    y[i] ~ dnorm(mu[i], tau)
  }
}
