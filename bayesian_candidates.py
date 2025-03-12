import numpy as np
from scipy.stats import beta

# Observed data: Number of votes for each candidate and total votes sampled
votes = {'Candidate_A': 45, 'Candidate_B': 55}
sample_size = {'Candidate_A': 100, 'Candidate_B': 100}

# Prior parameters (non-informative prior Beta(1, 1))
alpha_prior = 1
beta_prior = 1

# Posterior parameters
posterior_params = {}
for candidate in votes:
    y = votes[candidate]
    n = sample_size[candidate]
    posterior_params[candidate] = {
        'alpha': alpha_prior + y,
        'beta': beta_prior + n - y
    }

# Function to calculate credible interval
def credible_interval(alpha, beta, confidence=0.95):
    lower = beta.ppf((1 - confidence) / 2, alpha, beta)
    upper = beta.ppf(1 - (1 - confidence) / 2, alpha, beta)
    return lower, upper

# Calculate credible intervals
credible_intervals = {}
for candidate, params in posterior_params.items():
    credible_intervals[candidate] = credible_interval(params['alpha'], params['beta'])

# Print credible intervals
print("Credible Intervals:")
for candidate, interval in credible_intervals.items():
    print(f"{candidate}: {interval}")

# Probability of one candidate overtaking another
def prob_overtake(candidate_a, candidate_b, posterior_params, num_samples=100000):
    samples_a = np.random.beta(posterior_params[candidate_a]['alpha'], posterior_params[candidate_a]['beta'], num_samples)
    samples_b = np.random.beta(posterior_params[candidate_b]['alpha'], posterior_params[candidate_b]['beta'], num_samples)
    prob = np.mean(samples_a > samples_b)
    return prob

# Calculate probability of Candidate A overtaking Candidate B
prob_A_beats_B = prob_overtake('Candidate_A', 'Candidate_B', posterior_params)
print(f"Probability that Candidate A beats Candidate B: {prob_A_beats_B:.4f}")