# Causal Mediation

Use this when the question asks for a mediation DAG, direct and indirect effects, Sobel standard errors, or results from `mediation::mediate()`.

## R Template

```r
library(mediation)
library(sandwich)

data(jobs, package = "mediation")

vars <- c(
  "treat", "depress2", "job_seek", "econ_hard", "depress1",
  "sex", "age", "occp", "marital", "nonwhite", "educ", "income"
)

jobs2 <- na.omit(jobs[, vars])

med_model <- lm(
  job_seek ~ treat + econ_hard + depress1 + sex + age + occp + marital + nonwhite + educ + income,
  data = jobs2
)

out_model <- lm(
  depress2 ~ treat + job_seek + econ_hard + depress1 + sex + age + occp + marital + nonwhite + educ + income,
  data = jobs2
)

alpha_1 <- coef(med_model)["treat"]
beta_1 <- coef(out_model)["treat"]
beta_2 <- coef(out_model)["job_seek"]

nde_hat <- beta_1
nie_hat <- alpha_1 * beta_2

vcov_med <- sandwich::vcovHC(med_model, type = "HC1")
vcov_out <- sandwich::vcovHC(out_model, type = "HC1")

se_nde <- sqrt(vcov_out["treat", "treat"])
se_nie <- sqrt(
  beta_2^2 * vcov_med["treat", "treat"] +
  alpha_1^2 * vcov_out["job_seek", "job_seek"]
)

ci_nde <- c(lower = nde_hat - 1.96 * se_nde, upper = nde_hat + 1.96 * se_nde)
ci_nie <- c(lower = nie_hat - 1.96 * se_nie, upper = nie_hat + 1.96 * se_nie)

mediate_fit <- mediate(
  model.m = med_model,
  model.y = out_model,
  treat = "treat",
  mediator = "job_seek",
  boot = TRUE,
  sims = 1000
)

list(
  NDE = c(estimate = nde_hat, se = se_nde, ci_95 = ci_nde),
  NIE = c(estimate = nie_hat, se = se_nie, ci_95 = ci_nie)
)

summary(mediate_fit)
```

## DAG Pattern

```text
treat  ----->  outcome
  |             ^
  v             |
mediator  ------+

baseline covariates -> mediator
baseline covariates -> outcome
```

## Answer Pattern

Say the natural direct effect is the effect not transmitted through the mediator.

Say the natural indirect effect is the part transmitted through the mediator.

Compare the Baron-Kenny and Sobel calculations with the bootstrap output from `mediate()`.
