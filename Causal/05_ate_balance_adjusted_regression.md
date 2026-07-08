# Balance, Unadjusted ATE, Adjusted ATE

Use this when the question asks for covariate balance, outcome imputation, an unadjusted difference in means, or a covariate-adjusted treatment effect in an experiment.

## R Template

```r
star <- foreign::read.dta("star.dta")
star_sub <- subset(star, control == 1 | sfsp == 1)
star_sub$treat <- ifelse(star_sub$sfsp == 1, 1, 0)

mean_gpa <- mean(star_sub$GPA_year1, na.rm = TRUE)
star_sub$GPA_year1_imp <- ifelse(
  is.na(star_sub$GPA_year1),
  mean_gpa,
  star_sub$GPA_year1
)

table(star_sub$treat, star_sub$female)
chisq.test(table(star_sub$treat, star_sub$female), correct = FALSE)
t.test(gpa0 ~ treat, data = star_sub)

ate_unadjusted <- with(
  star_sub,
  mean(GPA_year1_imp[treat == 1]) - mean(GPA_year1_imp[treat == 0])
)

fit_unadjusted <- lm(GPA_year1_imp ~ treat, data = star_sub)
fit_adjusted <- lm(GPA_year1_imp ~ treat + female + gpa0, data = star_sub)

ate_unadjusted
summary(fit_unadjusted)$coefficients["treat", ]
summary(fit_adjusted)$coefficients["treat", ]
```

## Answer Pattern

Use chi-squared tests for binary covariates and t-tests for continuous covariates when discussing balance.

Say the unadjusted ATE is the difference in mean outcomes between treated and control groups.

Say the adjusted ATE is the treatment coefficient from the regression that controls for pre-treatment covariates.
