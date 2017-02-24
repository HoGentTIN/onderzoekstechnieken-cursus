#! /usr/bin/env Rscript
# 
# This script illustrates the motivation for the formula for the variance and
# standard deviation of a sample, specifically why the denominator of (n-1)
# is used instead of n.
#
# Inspired by https://www.uvm.edu/~dhowell/SeeingStatisticsApplets/N-1.html

# First, let's define functions for population variance and standard
# deviation. These are not supported out-of-the-box in R.

# This function calculates the population variance
pop_var <- function(x) {
  mean <- sum(x) / length(x)
  1/length(x) * sum ((x - mean)^2)
}

# Population standard deviation
pop_sd <- function(x) {
  sqrt(pop_var(x))
}

# Let's say our population consists of the numbers 0 - 100
population <- 0:100

# First, we calculate the mean and standard deviation of the population
# µ = 50
population_mean <- sum(population) / length(population)
# σ² = 850
population_variance <- pop_var(population)
# σ ≈ 29.15
population_stdev <- pop_sd(population)

sprintf("Population mean    : %f", population_mean)
sprintf("Population variance: %f", population_variance)
sprintf("Population stdev   : %f", population_stdev)

# We will show that the formula with denominator (n-1) gives a better
# estimate of the actual population variance than denominator n.
#
# We will take random samples from the population, calculate the variance
# with both formulas, and see which one is closest to the actual value.

sample_size <- 15
num_samples <- 5000

pop_sample <- function(x) sample(population, sample_size)
samples <- lapply(1:num_samples, pop_sample)

print("Average estimations of population stdev:")
sprintf("Whichever is closest to %f, is the best estimator", population_stdev)

# First, let's calculate variances with the "population" formula: denominator n
results_pop_sd <- sapply(samples, pop_sd)
sprintf("denominator n  : %f", mean(results_pop_sd))

# Then, calculate varia
results_sample_sd <- sapply(samples, sd)
sprintf("denominator n-1: %f", mean(results_sample_sd))
