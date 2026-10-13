
model {
  
  # -------------------------
  # 1. PRIORS
  # -------------------------
  beta0 ~ dnorm(0, 0.0025)
  beta_temp ~ dnorm(0, 0.04)
  beta_precip ~ dnorm(0, 100)
  
  sigma ~ dunif(0, 20)
  # Convert standard deviation to precision
  tau <- 1 / (sigma * sigma)

  # -------------------------
  # 2. LIKELIHOOD
  # -------------------------
  for (i in 1:N) {
    plant_height[i] ~ dnorm(mu[i], tau)
    mu[i] <- beta0 +
             beta_temp * temperature[i] +
             beta_precip * rainfall[i]
  }
}
