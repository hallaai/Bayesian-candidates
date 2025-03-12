library(stats)

# Observed data
votes <- c(Candidate_A = 45, Candidate_B = 55)
sample_size <- c(Candidate_A = 100, Candidate_B = 100)

# Prior parameters (non-informative prior Beta(1, 1))
alpha_prior <- 1
beta_prior <- 1

# Posterior parameters
posterior_params <- list()
for (candidate in names(votes)) {
  y <- votes[candidate]
  n <- sample_size[candidate]
  posterior_params[[candidate]] <- list(
    alpha = alpha_prior + y,
    beta = beta_prior + n - y
  )
}

# Function to calculate credible interval
credible_interval <- function(alpha, beta, confidence = 0.95) {
  lower <- qbeta((1 - confidence) / 2, alpha, beta)
  upper <- qbeta(1 - (1 - confidence) / 2, alpha, beta)
  return(c(lower, upper))
}

# Calculate credible intervals
credible_intervals <- lapply(posterior_params, function(param) {
  credible_interval(param$alpha, param$beta)
})

# Print credible intervals
cat("Credible Intervals:\n")
for (candidate in names(credible_intervals)) {
  cat(candidate, ": ", credible_intervals[[candidate]], "\n", sep = "")
}

# Probability of one candidate overtaking another
prob_overtake <- function(candidate_a, candidate_b, posterior_params, num_samples = 100000) {
  samples_a <- rbeta(num_samples, posterior_params[[candidate_a]]$alpha, posterior_params[[candidate_a]]$beta)
  samples_b <- rbeta(num_samples, posterior_params[[candidate_b]]$alpha, posterior_params[[candidate_b]]$beta)
  prob <- mean(samples_a > samples_b)
  return(prob)
}

# Calculate probability of Candidate A overtaking Candidate B
prob_A_beats_B <- prob_overtake("Candidate_A", "Candidate_B", posterior_params)
cat("Probability that Candidate A beats Candidate B:", round(prob_A_beats_B, 4), "\n")
