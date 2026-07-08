# Instrumental Variables and 2SLS

Use this when the question asks for a 2SLS estimate, corrected residuals, a manual standard error, or a confidence interval for an IV effect.

## R Template

```r
card <- read.csv("card1995.csv", stringsAsFactors = FALSE)
card <- card[, !grepl("^Unnamed", names(card))]

controls <- c(
  "exper", "expersq", "black", "south", "smsa",
  "reg661", "reg662", "reg663", "reg664", "reg665",
  "reg666", "reg667", "reg668", "smsa66"
)

keep_vars <- c("lwage", "educ", "nearc4", controls)
card_iv <- na.omit(card[, keep_vars])

x_formula <- as.formula(
  paste("~ educ +", paste(controls, collapse = " + "))
)
z_formula <- as.formula(
  paste("~ nearc4 +", paste(controls, collapse = " + "))
)

y <- as.matrix(card_iv$lwage)
X <- model.matrix(x_formula, data = card_iv)
Z <- model.matrix(z_formula, data = card_iv)

Pz <- Z %*% solve(t(Z) %*% Z) %*% t(Z)
beta_2sls <- drop(solve(t(X) %*% Pz %*% X, t(X) %*% Pz %*% y))
beta_2sls

corrected_residuals <- drop(y - X %*% beta_2sls)

n <- nrow(X)
k <- ncol(X)
sigma2_hat <- sum(corrected_residuals^2) / (n - k)

vcov_2sls <- sigma2_hat * solve(t(X) %*% Pz %*% X)
se_2sls <- sqrt(diag(vcov_2sls))

estimate <- beta_2sls["educ"]
se <- se_2sls["educ"]
ci_95 <- c(lower = estimate - 1.96 * se, upper = estimate + 1.96 * se)

c(estimate = estimate, se = se, ci_95)
```

## Answer Pattern

Say the treatment is the endogenous regressor, the instrument shifts treatment, and the 2SLS coefficient on treatment is the IV effect estimate.

Report the corrected residuals as the stage-two residuals.

Then report the standard error and 95 percent confidence interval for the treatment coefficient.
