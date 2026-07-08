# Propensity Score Stratification

Use this when the question asks for estimated propensity scores, `K` strata, a stratified ATE, or a general function for propensity-score stratification.

## R Template

```r
nhanes <- read.csv("nhanes_bmi.csv", stringsAsFactors = FALSE)
nhanes <- nhanes[, !grepl("^Unnamed", names(nhanes))]

covariates <- c(
  "age", "ChildSex", "black", "mexam", "pir200_plus", "WIC",
  "Food_Stamp", "fsdchbi", "AnyIns", "RefSex", "RefAge"
)

ps_formula <- as.formula(
  paste("School_meal ~", paste(covariates, collapse = " + "))
)

ps_model <- glm(ps_formula, data = nhanes, family = binomial())
nhanes$ps <- predict(ps_model, type = "response")

make_ps_strata <- function(ps, K) {
  probs <- seq(0, 1, length.out = K + 1)
  breaks <- unique(quantile(ps, probs = probs, na.rm = TRUE))
  cut(ps, breaks = breaks, include.lowest = TRUE, labels = FALSE)
}

stratified_ate <- function(y, a, strata) {
  df <- data.frame(y = y, a = a, strata = strata)

  safe_var_term <- function(values) {
    if (length(values) <= 1) return(0)
    var(values) / length(values)
  }

  pieces <- lapply(split(df, df$strata), function(d) {
    n1 <- sum(d$a == 1)
    n0 <- sum(d$a == 0)
    if (n1 == 0 || n0 == 0) return(NULL)
    data.frame(
      n = nrow(d),
      tau_s = mean(d$y[d$a == 1]) - mean(d$y[d$a == 0]),
      var_s = safe_var_term(d$y[d$a == 1]) + safe_var_term(d$y[d$a == 0])
    )
  })

  pieces <- do.call(rbind, pieces)
  w <- pieces$n / sum(pieces$n)

  list(
    estimate = sum(w * pieces$tau_s),
    se = sqrt(sum((w^2) * pieces$var_s)),
    details = pieces
  )
}

nhanes$strata_5 <- make_ps_strata(nhanes$ps, 5)
stratified_ate(nhanes$BMI, nhanes$School_meal, nhanes$strata_5)
```

## Answer Pattern

Say the propensity score is the estimated probability of treatment given observed covariates.

Say the stratified ATE is a weighted average of within-stratum treatment-control mean differences.

If the question asks to compare multiple `K` values, mention the bias-variance tradeoff between coarse and very fine stratification.
