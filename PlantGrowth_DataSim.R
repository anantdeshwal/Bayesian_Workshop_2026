## This code will generate some data for plant growth as a function of temperature and Precipitation
library(ggplot2)

# Set working directory
setwd("C:/Users/f005c0j/Desktop/delet after sending/Bayesian Workshop")

# 1. Simulate ecological data
set.seed(123)

# Number of grassland plots
n <- 100

# Environmental predictors
temperature <- runif(n, min = 10, max = 30) #between 10-30C
rainfall <- runif(n, min = 100, max = 1000) #between 100-1000 mm

# True regression parameters
beta0 <- 5
beta_temp <- 0.8
beta_precip <- 0.02
sigma_true <- 3

# Expected plant height
mu <- beta0 + beta_temp * temperature + beta_precip * rainfall

# Simulate observed plant height
plant_height <- rnorm(n, mean = mu, sd = sigma_true)

# Create a data frame
pgrowth_data <- data.frame(
  plant_height = plant_height,
  temperature = temperature,
  rainfall = rainfall
)

# Inspect data
head(pgrowth_data)

# Save for later use
write.csv(pgrowth_data, "PlantGrowth/plantgrowth_simdata.csv",
          row.names = FALSE)
          
# Visulaize Data if needed
# library(ggplot2)
# 
# ggplot(pgrowth_data, aes(x = temperature, y = plant_height,
#                      colour = rainfall)) +
#   geom_point(size = 2.5) +
#   scale_colour_viridis_c() +
#   theme_classic() +
#   labs(
#     x = "Temperature (°C)",
#     y = "Plant height (cm)",
#     colour = "Rainfall (mm)"
#   )

