# 2 x 2 Table, Risk Ratio, Odds Ratio, Chi-Squared Test

Use this when the question asks for a contingency table, risk ratio, odds ratio, or a test of independence for two binary variables.

## R Template

```r
tab <- table(exposure, outcome)
tab

event_col <- if ("1" %in% colnames(tab)) "1" else colnames(tab)[ncol(tab)]
nonevent_col <- setdiff(colnames(tab), event_col)[1]

risk <- tab[, event_col] / rowSums(tab)
odds <- tab[, event_col] / tab[, nonevent_col]

risk_ratio <- risk[2] / risk[1]
odds_ratio <- odds[2] / odds[1]

risk
odds
c(risk_ratio = risk_ratio, odds_ratio = odds_ratio)

chisq.test(tab, correct = FALSE)
```

## If Labels Are Text

```r
tab <- table(group, disease)
event_col <- if ("CHD" %in% colnames(tab)) "CHD" else colnames(tab)[ncol(tab)]
```

## Answer Pattern

Report the contingency table first.

Say what the reference group is before reporting the risk ratio and odds ratio.

Interpret a ratio above 1 as higher risk or odds in the numerator group, and below 1 as lower risk or odds.

Use the chi-squared p-value to conclude whether the variables appear independent.
