# Bayesian-candidates

# Bayesian Approach to Calculate Confidence Intervals for Election Results

When dealing with small sample sizes or incomplete data, a **Bayesian approach** can be particularly useful because it allows us to incorporate prior knowledge (or assumptions) about the election results into the analysis. This is especially relevant when classical frequentist methods fail due to insufficient data.

## Problem Setup:

- **Objective**: Estimate the probability of each of 2 candidate winning an election.
- **Data Availability**: Limited data (e.g., partial vote counts or small sample sizes).
- **Goal**: Calculate credible intervals (Bayesian analog of confidence intervals) for the proportion of votes each candidate receives.

## Bayesian Model:

1. **Likelihood**: Assume the observed vote counts follow a **binomial distribution**:

   ![Likelihood - Binomial distribution](images/1Binomial.png)

where:
- ![yi](images/yi.png) is the number of votes observed for candidate `i`,
- ![ni](images/ni.png) is the total number of votes sampled for candidate `i`,
- ![pi](images/pi.png) is the unknown proportion of votes for candidate `i`.

2. **Prior**: Use a **Beta distribution** as the prior for ![pi](images/pi.png), which is conjugate to the binomial likelihood:
   
   ![Beta distribution as the prior for pi, which is conjugate to the binomial likelihood](images/2Beta.png)

Here, ![ai](images/ai.png) and ![bi](images/bi.png) represent prior beliefs about the proportion of votes for candidate `i`. For example:
- If no prior information is available, use a non-informative prior like `Beta(1, 1)` (uniform distribution).
- If you have prior knowledge (e.g., historical data), set ![ai](images/ai.png) and ![bi](images/bi.png) accordingly.

3. **Posterior**: The posterior distribution for ![pi](images/pi.png) is also a Beta distribution:

   ![posterior distribution for pi](images/3Beta.png)

4. **Credible Interval**: Compute the credible interval (e.g., 95%) from the posterior distribution of `p_i`. This interval reflects the range of plausible values for `p_i` given the observed data and prior beliefs.

5. **Reversal of Winner**: To determine the probability that one candidate overtakes another, compute:
   
   ![probability of first candidate wining the second one](images/probability_integrated.png)

## Multiple candidates. Two rounds
Exit pull results:
- **Candidate A**: 25 votes
- **Candidate B**: 30 votes
- **Candidate C**: 20 votes
- **Candidate D**: 15 votes
- **Candidate E**: 10 votes

### Problem Setup:
**Objective** : Estimate the probability of each candidate winning an election or passing to the second round if no candidate gets more than 50% of the votes.<br>
**Data Availability** : Limited data (e.g., partial vote counts or small sample sizes).<br>
**Goal** : Calculate credible intervals for the proportion of votes each candidate receives and determine the probabilities of winning or passing to the second round.
