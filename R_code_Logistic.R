
library(rjags)
library(MCMCvis)

# Simulated data 
Logistic <- read.csv("LogisticSim.csv")
Logistic <- Logistic[order(Logistic$PopulationSize), ] # To ensure our graphs look beautiful
head(Logistic)

# Initial Value for the three MCMC chains
inits = list(
  list(K = 1500, r = .2,  sigma = 1),
  list(K = 1000, r = .15, sigma = .1),
  list(K = 900,  r = .3,  sigma = .01))

data = list(
  n = nrow(Logistic),
  x = as.double(Logistic$PopulationSize),
  y = as.double(Logistic$GrowthRate))

n.adapt  = 1000
n.update = 10000
n.iter   = 10000

# Call to JAGS
set.seed(1)
jm = jags.model("LogisticJAGS.R", data = data, inits = inits,
                n.chains = length(inits), n.adapt = n.adapt)
update(jm, n.iter = n.update)
zm = coda.samples(jm, variable.names = c("K", "r", "sigma", "tau"),
                  n.iter = n.iter, thin = 1)   

# Check: 
MCMCsummary(zm, round = 3)
MCMCtrace(zm, params = c("K", "r", "sigma"), pdf = FALSE)
