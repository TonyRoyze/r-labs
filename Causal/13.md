# Observational Binary Outcome Full Workflow

Use this when the question is a full observational-study workflow with:

- a binary or indicator-style outcome,
- a treatment indicator you need to construct,
- covariate balance checks,
- unadjusted and adjusted treatment effect estimates,
- propensity score estimation,
- Horvitz-Thompson and Hajek estimators,
- and a short justification about whether adjustment is needed.

This matches past-paper patterns like the Titanic question.

## R Template

```r
## Example: treatment is third-class cabin, outcome is survival
## Replace variable names to match the exam dataset.

titanic$treat <- ifelse(titanic$pclass == 3, 1, 0)

## Basic setup
outcome_var <- "survived"
treatment_var <- "treat"
covariates <- c("sex", "age")

## 1. Balance checks
t.test(age ~ treat, data = titanic)
chisq.test(table(titanic$treat, titanic$sex), correct = FALSE)

## 2. Unadjusted ATE / risk difference
ate_unadjusted <- with(
  titanic,
  mean(survived[treat == 1], na.rm = TRUE) -
    mean(survived[treat == 0], na.rm = TRUE)
)
ate_unadjusted

fit_unadjusted <- lm(survived ~ treat, data = titanic)
summary(fit_unadjusted)$coefficients["treat", ]

## 3. Adjusted ATE with regression
fit_adjusted <- lm(survived ~ treat + sex + age, data = titanic)
summary(fit_adjusted)
summary(fit_adjusted)$coefficients["treat", ]

## 4. Propensity score model
ps_model <- glm(treat ~ sex + age, data = titanic, family = binomial())
titanic$ps <- predict(ps_model, type = "response")
summary(titanic$ps)

## 5. HT and Hajek estimators
ht_estimator <- function(y, a, e) {
  mean(a * y / e - (1 - a) * y / (1 - e))
}

hajek_estimator <- function(y, a, e) {
  mu1 <- sum(a * y / e) / sum(a / e)
  mu0 <- sum((1 - a) * y / (1 - e)) / sum((1 - a) / (1 - e))
  mu1 - mu0
}

y <- titanic[[outcome_var]]
a <- titanic[[treatment_var]]
e <- titanic$ps

ht <- ht_estimator(y, a, e)
hajek <- hajek_estimator(y, a, e)

c(ate_unadjusted = ate_unadjusted, ht = ht, hajek = hajek)
```

## Generic Balance Pattern

```r
## Continuous covariate
t.test(x_continuous ~ treat, data = df)

## Binary or categorical covariate
chisq.test(table(df$treat, df$x_binary), correct = FALSE)
```

## Generic Regression Pattern

```r
summary(lm(outcome ~ treat, data = df))$coefficients["treat", ]
summary(lm(outcome ~ treat + x1 + x2 + x3, data = df))$coefficients["treat", ]
```

## Generic Propensity Score Pattern

```r
ps_model <- glm(treat ~ x1 + x2 + x3, data = df, family = binomial())
df$ps <- predict(ps_model, type = "response")
```

## Short Answer Pattern

```text
Because this is an observational setting, treatment was not randomly assigned. Therefore treated and untreated groups may differ systematically on pre-treatment covariates, so adjustment is appropriate to reduce confounding.
```

```text
The unadjusted estimate is a crude comparison of group means. The adjusted regression estimate and the propensity-score-based estimators attempt to account for observed covariate imbalance.
```

```text
If the outcome is binary, the difference in mean outcomes can be interpreted as a risk difference because the mean of a 0/1 outcome is the event probability.
```

## When To Use This Instead Of Smaller Snippets

Use this file when the exam asks for the whole workflow in one question.

Use the smaller snippets instead when the exam asks for only one component, such as only balance checking, only propensity scores, or only HT/Hajek.
