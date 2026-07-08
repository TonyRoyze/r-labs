# Monte Carlo Permutation Inference

Use this when the question asks for a permutation distribution, Monte Carlo p-value, t-statistic randomization test, or comparison with an asymptotic p-value.

## R Template

```r
library(Matching)
data(lalonde, package = "Matching")

diff_in_means <- function(y, z) {
  mean(y[z == 1]) - mean(y[z == 0])
}

equal_var_t <- function(y, z) {
  y1 <- y[z == 1]
  y0 <- y[z == 0]
  n1 <- length(y1)
  n0 <- length(y0)
  sp2 <- ((n1 - 1) * var(y1) + (n0 - 1) * var(y0)) / (n1 + n0 - 2)
  (mean(y1) - mean(y0)) / sqrt(sp2 * (1 / n1 + 1 / n0))
}

set.seed(4005)
B <- 10000

ate_obs <- diff_in_means(lalonde$re78, lalonde$treat)
t_obs <- equal_var_t(lalonde$re78, lalonde$treat)

perm_dim <- replicate(B, {
  z_perm <- sample(lalonde$treat)
  diff_in_means(lalonde$re78, z_perm)
})

perm_t <- replicate(B, {
  z_perm <- sample(lalonde$treat)
  equal_var_t(lalonde$re78, z_perm)
})

p_dim <- mean(abs(perm_dim) >= abs(ate_obs))
p_t <- mean(abs(perm_t) >= abs(t_obs))
p_asymptotic <- 2 * pnorm(-abs(t_obs))

c(p_dim = p_dim, p_t = p_t, p_asymptotic = p_asymptotic)
```

## Answer Pattern

Say the permutation distribution respects the random assignment mechanism by shuffling the treatment labels.

Report Monte Carlo p-values as proportions of simulated statistics at least as extreme as the observed statistic.

If p-values differ, mention finite-sample exactness versus asymptotic approximation, choice of statistic, simulation error, and skewed outcome distributions.
