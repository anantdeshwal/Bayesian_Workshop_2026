library(rjags)
library(MCMCvis)

# read in simulated data
pgrowth_data <- read.csv("PlantGrowth/plantgrowth_simdata.csv")

# Initial values for 3 chains
inits = list(
  list(beta0 = 5, beta_temp = .8, beta_precip = 0.02,  sigma = 3),
  list(beta0 = 10, beta_temp = .5, beta_precip = 0.01,  sigma = 5),
  list(beta0 = 2, beta_temp = 1.2, beta_precip = 0.04,  sigma = 2)
  )

# Data
plantgrowth_data <- list(
  N = nrow(pgrowth_data),
  plant_height = pgrowth_data$plant_height,
  temperature = pgrowth_data$temperature,
  rainfall = pgrowth_data$rainfall
)

n.adapt = 1000
n.update = 10000
n.iter = 10000

# Call to JAGS
set.seed(123)
pgrowth_jm = jags.model("PlantGrowth/PlantGrowth_JAGS.R", data = plantgrowth_data, inits = inits,
                n.chains = length(inits), n.adapt = n.adapt)
update(pgrowth_jm, n.iter = n.update)

# Sample posterior
pgrowth_zm = coda.samples(pgrowth_jm, variable.names = c("beta0", "beta_temp", "beta_precip", "sigma"),
                  n.iter = n.iter, thin = 1)  

# Summarize posterior
MCMCsummary(pgrowth_zm, round = 3)

# Check convergence
MCMCtrace(pgrowth_zm, Rhat = TRUE,
          n.eff = TRUE, pdf = FALSE)

# Visualize posterior estimates
MCMCplot(pgrowth_zm)
