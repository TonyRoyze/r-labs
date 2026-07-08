# HT and Hajek IPW Estimators

Use this when the question asks for Horvitz-Thompson, Hajek, propensity-score truncation, or bootstrap standard errors.

## R Template

```r
truncate_ps <- function(ps, lower, upper) {
  pmin(pmax(ps, lower), upper)
}

ht_estimator <- function(y, a, e) {
  mean(a * y / e - (1 - a) * y / (1 - e))
}

hajek_estimator <- function(y, a, e) {
  mu1 <- sum(a * y / e) / sum(a / e)
  mu0 <- sum((1 - a) * y / (1 - e)) / sum((1 - a) / (1 - e))
  mu1 - mu0
}

bootstrap_ipw <- function(data, ps_formula, lower, upper, B = 300) {
  ht_vals <- numeric(B)
  hajek_vals <- numeric(B)

  for (b in seq_len(B)) {
    idx <- sample.int(nrow(data), replace = TRUE)
    d <- data[idx, ]
    model <- glm(ps_formula, data = d, family = binomial())
    ps_b <- predict(model, type = "response")
    ps_b <- truncate_ps(ps_b, lower, upper)

    ht_vals[b] <- ht_estimator(d$BMI, d$School_meal, ps_b)
    hajek_vals[b] <- hajek_estimator(d$BMI, d$School_meal, ps_b)
  }

  data.frame(ht_se = sd(ht_vals), hajek_se = sd(hajek_vals))
}

ps_trunc <- truncate_ps(ps, 0.05, 0.95)
ht_estimator(y, a, ps_trunc)
hajek_estimator(y, a, ps_trunc)
bootstrap_ipw(nhanes, ps_formula, 0.05, 0.95, B = 200)
```

## Answer Pattern

Say the HT estimator uses raw inverse-probability weights.

Say the Hajek estimator normalizes the weights within treatment groups and is often more stable in finite samples.

If truncation is used, say it reduces instability from extreme propensity scores but changes the effective estimand slightly.
