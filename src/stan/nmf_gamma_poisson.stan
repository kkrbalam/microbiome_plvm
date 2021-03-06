/*
 * Nonnegative Matrix Factorization usinga Gamma-Poisson Model
 *
 * reference:https://arxiv.org/pdf/1506.03431.pdf
 */

data{
  int<lower=0> N;
  int<lower=0> P;
  int<lower=0> K;
  int<lower=0> y[N, P];
}

parameters{
  vector<lower=0>[4] prior_params; // prior parameters
  vector<lower=0>[K] theta[N]; // scores
  vector<lower=0>[K] beta[P]; // latent factors
}

model{
  for(i in 1:N) {
    theta[i] ~ gamma(prior_params[1], prior_params[2]); // componentwise gamma
  }

  for (j in 1:P) {
    beta[j] ~ gamma(prior_params[3], prior_params[4]);//componentwise gamma
  }

  for (i in 1:N) {
    for (j in 1:P) {
      y[i, j] ~ poisson(theta[i]' * beta[j]);
    }
  }
}
