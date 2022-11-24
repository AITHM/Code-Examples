data {
  int K;
  int N;
  int D;
  int y[N];
  matrix[N, D] x;
  int N_test;
  matrix[N_test, D] x_test;
}
parameters {
  matrix[D, K] beta;
}
model {
  matrix[N, K] x_beta = x * beta;

  to_vector(beta) ~ normal(0, 5);

  for (n in 1:N) {
    y[n] ~ categorical_logit(x_beta[n]');
  }
}
generated quantities {
  vector[N_test] y_test;
  matrix[N_test, K] x_beta = x_test * beta;
  for(n in 1:N_test) {
    y_test[n] = categorical_logit_rng(x_beta[n]');
  }
}
